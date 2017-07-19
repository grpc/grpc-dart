// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:grpc/src/shared.dart';
import 'package:http2/transport.dart';

import 'status.dart';
import 'streams.dart';

/// Definition of a gRPC service method.
class ServiceMethod<Q, R> {
  final String name;

  final bool streamingRequest;
  final bool streamingResponse;

  final Q Function(List<int> request) requestDeserializer;
  final List<int> Function(R response) responseSerializer;

  final Function handler;

  ServiceMethod(
      this.name,
      this.handler,
      this.streamingRequest,
      this.streamingResponse,
      this.requestDeserializer,
      this.responseSerializer);
}

/// Definition of a gRPC service.
abstract class Service {
  final Map<String, ServiceMethod> _$methods = {};

  String get $name;

  void $addMethod(ServiceMethod method) {
    _$methods[method.name] = method;
  }

  /// Client metadata handler.
  ///
  /// Services can override this method to provide common handling of incoming
  /// metadata from the client.
  void $onMetadata(ServiceCall context) {}

  ServiceMethod $lookupMethod(String name) => _$methods[name];
}

/// A gRPC server.
///
/// Listens for incoming gRPC calls, dispatching them to a [ServerHandler].
class Server {
  final Map<String, Service> _services = {};
  ServerSocket _server;

  final _connections = <ServerTransportConnection>[];

  final int _port;

  Server({int port = 8080}) : _port = port;

  void addService(Service service) {
    _services[service.$name] = service;
  }

  Service lookupService(String service) => _services[service];

  Future<Null> serve() async {
    // TODO(dart-lang/grpc-dart#4): Add TLS support.
    // TODO(dart-lang/grpc-dart#9): Handle HTTP/1.1 upgrade to h2c, if allowed.
    _server = await ServerSocket.bind('0.0.0.0', _port);
    _server.listen((socket) {
      final connection = new ServerTransportConnection.viaSocket(socket);
      _connections.add(connection);
      connection.incomingStreams.listen(serveStream, onError: (error) {
        print('Connection error: $error');
      }, onDone: () {
        _connections.remove(connection);
      });
    }, onError: (error) {
      print('Socket error: $error');
    });
  }

  void serveStream(ServerTransportStream stream) {
    new ServerHandler(lookupService, stream).handle();
  }

  Future<Null> shutdown() {
    final done = _connections.map((connection) => connection.finish()).toList();
    if (_server != null) {
      done.add(_server.close());
    }
    return Future.wait(done);
  }
}

/// Server-side context for a gRPC call.
///
/// Gives the method handler access to custom metadata from the client, and
/// ability to set custom metadata on the header/trailer sent to the client.
class ServiceCall {
  final ServerHandler _handler;

  ServiceCall(this._handler);

  /// Custom metadata from the client.
  Map<String, String> get clientMetadata => _handler._clientMetadata;

  /// Custom metadata to be sent to the client. Will be [null] once the headers
  /// have been sent, either when [sendHeaders] is called, or when the first
  /// response message is sent.
  Map<String, String> get headers => _handler._customHeaders;

  /// Custom metadata to be sent to the client after all response messages.
  Map<String, String> get trailers => _handler._customTrailers;

  /// Deadline for this call. If the call is still active after this time, then
  /// the client or server may cancel it.
  DateTime get deadline => _handler._deadline;

  /// Returns [true] if the [deadline] has been exceeded.
  bool get isTimedOut => _handler._isTimedOut;

  /// Returns [true] if the client has canceled this call.
  bool get isCanceled => _handler._isCanceled;

  /// Send response headers. This is done automatically before sending the first
  /// response message, but can be done manually before the first response is
  /// ready, if necessary.
  void sendHeaders() => _handler._sendHeaders();

  /// Send response trailers. A trailer indicating success ([status] == 0) will
  /// be sent automatically when all responses are sent. This method can be used
  /// to send a different status code, if needed.
  ///
  /// The call will be closed after calling this method, and no further
  /// responses can be sent.
  void sendTrailer(int status, [String statusMessage]) =>
      _handler._sendTrailers(status: status, message: statusMessage);
}

/// Handles an incoming gRPC call.
class ServerHandler {
  final ServerTransportStream _stream;
  final Service Function(String service) _serviceLookup;

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

  ServerHandler(this._serviceLookup, this._stream);

  bool get isCanceled => _isCanceled;

  void handle() {
    _stream.onTerminated = (int errorCode) {
      _isCanceled = true;
      _cancelResponseSubscription();
    };

    _incomingSubscription = _stream.incomingMessages
        .transform(new GrpcHttpDecoder())
        .transform(grpcDecompressor())
        .listen(_onDataIdle,
            onError: _onError, onDone: _onDoneError, cancelOnError: true);
  }

  /// Cancel response subscription, if active. If the stream exits with an
  /// error, just ignore it. The client is long gone, so it doesn't care.
  /// We need the catchError() handler here, since otherwise the error would
  /// be an unhandled exception.
  void _cancelResponseSubscription() {
    _responseSubscription?.cancel()?.catchError((_) {});
  }

  // -- Idle state, incoming data --

  void _onDataIdle(GrpcMessage message) {
    if (message is! GrpcMetadata) {
      _sendError(new GrpcError.unimplemented('Expected header frame'));
      _sinkIncoming();
      return;
    }
    final headerMessage = message
        as GrpcMetadata; // TODO(jakobr): Cast should not be necessary here.
    _clientMetadata = headerMessage.metadata;
    final path = _clientMetadata[':path'];
    final pathSegments = path.split('/');
    if (pathSegments.length < 3) {
      _sendError(new GrpcError.unimplemented('Invalid path'));
      _sinkIncoming();
      return;
    }
    final serviceName = pathSegments[1];
    final methodName = pathSegments[2];
    _service = _serviceLookup(serviceName);
    _descriptor = _service?.$lookupMethod(methodName);
    if (_descriptor == null) {
      _sendError(new GrpcError.unimplemented('Path $path not found'));
      _sinkIncoming();
      return;
    }
    _startStreamingRequest();
  }

