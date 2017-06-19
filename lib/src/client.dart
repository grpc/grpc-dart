// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Dart gRPC client implementation.

import 'dart:async';
import 'dart:io';

import 'package:http2/transport.dart';

import 'shared.dart';
import 'streams.dart';

/// A channel to an RPC endpoint.
class ClientChannel {
  final String host;
  final int port;

  final List<Socket> _sockets = [];
  final List<TransportConnection> _connections = [];

  final SecurityContext securityContext;
  final bool Function(X509Certificate certificate) onBadCertificate;

  // TODO(jakobr): Channel options.
  ClientChannel(this.host,
      {this.port = 443, this.securityContext, this.onBadCertificate});

  /// Returns a connection to this [Channel]'s RPC endpoint. The connection may
  /// be shared between multiple RPC calls.
  Future<ClientTransportConnection> connect() async {
    final socket = await SecureSocket.connect(host, port,
        supportedProtocols: ['h2', 'http/1.1'],
        context: securityContext,
        onBadCertificate: onBadCertificate);
    _sockets.add(socket);
    final connection = new ClientTransportConnection.viaSocket(socket);
    _connections.add(connection);
    return connection;
  }

  /// Close all connections made on this [ClientChannel].
  Future<Null> close() async {
    await Future.wait(_connections.map((c) => c.finish()));
    _connections.clear();
    await Future.wait(_sockets.map((s) => s.close()));
    _sockets.clear();
  }
}

/// Description of a gRPC method.
class ClientMethod<Q, R> {
  final String service;
  final String method;
  String get path => '/$service/$method';
  final List<int> Function(Q value) requestSerializer;
  final R Function(List<int> value) responseDeserializer;

  ClientMethod(this.service, this.method, this.requestSerializer,
      this.responseDeserializer);
}

/// An active call to a gRPC endpoint.
class ClientCall<Q, R> implements Response {
  final ClientChannel _channel;

  final Completer<Map<String, String>> _headers = new Completer();
  final Completer<Map<String, String>> _trailers = new Completer();
  bool _hasReceivedResponses = false;

  Map<String, String> _headerMetadata;

  TransportStream _stream;
  final StreamController<Q> _requests = new StreamController();
  StreamController<R> _responses;
  StreamSubscription<GrpcMessage> _responseSubscription;

  final List<int> Function(Q request) _requestSerializer;
  final R Function(List<int> response) _responseDeserializer;

  final String path;

  final Map<String, String> metadata;

  ClientCall(this._channel, ClientMethod<Q, R> method,
      {this.metadata = const {}})
      : path = method.path,
        _requestSerializer = method.requestSerializer,
        _responseDeserializer = method.responseDeserializer {
    _responses = new StreamController(onListen: _onResponseListen);
    _call().catchError((error) {
      _responses.addError(
          new GrpcError(1703, 'Error connecting: ${error.toString()}'));
    });
  }

  Future<Null> _call() async {
    final connection = await _channel.connect();
    // TODO(jakobr): Populate HTTP-specific headers in connection?
    final headers = <Header>[
      new Header.ascii(':method', 'POST'),
      new Header.ascii(':scheme', 'https'),
      new Header.ascii(':path', path),
      new Header.ascii(':authority', _channel.host),
      new Header.ascii('grpc-timeout', '5S'),
      new Header.ascii('content-type', 'application/grpc'),
      new Header.ascii('te', 'trailers'),
      new Header.ascii('grpc-accept-encoding', 'identity'),
      new Header.ascii('user-agent', 'dart-grpc/0.2.0'),
    ];
    metadata.forEach((key, value) {
      // TODO(jakobr): Filter out headers owned by gRPC.
      headers.add(new Header.ascii(key, value));
    });
    _stream = connection.makeRequest(headers);
    _requests.stream
        .map(_requestSerializer)
        .map(GrpcHttpEncoder.frame)
        .map<StreamMessage>((bytes) => new DataStreamMessage(bytes))
        .handleError(_onRequestError)
        .pipe(_stream.outgoingMessages);
    // The response stream might have been listened to before _stream was ready,
    // so try setting up the subscription here as well.
    _onResponseListen();
  }

