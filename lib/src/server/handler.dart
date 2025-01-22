// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';
import 'dart:convert';

import 'package:http2/transport.dart';

import '../shared/codec.dart';
import '../shared/codec_registry.dart';
import '../shared/io_bits/io_bits.dart' show InternetAddress, X509Certificate;
import '../shared/message.dart';
import '../shared/status.dart';
import '../shared/streams.dart';
import '../shared/timeout.dart';
import 'call.dart';
import 'interceptor.dart';
import 'service.dart';

typedef ServiceLookup = Service? Function(String service);
typedef GrpcErrorHandler = void Function(GrpcError error, StackTrace? trace);

/// Handles an incoming gRPC call.
class ServerHandler extends ServiceCall {
  final ServerTransportStream _stream;
  final ServiceLookup _serviceLookup;
  final List<Interceptor> _interceptors;
  final CodecRegistry? _codecRegistry;
  final GrpcErrorHandler? _errorHandler;

  // ignore: cancel_subscriptions
  StreamSubscription<GrpcMessage>? _incomingSubscription;

  late Service _service;
  late ServiceMethod _descriptor;

  Map<String, String>? _clientMetadata;
  Codec? _callEncodingCodec;

  StreamController? _requests;
  bool _hasReceivedRequest = false;

  late Stream _responses;
  StreamSubscription? _responseSubscription;
  bool _headersSent = false;

  Map<String, String>? _customHeaders = {};
  Map<String, String>? _customTrailers = {};

  DateTime? _deadline;
  bool _isTimedOut = false;
  Timer? _timeoutTimer;

  final X509Certificate? _clientCertificate;
  final InternetAddress? _remoteAddress;

  /// Emits a ping everytime data is received
  final Sink<void>? onDataReceived;

  final Completer<void> _isCanceledCompleter = Completer<void>();

  Future<void> get onCanceled => _isCanceledCompleter.future;

  set isCanceled(bool value) {
    if (!isCanceled) {
      _isCanceledCompleter.complete();
    }
  }

  ServerHandler({
    required ServerTransportStream stream,
    required ServiceLookup serviceLookup,
    required List<Interceptor> interceptors,
    required CodecRegistry? codecRegistry,
    X509Certificate? clientCertificate,
    InternetAddress? remoteAddress,
    GrpcErrorHandler? errorHandler,
    this.onDataReceived,
  })  : _stream = stream,
        _serviceLookup = serviceLookup,
        _interceptors = interceptors,
        _codecRegistry = codecRegistry,
        _clientCertificate = clientCertificate,
        _remoteAddress = remoteAddress,
        _errorHandler = errorHandler;

  @override
  DateTime? get deadline => _deadline;

  @override
  bool get isCanceled => _isCanceledCompleter.isCompleted;

  @override
  bool get isTimedOut => _isTimedOut;

  @override
  Map<String, String>? get clientMetadata => _clientMetadata;

  @override
  Map<String, String>? get headers => _customHeaders;

  @override
  Map<String, String>? get trailers => _customTrailers;

  @override
  X509Certificate? get clientCertificate => _clientCertificate;

  @override
  InternetAddress? get remoteAddress => _remoteAddress;

  void handle() {
    _stream.onTerminated = (_) => cancel();

    _incomingSubscription = _stream.incomingMessages
        .transform(GrpcHttpDecoder())
        .transform(grpcDecompressor(codecRegistry: _codecRegistry))
        .listen(
          _onDataIdle,
          onError: _onError,
          onDone: _onDoneError,
          cancelOnError: true,
        );
    _stream.outgoingMessages.done.then((_) {
      cancel();
    });
  }

  /// Cancel response subscription, if active. If the stream exits with an
  /// error, just ignore it. The client is long gone, so it doesn't care.
  /// We need the catchError() handler here, since otherwise the error would
  /// be an unhandled exception.
  void _cancelResponseSubscription() {
    _responseSubscription?.cancel().catchError((_) {});
  }

  // -- Idle state, incoming data --

