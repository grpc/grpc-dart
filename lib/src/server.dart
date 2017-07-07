// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http2/transport.dart';

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

  ServiceMethod _lookupMethod(String service, String method) =>
      _services[service]?.$lookupMethod(method);

  Future<Null> serve() async {
    // TODO(dart-lang/grpc-dart#4): Add TLS support.
    // TODO(dart-lang/grpc-dart#9): Handle HTTP/1.1 upgrade to h2c, if allowed.
    _server = await ServerSocket.bind('0.0.0.0', _port);
    _server.listen((socket) {
      final connection = new ServerTransportConnection.viaSocket(socket);
      _connections.add(connection);
      connection.incomingStreams.listen((stream) {
        new ServerHandler(_lookupMethod, stream).handle();
      }, onError: (error) {
        print('Connection error: $error');
      }, onDone: () {
        _connections.remove(connection);
      });
    }, onError: (error) {
      print('Socket error: $error');
    });
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
  /// responses can be sent.
  void sendTrailer(int status, [String statusMessage]) =>
      _handler._sendTrailers(status: status, message: statusMessage);
}

/// Handles an incoming gRPC call.
class ServerHandler {
  final ServerTransportStream _stream;
  final ServiceMethod Function(String service, String method) _methodLookup;

  StreamSubscription<GrpcMessage> _incomingSubscription;

  Map<String, String> _clientMetadata;
  ServiceMethod _descriptor;

  StreamController _requests;
  bool _hasReceivedRequest = false;

  Stream _responses;
  StreamSubscription _responseSubscription;
  bool _headersSent = false;

  Map<String, String> _customHeaders = {};
  Map<String, String> _customTrailers = {};

  DateTime _deadline;
  bool _isCanceled = false;

  ServerHandler(this._methodLookup, this._stream);

  bool get isCanceled => _isCanceled;
  bool get _isTimedOut => _deadline?.isBefore(new DateTime.now()) ?? false;

  void handle() {
    _stream.onTerminated = (int errorCode) {
      _isCanceled = true;
      _responseSubscription?.cancel();
    };

    _incomingSubscription = _stream.incomingMessages
        .transform(new GrpcHttpDecoder())
        .transform(grpcDecompressor())
        .listen(_onDataIdle,
            onError: _onError, onDone: _onDoneError, cancelOnError: true);
  }

  // -- Idle state, incoming data --

  void _onDataIdle(GrpcMessage message) {
    if (message is! GrpcMetadata) {
      _sendError(401, 'Expected header frame');
      return;
    }
    final headerMessage = message
        as GrpcMetadata; // TODO(jakobr): Cast should not be necessary here.
    _clientMetadata = headerMessage.metadata;
    final path = _clientMetadata[':path'].split('/');
    if (path.length < 3) {
      _sendError(404, 'Invalid path');
      return;
    }
    final service = path[1];
    final method = path[2];
    _descriptor = _methodLookup(service, method);
    if (_descriptor == null) {
      _sendError(404, 'Path /$service/$method not found');
      return;
    }
    _startStreamingRequest();
  }

  void _startStreamingRequest() {
    _incomingSubscription.pause();
    _requests = new StreamController(
        onListen: _incomingSubscription.resume,
        onPause: _incomingSubscription.pause,
        onResume: _incomingSubscription.resume);
    _incomingSubscription.onData(_onDataActive);

    final context = new ServiceCall(this);
    if (_descriptor.streamingResponse) {
      if (_descriptor.streamingRequest) {
        _responses = _descriptor.handler(context, _requests.stream);
      } else {
        _responses = _descriptor.handler(context, _requests.stream.single);
      }
    } else {
      Future response;
      if (_descriptor.streamingRequest) {
        response = _descriptor.handler(context, _requests.stream);
      } else {
        response = _descriptor.handler(context, _requests.stream.single);
      }
      _responses = response.asStream();
    }
    _responseSubscription = _responses.listen(_onResponse,
        onError: _onResponseError,
        onDone: _onResponseDone,
        cancelOnError: true);
    _incomingSubscription.onData(_onDataActive);
    _incomingSubscription.onDone(_onDoneExpected);
  }

