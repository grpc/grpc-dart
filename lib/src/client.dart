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

/// Options controlling how connections are made on a [ClientChannel].
class ChannelOptions {
  final bool _useTls;
  final List<int> _certificateBytes;
  final String _certificatePassword;
  final String authority;

  const ChannelOptions._(this._useTls,
      [this._certificateBytes, this._certificatePassword, this.authority]);

  /// Enable TLS using the default trust store.
  const ChannelOptions() : this._(true);

  /// Disable TLS. RPCs are sent in clear text.
  const ChannelOptions.insecure() : this._(false);

  /// Enable TLS and specify the [certificate]s to trust.
  ChannelOptions.secure(
      {List<int> certificate, String password, String authority})
      : this._(true, certificate, password, authority);

  SecurityContext get securityContext {
    if (!_useTls) return null;
    final context = createSecurityContext(false);
    if (_certificateBytes != null) {
      context.setTrustedCertificatesBytes(_certificateBytes,
          password: _certificatePassword);
    }
    return context;
  }
}

/// A connection to a single RPC endpoint.
///
/// RPCs made on a connection are always sent to the same endpoint.
class ClientConnection {
  static final _methodPost = new Header.ascii(':method', 'POST');
  static final _schemeHttp = new Header.ascii(':scheme', 'http');
  static final _schemeHttps = new Header.ascii(':scheme', 'https');
  static final _contentTypeGrpc =
      new Header.ascii('content-type', 'application/grpc');
  static final _teTrailers = new Header.ascii('te', 'trailers');
  static final _grpcAcceptEncoding =
      new Header.ascii('grpc-accept-encoding', 'identity');
  static final _userAgent = new Header.ascii('user-agent', 'dart-grpc/0.2.0');

  final ClientTransportConnection _transport;

  ClientConnection(this._transport);

  static List<Header> createCallHeaders(
      bool useTls, String authority, String path, CallOptions options) {
    final headers = [
      _methodPost,
      useTls ? _schemeHttps : _schemeHttp,
      new Header.ascii(':path', path),
      new Header.ascii(':authority', authority),
    ];
    if (options.timeout != null) {
      headers.add(
          new Header.ascii('grpc-timeout', toTimeoutString(options.timeout)));
    }
    headers.addAll([
      _contentTypeGrpc,
      _teTrailers,
      _grpcAcceptEncoding,
      _userAgent,
    ]);
    options.metadata.forEach((key, value) {
      headers.add(new Header.ascii(key, value));
    });
    return headers;
  }

  /// Shuts down this connection.
  ///
  /// No further calls may be made on this connection, but existing calls
  /// are allowed to finish.
  Future<Null> shutdown() {
    // TODO(jakobr): Manage streams, close [_transport] when all are done.
    return _transport.finish();
  }

  /// Terminates this connection.
  ///
  /// All open calls are terminated immediately, and no further calls may be
  /// made on this connection.
  Future<Null> terminate() {
    // TODO(jakobr): Manage streams, close them immediately.
    return _transport.terminate();
  }

  /// Starts a new RPC on this connection.
  ///
  /// Creates a new transport stream on this connection, and sends initial call
  /// metadata.
  ClientTransportStream sendRequest(
      bool useTls, String authority, String path, CallOptions options) {
    final headers = createCallHeaders(useTls, authority, path, options);
    final stream = _transport.makeRequest(headers);
    // TODO(jakobr): Manage streams. Subscribe to stream state changes.
    return stream;
  }
}

/// A channel to a virtual RPC endpoint.
///
/// For each RPC, the channel picks a [ClientConnection] to dispatch the call.
/// RPCs on the same channel may be sent to different connections, depending on
/// load balancing settings.
class ClientChannel {
  final String host;
  final int port;
  final ChannelOptions options;

  final _connections = <ClientConnection>[];

  bool _isShutdown = false;

  ClientChannel(this.host,
      {this.port = 443, this.options = const ChannelOptions()});

  String get authority => options.authority ?? host;

  void _shutdownCheck([Function() cleanup]) {
    if (!_isShutdown) return;
    if (cleanup != null) cleanup();
    throw new GrpcError.unavailable('Channel shutting down.');
  }

  /// Shuts down this channel.
  ///
  /// No further RPCs can be made on this channel. RPCs already in progress will
  /// be allowed to complete.
  Future<Null> shutdown() {
    if (_isShutdown) return new Future.value();
    _isShutdown = true;
    return Future.wait(_connections.map((c) => c.shutdown()));
  }

  /// Terminates this channel.
  ///
  /// RPCs already in progress will be terminated. No further RPCs can be made
  /// on this channel.
  Future<Null> terminate() {
    _isShutdown = true;
    return Future.wait(_connections.map((c) => c.terminate()));
  }