  void _onDataIdle(GrpcMessage headerMessage) async {
    onDataReceived?.add(null);
    if (headerMessage is! GrpcMetadata) {
      _sendError(GrpcError.unimplemented('Expected header frame'));
      _sinkIncoming();
      return;
    }
    _incomingSubscription!.pause();

    _clientMetadata = headerMessage.metadata;
    final path = _clientMetadata![':path']!;
    final pathSegments = path.split('/');
    if (pathSegments.length < 3) {
      _sendError(GrpcError.unimplemented('Invalid path'));
      _sinkIncoming();
      return;
    }
    final serviceName = pathSegments[1];
    final methodName = pathSegments[2];
    if (_codecRegistry != null) {
      final acceptedEncodings =
          clientMetadata!['grpc-accept-encoding']?.split(',') ?? [];
      _callEncodingCodec = acceptedEncodings
          .map(_codecRegistry.lookup)
          .firstWhere((c) => c != null, orElse: () => null);
    }

    final service = _serviceLookup(serviceName);
    final descriptor = service?.$lookupMethod(methodName);
    if (descriptor == null) {
      _sendError(GrpcError.unimplemented('Path $path not found'));
      _sinkIncoming();
      return;
    }
    _service = service!;
    _descriptor = descriptor;

    final error = await _applyInterceptors();
    if (error != null) {
      _sendError(error);
      _sinkIncoming();
      return;
    }

    _startStreamingRequest();
  }

  GrpcError? _onMetadata() {
    try {
      _service.$onMetadata(this);
    } on GrpcError catch (error) {
      return error;
    } catch (error) {
      final grpcError = GrpcError.internal(error.toString());
      return grpcError;
    }
    return null;
  }

  Future<GrpcError?> _applyInterceptors() async {
    try {
      for (final interceptor in _interceptors) {
        final error = await interceptor(this, _descriptor);
        if (error != null) {
          return error;
        }
      }
    } catch (error) {
      final grpcError = GrpcError.internal(error.toString());
      return grpcError;
    }
    return null;
  }

  void _startStreamingRequest() {
    final requests = _descriptor.createRequestStream(_incomingSubscription!);
    _requests = requests;
    _incomingSubscription!.onData(_onDataActive);

    final error = _onMetadata();
    if (error != null) {
      if (!requests.isClosed) {
        requests
          ..addError(error)
          ..close();
      }
      _sendError(error);
      _onDone();
      _stream.terminate();
      return;
    }

    _responses = _descriptor.handle(this, requests.stream);

    _responseSubscription = _responses.listen(_onResponse,
        onError: _onResponseError,
        onDone: _onResponseDone,
        cancelOnError: true);
    _incomingSubscription!.onData(_onDataActive);
    _incomingSubscription!.onDone(_onDoneExpected);

    final timeout = fromTimeoutString(_clientMetadata!['grpc-timeout']);
    if (timeout != null) {
      _deadline = DateTime.now().add(timeout);
      _timeoutTimer = Timer(timeout, _onTimedOut);
    }
  }

  void _onTimedOut() {
    if (isCanceled) return;
    _isTimedOut = true;
    isCanceled = true;
    final error = GrpcError.deadlineExceeded('Deadline exceeded');
    _sendError(error);
    if (!_requests!.isClosed) {
      _requests!
        ..addError(error)
        ..close();
    }
  }

  // -- Active state, incoming data --

  void _onDataActive(GrpcMessage message) {
    if (message is! GrpcData) {
      final error = GrpcError.unimplemented('Expected request');
      _sendError(error);
      _requests!
        ..addError(error)
        ..close();
      return;
    }

    if (_hasReceivedRequest && !_descriptor.streamingRequest) {
      final error = GrpcError.unimplemented('Too many requests');
      _sendError(error);
      _requests!
        ..addError(error)
        ..close();
      return;
    }

    onDataReceived?.add(null);
    final data = message;
    Object? request;
    try {
      request = _descriptor.deserialize(data.data);
    } catch (error, trace) {
      final grpcError =
          GrpcError.internal('Error deserializing request: $error');
      _sendError(grpcError, trace);
      _requests!
        ..addError(grpcError, trace)
        ..close();
      return;
    }
    _requests!.add(request);
    _hasReceivedRequest = true;
  }

  // -- Active state, outgoing response data --

  void _onResponse(dynamic response) {
    try {
      final bytes = _descriptor.serialize(response);
      if (!_headersSent) {
        sendHeaders();
      }
      _stream.sendData(frame(bytes, _callEncodingCodec));
    } catch (error, trace) {
      final grpcError = GrpcError.internal('Error sending response: $error');
      if (!_requests!.isClosed) {
        // If we can, alert the handler that things are going wrong.
        _requests!
          ..addError(grpcError)
          ..close();
      }
      _sendError(grpcError, trace);
      _cancelResponseSubscription();
    }
  }