  Future<T> _toSingleFuture<T>(Stream<T> stream) {
    T _ensureOnlyOneRequest(T previous, T element) {
      if (previous != null) {
        throw new GrpcError.unimplemented('More than one request received');
      }
      return element;
    }

    T _ensureOneRequest(T value) {
      if (value == null)
        throw new GrpcError.unimplemented('No requests received');
      return value;
    }

    final future =
        stream.fold(null, _ensureOnlyOneRequest).then(_ensureOneRequest);
    // Make sure errors on the future aren't unhandled, but return the original
    // future so the request handler can also get the error.
    future.catchError((_) {});
    return future;
  }

  void _startStreamingRequest() {
    _incomingSubscription.pause();
    _requests = new StreamController(
        onListen: _incomingSubscription.resume,
        onPause: _incomingSubscription.pause,
        onResume: _incomingSubscription.resume);
    _incomingSubscription.onData(_onDataActive);

    final context = new ServiceCall(this);
    _service.$onMetadata(context);
    if (_descriptor.streamingResponse) {
      if (_descriptor.streamingRequest) {
        _responses = _descriptor.handler(context, _requests.stream);
      } else {
        _responses =
            _descriptor.handler(context, _toSingleFuture(_requests.stream));
      }
    } else {
      Future response;
      if (_descriptor.streamingRequest) {
        response = _descriptor.handler(context, _requests.stream);
      } else {
        response =
            _descriptor.handler(context, _toSingleFuture(_requests.stream));
      }
      _responses = response.asStream();
    }

    _responseSubscription = _responses.listen(_onResponse,
        onError: _onResponseError,
        onDone: _onResponseDone,
        cancelOnError: true);
    _incomingSubscription.onData(_onDataActive);
    _incomingSubscription.onDone(_onDoneExpected);

    final timeout = fromTimeoutString(_clientMetadata['grpc-timeout']);
    if (timeout != null) {
      _deadline = new DateTime.now().add(timeout);
      _timeoutTimer = new Timer(timeout, _onTimedOut);
    }
  }

  void _onTimedOut() {
    _isTimedOut = true;
    _isCanceled = true;
    final error = new GrpcError.deadlineExceeded('Deadline exceeded');
    if (!_requests.isClosed) {
      _requests
        ..addError(error)
        ..close();
    }
    _sendError(error);
  }

  // -- Active state, incoming data --

  void _onDataActive(GrpcMessage message) {
    if (message is! GrpcData) {
      final error = new GrpcError.unimplemented('Expected request');
      _sendError(error);
      _requests
        ..addError(error)
        ..close();
      return;
    }

    if (_hasReceivedRequest && !_descriptor.streamingRequest) {
      final error = new GrpcError.unimplemented('Too many requests');
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
      request = _descriptor.requestDeserializer(data.data);
    } catch (error) {
      final grpcError =
          new GrpcError.internal('Error deserializing request: $error');
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
      final bytes = _descriptor.responseSerializer(response);
      if (!_headersSent) {
        _sendHeaders();
      }
      _stream.sendData(GrpcHttpEncoder.frame(bytes));
    } catch (error) {
      final grpcError =
          new GrpcError.internal('Error sending response: $error');
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
    _sendTrailers();
  }

  void _onResponseError(error) {
    if (error is GrpcError) {
      _sendError(error);
    } else {
      _sendError(new GrpcError.unknown(error.toString()));
    }
  }

  void _sendHeaders() {
    if (_headersSent) throw new GrpcError.internal('Headers already sent');

    _customHeaders..remove(':status')..remove('content-type');

    // TODO(jakobr): Should come from package:http2?
    final headersMap = <String, String>{
      ':status': '200',
      'content-type': 'application/grpc'
    };

    headersMap.addAll(_customHeaders);
    _customHeaders = null;

    final headers = <Header>[];
    headersMap
        .forEach((key, value) => headers.add(new Header.ascii(key, value)));
    _stream.sendHeaders(headers);
    _headersSent = true;
  }

  void _sendTrailers({int status = 0, String message}) {
    _timeoutTimer?.cancel();

    final trailersMap = <String, String>{};
    if (!_headersSent) {
      // TODO(jakobr): Should come from package:http2?
      trailersMap[':status'] = '200';
      trailersMap['content-type'] = 'application/grpc';

      _customHeaders..remove(':status')..remove('content-type');
      trailersMap.addAll(_customHeaders);
      _customHeaders = null;
    }
    _customTrailers..remove(':status')..remove('content-type');
    trailersMap.addAll(_customTrailers);
    _customTrailers = null;
    trailersMap['grpc-status'] = status.toString();
    if (message != null) {
      trailersMap['grpc-message'] = message;
    }

    final trailers = <Header>[];
    trailersMap
        .forEach((key, value) => trailers.add(new Header.ascii(key, value)));
    _stream.sendHeaders(trailers, endStream: true);
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
    if (!_requests.isClosed) {
      _requests.addError(new GrpcError.cancelled('Cancelled'));
    }
    _cancelResponseSubscription();
    _incomingSubscription.cancel();
    _stream.terminate();
  }

  void _onDoneError() {
    _sendError(new GrpcError.unavailable('Request stream closed unexpectedly'));
    _onDone();
  }

  void _onDoneExpected() {
    if (!(_hasReceivedRequest || _descriptor.streamingRequest)) {
      final error = new GrpcError.unimplemented('No request received');
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
    _sendTrailers(status: error.code, message: error.message);
  }
}
