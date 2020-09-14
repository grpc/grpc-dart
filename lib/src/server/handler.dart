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

import '../shared/message.dart';
import '../shared/status.dart';
import '../shared/streams.dart';
import '../shared/timeout.dart';

import 'call.dart';
import 'interceptor.dart';
import 'service.dart';

/// Handles an incoming gRPC call.
class ServerHandler_ extends ServiceCall {
  final ServerTransportStream _stream;
  final Service Function(String service) _serviceLookup;
  final List<Interceptor> _interceptors;

  StreamSubscription<GrpcMessage> _incomingSubscription;

  Service _service;
  ServiceMethod _descriptor;

  Map<String, String> _clientMetadata;

  StreamController _requests;
  bool _hasReceivedRequest = false;

  Stream _responses;
  StreamSubscription _responseSubscription;
  bool _headersSent = false;

  Map<String, String> _customHeaders = {};
  Map<String, String> _customTrailers = {};

  DateTime _deadline;
  bool _isCanceled = false;
  bool _isTimedOut = false;
  Timer _timeoutTimer;

  ServerHandler_(this._serviceLookup, this._stream, this._interceptors);

  DateTime get deadline => _deadline;

  bool get isCanceled => _isCanceled;

  bool get isTimedOut => _isTimedOut;

  Map<String, String> get clientMetadata => _clientMetadata;

  Map<String, String> get headers => _customHeaders;

  Map<String, String> get trailers => _customTrailers;

  void handle() {
    _stream.onTerminated = (_) => cancel();

    _incomingSubscription = _stream.incomingMessages
        .transform(GrpcHttpDecoder())
        .transform(grpcDecompressor())
        .listen(_onDataIdle,
            onError: _onError, onDone: _onDoneError, cancelOnError: true);
    _stream.outgoingMessages.done.then((_) {
      cancel();
    });
  }

  /// Cancel response subscription, if active. If the stream exits with an
  /// error, just ignore it. The client is long gone, so it doesn't care.
  /// We need the catchError() handler here, since otherwise the error would
  /// be an unhandled exception.
  void _cancelResponseSubscription() {
    _responseSubscription?.cancel()?.catchError((_) {});
  }

  // -- Idle state, incoming data --

  void _onDataIdle(GrpcMessage message) async {
    if (message is! GrpcMetadata) {
      _sendError(GrpcError.unimplemented('Expected header frame'));
      _sinkIncoming();
      return;
    }
    _incomingSubscription.pause();

    final headerMessage = message
        as GrpcMetadata; // TODO(jakobr): Cast should not be necessary here.
    _clientMetadata = headerMessage.metadata;
    final path = _clientMetadata[':path'];
    final pathSegments = path.split('/');
    if (pathSegments.length < 3) {
      _sendError(GrpcError.unimplemented('Invalid path'));
      _sinkIncoming();
      return;
    }
    final serviceName = pathSegments[1];
    final methodName = pathSegments[2];

    _service = _serviceLookup(serviceName);
    _descriptor = _service?.$lookupMethod(methodName);
    if (_descriptor == null) {
      _sendError(GrpcError.unimplemented('Path $path not found'));
      _sinkIncoming();
      return;
    }

    final error = await _applyInterceptors();
    if (error != null) {
      _sendError(error);
      _sinkIncoming();
      return;
    }

    _startStreamingRequest();
  }