  // -- Active state, incoming data --

  void _onDataActive(GrpcMessage message) {
    if (message is! GrpcData) {
      _sendError(711, 'Expected data frame');
      _requests
        ..addError(new GrpcError(712, 'No request received'))
        ..close();
      return;
    }

    if (_hasReceivedRequest && !_descriptor.streamingRequest) {
      _sendError(712, 'Too many requests');
      _requests
        ..addError(new GrpcError(712, 'Too many requests'))
        ..close();
    }

    final data =
        message as GrpcData; // TODO(jakobr): Cast should not be necessary here.
    var request;
    try {
      request = _descriptor.requestDeserializer(data.data);
    } catch (error) {
      _sendError(730, 'Error deserializing request: $error');
      _requests
        ..addError(new GrpcError(730, 'Error deserializing request: $error'))
        ..close();
      return;
    }
    _requests.add(request);
    _hasReceivedRequest = true;
  }

  // -- Active state, outgoing response data --

  void _onResponse(response) {
    try {
      if (!_headersSent) {
        _sendHeaders();
      }
      final bytes = _descriptor.responseSerializer(response);
      _stream.sendData(GrpcHttpEncoder.frame(bytes));
    } catch (error) {
      _responseSubscription.cancel();
      if (!_requests.isClosed) {
        // If we can, alert the handler that things are going wrong.
        _requests
            .addError(new GrpcError(1001, 'Error sending response: $error'));
        _requests.close();
      }
      _incomingSubscription.cancel();
      _stream.terminate();
    }
  }

  void _onResponseDone() {
    _sendTrailers();
  }

  void _onResponseError(error) {
    if (error is GrpcError) {
      // TODO(jakobr): error.metadata...
      _sendError(error.code, error.message);
    } else {
      _sendError(107, error.toString());
    }
  }

  void _sendHeaders() {
    if (_headersSent) throw new GrpcError(1514, 'Headers already sent');
    final headersMap = <String, String>{};
    headersMap.addAll(_customHeaders);
    _customHeaders = null;

    // TODO(jakobr): Should come from package:http2?
    headersMap[':status'] = '200';
    headersMap['content-type'] = 'application/grpc';

    final headers = <Header>[];
    headersMap
        .forEach((key, value) => headers.add(new Header.ascii(key, value)));
    _stream.sendHeaders(headers);
    _headersSent = true;
  }

  void _sendTrailers({int status = 0, String message}) {
    final trailersMap = <String, String>{};
    if (!_headersSent) {
      trailersMap.addAll(_customHeaders);
      _customHeaders = null;
    }
    trailersMap.addAll(_customTrailers);
    _customTrailers = null;
    if (!_headersSent) {
      // TODO(jakobr): Should come from package:http2?
      trailersMap[':status'] = '200';
      trailersMap['content-type'] = 'application/grpc';
    }
    trailersMap['grpc-status'] = status.toString();
    if (message != null) {
      trailersMap['grpc-message'] = message;
    }

    final trailers = <Header>[];
    trailersMap
        .forEach((key, value) => trailers.add(new Header.ascii(key, value)));
    _stream.sendHeaders(trailers, endStream: true);
    // We're done!
    _incomingSubscription.cancel();
    _responseSubscription?.cancel();
  }

  // -- All states, incoming error / stream closed --

  void _onError(error) {
    // Exception from the incoming stream. Most likely a cancel request from the
    // client, so we treat it as such.
    _isCanceled = true;
    _requests.addError(new GrpcError(1001, 'Canceled'));
    _responseSubscription?.cancel();
  }

  void _onDoneError() {
    _sendError(710, 'Request stream closed unexpectedly');
  }

  void _onDoneExpected() {
    if (!(_hasReceivedRequest || _descriptor.streamingRequest)) {
      _sendError(730, 'Expected request message');
      _requests.addError(new GrpcError(730, 'No request message received'));
    }
    _requests.close();
    _incomingSubscription.cancel();
  }

  void _sendError(int status, String message) {
    _sendTrailers(status: status, message: message);
  }
}
