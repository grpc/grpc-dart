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
  final List<ServerInterceptor> _serverInterceptors;
  final CodecRegistry? _codecRegistry;
  final GrpcErrorHandler? _errorHandler;

  // ignore: cancel_subscriptions
  late final StreamSubscription<GrpcMessage> _incomingSubscription;

  late Service _service;
  late ServiceMethod _descriptor;

  Map<String, String>? _clientMetadata;
  Codec? _callEncodingCodec;

  /// The requests of a client-streaming call, or else its single request,
  /// which is completed with [_receivedRequest] when the request stream ends.
  StreamController? _requests;
  SingleValueStream? _request;
  Object? _receivedRequest;
  bool _hasReceivedRequest = false;

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

  /// Invoked once, when this call is canceled or has finished (see
  /// [isCanceled]).
  ///
  /// Unlike [onCanceled], this doesn't allocate a [Completer] per call.
  void Function()? onCancel;

  bool _isCanceled = false;
  Completer<void>? _isCanceledCompleter;

  Future<void> get onCanceled =>
      (_isCanceledCompleter ??= _isCanceled
              ? (Completer<void>()..complete())
              : Completer<void>())
          .future;

  set isCanceled(bool value) {
    if (!_isCanceled) {
      _isCanceled = true;
      _isCanceledCompleter?.complete();
      final callback = onCancel;
      onCancel = null;
      callback?.call();
    }
  }

  ServerHandler({
    required ServerTransportStream stream,
    required ServiceLookup serviceLookup,
    required List<Interceptor> interceptors,
    required List<ServerInterceptor> serverInterceptors,
    required CodecRegistry? codecRegistry,
    X509Certificate? clientCertificate,
    InternetAddress? remoteAddress,
    GrpcErrorHandler? errorHandler,
    this.onDataReceived,
  }) : _stream = stream,
       _serviceLookup = serviceLookup,
       _interceptors = interceptors,
       _codecRegistry = codecRegistry,
       _clientCertificate = clientCertificate,
       _remoteAddress = remoteAddress,
       _errorHandler = errorHandler,
       _serverInterceptors = serverInterceptors;

  @override
  DateTime? get deadline => _deadline;

  @override
  bool get isCanceled => _isCanceled;

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
        .transform(GrpcDecompressingHttpDecoder(codecRegistry: _codecRegistry))
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

    if (_interceptors.isNotEmpty) {
      _incomingSubscription.pause();
      final error = await _applyInterceptors();
      if (error != null) {
        _sendError(error);
        _sinkIncoming();
        return;
      }
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
    final error = _onMetadata();
    if (error != null) {
      _sendError(error);
      _onDone();
      _stream.terminate();
      return;
    }

    final incoming = _incomingSubscription
      ..onData(_onDataActive)
      ..onDone(_onDoneExpected);
    final Stream requests;
    if (_descriptor.streamingRequest) {
      // The request stream resumes [incoming] when the handler listens.
      if (!incoming.isPaused) incoming.pause();
      requests = (_requests = _descriptor.createRequestStream(incoming)).stream;
    } else {
      requests = _request = createSingleRequestStream(_descriptor);
      if (incoming.isPaused) incoming.resume(); // Paused for interceptors.
    }

    final Stream responses;
    try {
      responses = _descriptor.handle(this, requests, _serverInterceptors);
    } catch (error, trace) {
      _onResponseError(error, trace);
      return;
    }
    if (responses is SingleValueStream) {
      responses.future.then(_onUnaryResult, onError: _onResponseError);
    } else {
      _responseSubscription = responses.listen(
        _onResponse,
        onError: _onResponseError,
        onDone: _onResponseDone,
        cancelOnError: true,
      );
    }

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
    _failRequests(error);
  }

  // -- Active state, incoming data --

  void _onDataActive(GrpcMessage message) {
    if (message is! GrpcData) {
      final error = GrpcError.unimplemented('Expected request');
      _sendError(error);
      _failRequests(error);
      return;
    }

    if (_hasReceivedRequest && !_descriptor.streamingRequest) {
      final error = GrpcError.unimplemented('Too many requests');
      _sendError(error);
      _failRequests(error);
      return;
    }

    onDataReceived?.add(null);
    final data = message;
    Object? request;
    try {
      request = _descriptor.deserialize(data.data);
    } catch (error, trace) {
      final grpcError = GrpcError.internal(
        'Error deserializing request: $error',
      );
      _sendError(grpcError, trace);
      _failRequests(grpcError, trace);
      return;
    }
    if (_requests case final requests?) {
      requests.add(request);
    } else {
      _receivedRequest = request;
    }
    _hasReceivedRequest = true;
  }

  /// Adds [error] to the requests, unless they are complete.
  void _failRequests(GrpcError error, [StackTrace? trace]) {
    if (_requests case final requests? when !requests.isClosed) {
      requests
        ..addError(error, trace)
        ..close();
    }
    if (_request?.completer case final request? when !request.isCompleted) {
      request.completeError(error, trace);
    }
  }

  // -- Active state, outgoing response data --

  void _onUnaryResult(Object? response) {
    if (_isFinished) return;
    _onResponse(response);
    _onResponseDone();
  }

  void _onResponse(dynamic response) {
    try {
      final bytes = _descriptor.serialize(response);
      if (!_headersSent) {
        sendHeaders();
      }
      addGrpcMessage(_stream.outgoingMessages, bytes, _callEncodingCodec);
    } catch (error, trace) {
      final grpcError = GrpcError.internal('Error sending response: $error');
      // If we can, alert the handler that things are going wrong.
      _failRequests(grpcError);
      _sendError(grpcError, trace);
      _cancelResponseSubscription();
    }
  }

  void _onResponseDone() {
    sendTrailers();
  }

  void _onResponseError(Object error, StackTrace trace) {
    if (_isFinished) return;
    if (error is GrpcError) {
      _sendError(error, trace);
    } else {
      _sendError(GrpcError.unknown(error.toString()), trace);
    }
  }

  /// Whether the call has been canceled or its trailers have been sent.
  bool get _isFinished => _isCanceled || _customTrailers == null;

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
    outgoingHeadersMap.forEach(
      (key, value) =>
          outgoingHeaders.add(Header(ascii.encode(key), utf8.encode(value))),
    );
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
    final customTrailers = _customTrailers;
    if (customTrailers == null) return; // Already sent.
    _customTrailers = null;

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
    customTrailers
      ..remove(':status')
      ..remove('content-type');
    outgoingTrailersMap.addAll(customTrailers);
    outgoingTrailersMap['grpc-status'] = status.toString();
    if (message != null) {
      outgoingTrailersMap['grpc-message'] = Uri.encodeFull(
        message,
      ).replaceAll('%20', ' ');
    }
    if (errorTrailers != null) {
      outgoingTrailersMap.addAll(errorTrailers);
    }

    final outgoingTrailers = <Header>[];
    outgoingTrailersMap.forEach(
      (key, value) =>
          outgoingTrailers.add(Header(ascii.encode(key), utf8.encode(value))),
    );
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
    _failRequests(GrpcError.cancelled('Cancelled'));
    _cancelResponseSubscription();
    _incomingSubscription.cancel();
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
      _failRequests(error);
    }
    _onDone();
  }

  void _onDone() {
    _requests?.close();
    if (_request?.completer case final request?
        when _hasReceivedRequest && !request.isCompleted) {
      request.complete(_receivedRequest);
    }
    _incomingSubscription.cancel();
  }

  /// Sink incoming requests. This is used when an error has already been
  /// reported, but we still need to consume the request stream from the client.
  void _sinkIncoming() {
    _incomingSubscription
      ..onData((_) {})
      ..onDone(_onDone);
    // Paused while interceptors ran, or until the request stream got a
    // listener.
    if (_incomingSubscription.isPaused) _incomingSubscription.resume();
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
