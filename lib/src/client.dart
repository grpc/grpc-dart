// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Dart gRPC client implementation.

import 'dart:async';
import 'dart:io';

import 'package:http2/transport.dart';

import 'shared.dart';
import 'status.dart';
import 'streams.dart';

const _reservedHeaders = const [
  'content-type',
  'te',
  'grpc-timeout',
  'grpc-accept-encoding',
  'user-agent',
];

/// Runtime options for a RPC call.
class CallOptions {
  final Map<String, String> metadata;
  final Duration timeout;

  CallOptions._(this.metadata, this.timeout);

  factory CallOptions({Map<String, String> metadata, Duration timeout}) {
    final sanitizedMetadata = <String, String>{};
    metadata?.forEach((key, value) {
      final lowerCaseKey = key.toLowerCase();
      if (!lowerCaseKey.startsWith(':') &&
          !_reservedHeaders.contains(lowerCaseKey)) {
        sanitizedMetadata[lowerCaseKey] = value;
      }
    });
    return new CallOptions._(new Map.unmodifiable(sanitizedMetadata), timeout);
  }
}

/// A channel to an RPC endpoint.
class ClientChannel {
  final String host;
  final int port;
  final CallOptions options;

  final List<Socket> _sockets = [];
  final List<TransportConnection> _connections = [];

  ClientChannel(this.host, {this.port = 8080, this.options});

  /// Returns a connection to this [Channel]'s RPC endpoint. The connection may
  /// be shared between multiple RPC calls.
  Future<ClientTransportConnection> connect() async {
    final socket = await Socket.connect(host, port);
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
  final String path;
  final List<int> Function(Q value) requestSerializer;
  final R Function(List<int> value) responseDeserializer;

  ClientMethod(this.path, this.requestSerializer, this.responseDeserializer);
}

/// An active call to a gRPC endpoint.
class ClientCall<Q, R> implements Response {
  static final _methodPost = new Header.ascii(':method', 'POST');
  static final _schemeHttp = new Header.ascii(':scheme', 'http');
  static final _contentTypeGrpc =
      new Header.ascii('content-type', 'application/grpc');
  static final _teTrailers = new Header.ascii('te', 'trailers');
  static final _grpcAcceptEncoding =
      new Header.ascii('grpc-accept-encoding', 'identity');
  static final _userAgent = new Header.ascii('user-agent', 'dart-grpc/0.2.0');

  final ClientChannel _channel;
  final ClientMethod<Q, R> _method;

  final Completer<Map<String, String>> _headers = new Completer();
  final Completer<Map<String, String>> _trailers = new Completer();
  bool _hasReceivedResponses = false;

  Map<String, String> _headerMetadata;

  TransportStream _stream;
  final _requests = new StreamController<Q>();
  StreamController<R> _responses;
  StreamSubscription<GrpcMessage> _responseSubscription;

  final CallOptions options;

  Future<Null> _callSetup;
  Timer _timeoutTimer;

  ClientCall(this._channel, this._method, {this.options}) {
    _responses = new StreamController(onListen: _onResponseListen);
    final timeout = options?.timeout ?? _channel.options?.timeout;
    if (timeout != null) {
      _timeoutTimer = new Timer(timeout, _onTimedOut);
    }
    _callSetup = _initiateCall(timeout).catchError((error) {
      _responses.addError(
          new GrpcError.unavailable('Error connecting: ${error.toString()}'));
      _timeoutTimer?.cancel();
    });
  }

  void _onTimedOut() {
    _responses.addError(new GrpcError.deadlineExceeded('Deadline exceeded'));
    cancel().catchError((_) {});
  }

  static List<Header> createCallHeaders(String path, String authority,
      {String timeout, Map<String, String> metadata}) {
    // TODO(jakobr): Populate HTTP-specific headers in connection?
    final headers = <Header>[
      _methodPost,
      _schemeHttp,
      new Header.ascii(':path', path),
      new Header.ascii(':authority', authority),
    ];
    if (timeout != null) {
      headers.add(new Header.ascii('grpc-timeout', timeout));
    }
    headers.addAll([
      _contentTypeGrpc,
      _teTrailers,
      _grpcAcceptEncoding,
      _userAgent,
    ]);
    metadata?.forEach((key, value) {
      headers.add(new Header.ascii(key, value));
    });
    return headers;
  }