  /// Returns a connection to this [Channel]'s RPC endpoint.
  ///
  /// The connection may be shared between multiple RPCs.
  Future<ClientConnection> connect() async {
    _shutdownCheck();
    final securityContext = options.securityContext;

    var socket = await Socket.connect(host, port);
    _shutdownCheck(socket.destroy);
    if (securityContext != null) {
      socket = await SecureSocket.secure(socket,
          host: authority, context: securityContext);
      _shutdownCheck(socket.destroy);
    }
    final connection =
        new ClientConnection(new ClientTransportConnection.viaSocket(socket));
    _connections.add(connection);
    return connection;
  }

  /// Initiates a new RPC on this connection.
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = new ClientCall(method, requests, options.timeout);
    connect().then((connection) {
      // TODO(jakobr): Check if deadline is exceeded.
      if (call._isCancelled) return;
      final stream = connection.sendRequest(
          this.options._useTls, authority, method.path, options);
      call._onConnectedStream(stream);
    }, onError: (error) {
      call._onConnectError(error);
    });
    return call;
  }
}

/// Description of a gRPC method.
class ClientMethod<Q, R> {
  final String path;
  final List<int> Function(Q value) requestSerializer;
  final R Function(List<int> value) responseDeserializer;

  ClientMethod(this.path, this.requestSerializer, this.responseDeserializer);
}

/// Runtime options for an RPC.
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

  CallOptions mergedWith(CallOptions other) {
    if (other == null) return this;
    final mergedMetadata = new Map.from(metadata)..addAll(other.metadata);
    final mergedTimeout = other.timeout ?? timeout;
    return new CallOptions._(
        new Map.unmodifiable(mergedMetadata), mergedTimeout);
  }
}

/// Base class for client stubs.
class Client {
  final ClientChannel _channel;
  final CallOptions _options;

  Client(this._channel, {CallOptions options})
      : _options = options ?? new CallOptions();

  ClientCall<Q, R> $createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests,
      {CallOptions options}) {
    return _channel.createCall(method, requests, _options.mergedWith(options));
  }
}

/// An active call to a gRPC endpoint.
class ClientCall<Q, R> implements Response {
  final ClientMethod<Q, R> _method;
  final Stream<Q> _requests;

  final _headers = new Completer<Map<String, String>>();
  final _trailers = new Completer<Map<String, String>>();
  bool _hasReceivedResponses = false;

  Map<String, String> _headerMetadata;

  TransportStream _stream;
  StreamController<R> _responses;
  StreamSubscription<StreamMessage> _requestSubscription;
  StreamSubscription<GrpcMessage> _responseSubscription;

  bool _isCancelled = false;
  Timer _timeoutTimer;

  ClientCall(this._method, this._requests, Duration timeout) {
    _responses = new StreamController(onListen: _onResponseListen);
    if (timeout != null) {
      _timeoutTimer = new Timer(timeout, _onTimedOut);
    }
  }

  void _onConnectError(error) {
    if (!_responses.isClosed) {
      _responses
          .addError(new GrpcError.unavailable('Error connecting: $error'));
    }
    _safeTerminate();
  }

  void _onConnectedStream(ClientTransportStream stream) {
    if (_isCancelled) {
      // Should not happen, but just in case.
      stream.terminate();
      return;
    }
    _stream = stream;
    _requestSubscription = _requests
        .map(_method.requestSerializer)
        .map(GrpcHttpEncoder.frame)
        .map<StreamMessage>((bytes) => new DataStreamMessage(bytes))
        .handleError(_onRequestError)
        .listen(_stream.outgoingMessages.add,
            onError: _stream.outgoingMessages.addError,
            onDone: _stream.outgoingMessages.close,
            cancelOnError: true);
    // The response stream might have been listened to before _stream was ready,
    // so try setting up the subscription here as well.
    _onResponseListen();
  }

  void _onTimedOut() {
    _responses.addError(new GrpcError.deadlineExceeded('Deadline exceeded'));
    _safeTerminate();
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
    _requestSubscription?.cancel();
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
    _requestSubscription?.cancel();
    _responseSubscription?.cancel();
    _stream.terminate();
  }

  Stream<R> get response => _responses.stream;

  @override
  Future<Map<String, String>> get headers => _headers.future;

  @override
  Future<Map<String, String>> get trailers => _trailers.future;

  @override
  Future<Null> cancel() {
    if (!_responses.isClosed) {
      _responses.addError(new GrpcError.cancelled('Cancelled by client.'));
    }
    return _terminate();
  }

  Future<Null> _terminate() async {
    _isCancelled = true;
    _timeoutTimer?.cancel();
    // Don't await _responses.close() here. It'll only complete once the done
    // event has been delivered, and it's the caller of this function that is
    // reading from responses as well, so we might end up deadlocked.
    _responses.close();
    _stream?.terminate();
    final futures = <Future>[];
    if (_requestSubscription != null) {
      futures.add(_requestSubscription.cancel());
    }
    if (_responseSubscription != null) {
      futures.add(_responseSubscription.cancel());
    }
    await Future.wait(futures);
  }

  Future<Null> _safeTerminate() {
    return _terminate().catchError((_) {});
  }
}