  void _onResponseDone() {
    sendTrailers();
  }

  void _onResponseError(Object error, StackTrace trace) {
    if (error is GrpcError) {
      _sendError(error, trace);
    } else {
      _sendError(GrpcError.unknown(error.toString()), trace);
    }
  }

  @override
  void sendHeaders() {
    if (_headersSent) throw GrpcError.internal('Headers already sent');

    _customHeaders!
      ..remove(':status')
      ..remove('content-type');

    // TODO(jakobr): Should come from package:http2?
    final outgoingHeadersMap = <String, String>{
      ':status': '200',
      'content-type': 'application/grpc',
      if (_callEncodingCodec != null)
        'grpc-encoding': _callEncodingCodec!.encodingName,
    };

    outgoingHeadersMap.addAll(_customHeaders!);
    _customHeaders = null;

    final outgoingHeaders = <Header>[];
    outgoingHeadersMap.forEach((key, value) =>
        outgoingHeaders.add(Header(ascii.encode(key), utf8.encode(value))));
    _stream.sendHeaders(outgoingHeaders);
    _headersSent = true;
  }

  @override
  void sendTrailers({
    int? status = 0,
    String? message,
    Map<String, String>? errorTrailers,
  }) {
    _timeoutTimer?.cancel();

    final outgoingTrailersMap = <String, String>{};
    if (!_headersSent) {
      // TODO(jakobr): Should come from package:http2?
      outgoingTrailersMap[':status'] = '200';
      outgoingTrailersMap['content-type'] = 'application/grpc';

      _customHeaders!
        ..remove(':status')
        ..remove('content-type');
      outgoingTrailersMap.addAll(_customHeaders!);
      _customHeaders = null;
      _headersSent = true;
    }
    _customTrailers!
      ..remove(':status')
      ..remove('content-type');
    outgoingTrailersMap.addAll(_customTrailers!);
    _customTrailers = null;
    outgoingTrailersMap['grpc-status'] = status.toString();
    if (message != null) {
      outgoingTrailersMap['grpc-message'] =
          Uri.encodeFull(message).replaceAll('%20', ' ');
    }
    if (errorTrailers != null) {
      outgoingTrailersMap.addAll(errorTrailers);
    }

    final outgoingTrailers = <Header>[];
    outgoingTrailersMap.forEach((key, value) =>
        outgoingTrailers.add(Header(ascii.encode(key), utf8.encode(value))));
    _stream.sendHeaders(outgoingTrailers, endStream: true);
    // We're done!
    _cancelResponseSubscription();
    _sinkIncoming();
  }

  // -- All states, incoming error / stream closed --

  void _onError(Object error) {
    // Exception from the incoming stream. Most likely a cancel request from the
    // client, so we treat it as such.
    _timeoutTimer?.cancel();
    isCanceled = true;
    if (_requests != null && !_requests!.isClosed) {
      _requests!.addError(GrpcError.cancelled('Cancelled'));
    }
    _cancelResponseSubscription();
    _incomingSubscription!.cancel();
    _stream.terminate();
  }

  void _onDoneError() {
    _sendError(GrpcError.unavailable('Request stream closed unexpectedly'));
    _onDone();
  }

  void _onDoneExpected() {
    if (!(_hasReceivedRequest || _descriptor.streamingRequest)) {
      final error = GrpcError.unimplemented('No request received');
      _sendError(error);
      _requests!.addError(error);
    }
    _onDone();
  }

  void _onDone() {
    _requests?.close();
    _incomingSubscription!.cancel();
  }

  /// Sink incoming requests. This is used when an error has already been
  /// reported, but we still need to consume the request stream from the client.
  void _sinkIncoming() {
    _incomingSubscription!
      ..onData((_) {})
      ..onDone(_onDone);
  }

  void _sendError(GrpcError error, [StackTrace? trace]) {
    _errorHandler?.call(error, trace);

    sendTrailers(
      status: error.code,
      message: error.message,
      errorTrailers: error.trailers,
    );
  }

  void cancel() {
    isCanceled = true;
    _timeoutTimer?.cancel();
    _cancelResponseSubscription();
  }
}