  Future<Null> _initiateCall(Duration timeout) async {
    final connection = await _channel.connect();
    final timeoutString = toTimeoutString(timeout);
    // TODO(jakobr): Flip this around, and have the Channel create the call
    // object and apply options (including the above TODO).
    final customMetadata = <String, String>{};
    customMetadata.addAll(_channel.options?.metadata ?? {});
    customMetadata.addAll(options?.metadata ?? {});
    final headers = createCallHeaders(_method.path, _channel.host,
        timeout: timeoutString, metadata: customMetadata);
    _stream = connection.makeRequest(headers);
    _requests.stream
        .map(_method.requestSerializer)
        .map(GrpcHttpEncoder.frame)
        .map<StreamMessage>((bytes) => new DataStreamMessage(bytes))
        .handleError(_onRequestError)
        .pipe(_stream.outgoingMessages)
        .catchError(_onRequestError);
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
    _timeoutTimer?.cancel();
    _responseSubscription.cancel();
    _responses.close();
    _stream.terminate();
  }

  /// Data handler for responses coming from the server. Handles header/trailer
  /// metadata, and forwards response objects to [_responses].
  void _onResponseData(GrpcMessage data) {
    if (data is GrpcData) {
      if (!_headers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received data before headers'));
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received data after trailers'));
        return;
      }
      _responses.add(_method.responseDeserializer(data.data));
      _hasReceivedResponses = true;
    } else if (data is GrpcMetadata) {
      if (!_headers.isCompleted) {
        // TODO(jakobr): Parse, and extract common headers.
        _headerMetadata = data.metadata;
        _headers.complete(_headerMetadata);
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received multiple trailers'));
        return;
      }
      final metadata = data.metadata;
      _trailers.complete(metadata);
      // TODO(jakobr): Parse more!
      if (metadata.containsKey('grpc-status')) {
        final status = int.parse(metadata['grpc-status']);
        final message = metadata['grpc-message'];
        if (status != 0) {
          _responseError(new GrpcError.custom(status, message));
        }
      }
    } else {
      _responseError(new GrpcError.unimplemented('Unexpected frame received'));
    }
  }

  /// Handler for response errors. Forward the error to the [_responses] stream,
  /// wrapped if necessary.
  void _onResponseError(error) {
    if (error is GrpcError) {
      _responseError(error);
      return;
    }
    _responseError(new GrpcError.unknown(error.toString()));
  }

  /// Handles closure of the response stream. Verifies that server has sent
  /// response messages and header/trailer metadata, as necessary.
  void _onResponseDone() {
    if (!_headers.isCompleted) {
      _responseError(new GrpcError.unavailable('Did not receive anything'));
      return;
    }
    if (!_trailers.isCompleted) {
      if (_hasReceivedResponses) {
        // Trailers are required after receiving data.
        _responseError(new GrpcError.unavailable('Missing trailers'));
        return;
      }

      // Only received a header frame and no data frames, so the header
      // should contain "trailers" as well (Trailers-Only).
      _trailers.complete(_headerMetadata);
      final status = _headerMetadata['grpc-status'];
      // If status code is missing, we must treat it as '0'. As in 'success'.
      final statusCode = status != null ? int.parse(status) : 0;
      if (statusCode != 0) {
        final message = _headerMetadata['grpc-message'];
        _responseError(new GrpcError.custom(statusCode, message));
      }
    }
    _timeoutTimer?.cancel();
    _responses.close();
    _responseSubscription.cancel();
  }

  /// Error handler for the requests stream. Something went wrong while trying
  /// to send the request to the server. Abort the request, and forward the
  /// error to the user code on the [_responses] stream.
  void _onRequestError(error) {
    if (error is! GrpcError) {
      error = new GrpcError.unknown(error.toString());
    }

    _responses.addError(error);
    _timeoutTimer?.cancel();
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
    _timeoutTimer?.cancel();
    _callSetup.whenComplete(() {
      // Terminate the stream if the call connects after being canceled.
      _stream?.terminate();
    });
    // Don't await _responses.close() here. It'll only complete once the done
    // event has been delivered, and it's the caller of this function that is
    // reading from responses as well, so we might end up deadlocked.
    _responses.close();
    _stream?.terminate();
    final futures = <Future>[_requests.close()];
    if (_responseSubscription != null) {
      futures.add(_responseSubscription.cancel());
    }
    await Future.wait(futures);
  }
}