  /// Subscribe to incoming response messages, once [_stream] is available, and
  /// the caller has subscribed to the [_responses] stream.
  void _onResponseListen() {
    if (_stream != null &&
        _responses.hasListener &&
        _responseSubscription == null) {
      _responseSubscription = _stream.incomingMessages
          .transform(new GrpcHttpDecoder())
          .transform(grpcDecompressor())
          .listen(_onResponseData,
              onError: _onResponseError,
              onDone: _onResponseDone,
              cancelOnError: true);
      if (_responses.isPaused) {
        _responseSubscription.pause();
      }
      _responses.onPause = _responseSubscription.pause;
      _responses.onResume = _responseSubscription.resume;
      _responses.onCancel = _responseSubscription.cancel;
    }
  }

  /// Emit an error response to the user, and tear down this call.
  void _responseError(GrpcError error) {
    _responses.addError(error);
    _responseSubscription.cancel();
    _stream.terminate();
    _responses.close();
  }

  /// Data handler for responses coming from the server. Handles header/trailer
  /// metadata, and forwards response objects to [_responses].
  void _onResponseData(GrpcMessage data) {
    if (data is GrpcData) {
      if (!_headers.isCompleted) {
        _responseError(new GrpcError(1217, 'Received data before headers'));
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(new GrpcError(1218, 'Received data after trailers'));
        return;
      }
      _responses.add(_responseDeserializer(data.data));
      _hasReceivedResponses = true;
    } else if (data is GrpcMetadata) {
      if (!_headers.isCompleted) {
        // TODO(jakobr): Parse, and extract common headers.
        _headerMetadata = data.metadata;
        _headers.complete(_headerMetadata);
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(new GrpcError(1219, 'Received multiple trailers'));
        return;
      }
      final metadata = data.metadata;
      _trailers.complete(metadata);
      // TODO(jakobr): Parse more!
      if (metadata.containsKey('grpc-status')) {
        final status = int.parse(metadata['grpc-status']);
        final message = metadata['grpc-message'];
        if (status != 0) {
          _responseError(new GrpcError(status, message, metadata));
        }
      }
    } else {
      _responseError(new GrpcError(1220, 'Unexpected frame received'));
    }
  }

  /// Handler for response errors. Forward the error to the [_responses] stream,
  /// wrapped if necessary.
  void _onResponseError(error) {
    if (error is GrpcError) {
      _responseError(error);
      return;
    }
    _responseError(new GrpcError(1221, error.toString()));
  }

  /// Handles closure of the response stream. Verifies that server has sent
  /// response messages and header/trailer metadata, as necessary.
  void _onResponseDone() {
    if (!_headers.isCompleted) {
      _responseError(new GrpcError(1223, 'Did not receive anything'));
      return;
    }
    if (!_trailers.isCompleted) {
      if (_hasReceivedResponses) {
        // Trailers are required after receiving data.
        _responseError(new GrpcError(1222, 'Missing trailers'));
        return;
      }

      // Only received a header frame and no data frames, so the header
      // should contain "trailers" as well (Trailers-Only).
      final status = _headerMetadata['grpc-status'];
      final statusCode = status != null ? int.parse(status) : 0;
      if (statusCode != 0) {
        final message = _headerMetadata['grpc-message'];
        _responseError(new GrpcError(statusCode, message, _headerMetadata));
      }
      // If status code is missing, we must treat it as '0'. As in 'success'.
    }
    _responses.close();
    _responseSubscription.cancel();
  }

  /// Error handler for the requests stream. Something went wrong while trying
  /// to send the request to the server. Abort the request, and forward the
  /// error to the user code on the [_responses] stream.
  void _onRequestError(error) {
    if (error is! GrpcError) {
      error = new GrpcError(1217, error.toString());
    }

    _responses.addError(error);
    _responses.close();
    _responseSubscription?.cancel();
    _stream.terminate();
  }

  StreamSink<Q> get request => _requests.sink;
  Stream<R> get response => _responses.stream;

  @override
  Future<Map<String, String>> get headers => _headers.future;

  @override
  Future<Map<String, String>> get trailers => _trailers.future;

  @override
  Future<Null> cancel() async {
    _stream.terminate();
    final futures = <Future>[
      _requests.close(),
      _responses.close(),
    ];
    if (_responseSubscription != null) {
      futures.add(_responseSubscription.cancel());
    }
    await Future.wait(futures);
  }
}