  Future<GrpcError> _applyInterceptors() async {
    try {
      for (final interceptor in _interceptors) {
        final error = await interceptor(this, this._descriptor);
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
    _requests = _descriptor.createRequestStream(_incomingSubscription);
    _incomingSubscription.onData(_onDataActive);

    _service.$onMetadata(this);
    _responses = _descriptor.handle(this, _requests.stream);

    _responseSubscription = _responses.listen(_onResponse,
        onError: _onResponseError,
        onDone: _onResponseDone,
        cancelOnError: true);
    _incomingSubscription.onData(_onDataActive);
    _incomingSubscription.onDone(_onDoneExpected);

    final timeout = fromTimeoutString(_clientMetadata['grpc-timeout']);
    if (timeout != null) {
      _deadline = DateTime.now().add(timeout);
      _timeoutTimer = Timer(timeout, _onTimedOut);
    }
  }

  void _onTimedOut() {
    if (_isCanceled) return;
    _isTimedOut = true;
    _isCanceled = true;
    final error = GrpcError.deadlineExceeded('Deadline exceeded');
    _sendError(error);
    if (!_requests.isClosed) {
      _requests
        ..addError(error)
        ..close();
    }
  }

  // -- Active state, incoming data --

  void _onDataActive(GrpcMessage message) {
    if (message is! GrpcData) {
      final error = GrpcError.unimplemented('Expected request');
      _sendError(error);
      _requests
        ..addError(error)
        ..close();
      return;
    }

    if (_hasReceivedRequest && !_descriptor.streamingRequest) {
      final error = GrpcError.unimplemented('Too many requests');
      _sendError(error);
      _requests
        ..addError(error)
        ..close();
      return;
    }

    // TODO(jakobr): Cast should not be necessary here.
    final data = message as GrpcData;
    var request;
    try {
      request = _descriptor.deserialize(data.data);
    } catch (error) {
      final grpcError =
          GrpcError.internal('Error deserializing request: $error');
      _sendError(grpcError);
      _requests
        ..addError(grpcError)
        ..close();
      return;
    }
    _requests.add(request);
    _hasReceivedRequest = true;
  }

  // -- Active state, outgoing response data --

  void _onResponse(response) {
    try {
      final bytes = _descriptor.serialize(response);
      if (!_headersSent) {
        sendHeaders();
      }
      _stream.sendData(frame(bytes));
    } catch (error) {
      final grpcError = GrpcError.internal('Error sending response: $error');
      if (!_requests.isClosed) {
        // If we can, alert the handler that things are going wrong.
        _requests
          ..addError(grpcError)
          ..close();
      }
      _sendError(grpcError);
      _cancelResponseSubscription();
    }
  }

  void _onResponseDone() {
    sendTrailers();
  }

  void _onResponseError(error) {
    if (error is GrpcError) {
      _sendError(error);
    } else {
      _sendError(GrpcError.unknown(error.toString()));
    }
  }

  void sendHeaders() {
    if (_headersSent) throw GrpcError.internal('Headers already sent');

    _customHeaders..remove(':status')..remove('content-type');

    // TODO(jakobr): Should come from package:http2?
    final outgoingHeadersMap = <String, String>{
      ':status': '200',
      'content-type': 'application/grpc'
    };

    outgoingHeadersMap.addAll(_customHeaders);
    _customHeaders = null;

    final outgoingHeaders = <Header>[];
    outgoingHeadersMap.forEach((key, value) =>
        outgoingHeaders.add(Header(ascii.encode(key), utf8.encode(value))));
    _stream.sendHeaders(outgoingHeaders);
    _headersSent = true;
  }

  void sendTrailers({int status = 0, String message}) {
    _timeoutTimer?.cancel();

    final outgoingTrailersMap = <String, String>{};
    if (!_headersSent) {
      // TODO(jakobr): Should come from package:http2?
      outgoingTrailersMap[':status'] = '200';
      outgoingTrailersMap['content-type'] = 'application/grpc';

      _customHeaders..remove(':status')..remove('content-type');
      outgoingTrailersMap.addAll(_customHeaders);
      _customHeaders = null;
      _headersSent = true;
    }
    _customTrailers..remove(':status')..remove('content-type');
    outgoingTrailersMap.addAll(_customTrailers);
    _customTrailers = null;
    outgoingTrailersMap['grpc-status'] = status.toString();
    if (message != null) {
      outgoingTrailersMap['grpc-message'] =
          Uri.encodeFull(message).replaceAll("%20", " ");
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

  void _onError(error) {
    // Exception from the incoming stream. Most likely a cancel request from the
    // client, so we treat it as such.
    _timeoutTimer?.cancel();
    _isCanceled = true;
    if (_requests != null && !_requests.isClosed) {
      _requests.addError(GrpcError.cancelled('Cancelled'));
    }
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
      _requests.addError(error);
    }
    _onDone();
  }

  void _onDone() {
    _requests?.close();
    _incomingSubscription.cancel();
  }

  /// Sink incoming requests. This is used when an error has already been
  /// reported, but we still need to consume the request stream from the client.
  void _sinkIncoming() {
    _incomingSubscription
      ..onData((_) {})
      ..onDone(_onDone);
  }

  void _sendError(GrpcError error) {
    sendTrailers(status: error.code, message: error.message);
  }

  void cancel() {
    _isCanceled = true;
    _timeoutTimer?.cancel();
    _cancelResponseSubscription();
  }
}

class ServerHandler extends ServerHandler_ {
  ServerHandler(Service Function(String service) serviceLookup, stream,
      [List<Interceptor> interceptors = const <Interceptor>[]])
      : super(serviceLookup, stream, interceptors);
}
