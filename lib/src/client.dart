// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Dart gRPC client implementation.

import 'dart:async';
import 'dart:io';

import 'dart:math';
import 'package:http2/transport.dart';
import 'package:meta/meta.dart';

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

const defaultIdleTimeout = const Duration(minutes: 5);

typedef Duration BackoffStrategy(Duration lastBackoff);

// Backoff algorithm from https://github.com/grpc/grpc/blob/master/doc/connection-backoff.md
const _minConnectTimeout = const Duration(seconds: 20);
const _initialBackoff = const Duration(seconds: 1);
const _maxBackoff = const Duration(seconds: 120);
const _multiplier = 1.6;
const _jitter = 0.2;
final _random = new Random();

Duration defaultBackoffStrategy(Duration lastBackoff) {
  if (lastBackoff == null) return _initialBackoff;
  final jitter = _random.nextDouble() * 2 * _jitter - _jitter;
  final nextBackoff = lastBackoff * (_multiplier + jitter);
  return nextBackoff < _maxBackoff ? nextBackoff : _maxBackoff;
}

/// Options controlling how connections are made on a [ClientChannel].
class ChannelOptions {
  final bool isSecure;
  final List<int> _certificateBytes;
  final String _certificatePassword;
  final String authority;
  final Duration idleTimeout;
  final BackoffStrategy backoffStrategy;

  const ChannelOptions._(
      this.isSecure,
      this._certificateBytes,
      this._certificatePassword,
      this.authority,
      Duration idleTimeout,
      BackoffStrategy backoffStrategy)
      : this.idleTimeout = idleTimeout ?? defaultIdleTimeout,
        this.backoffStrategy = backoffStrategy ?? defaultBackoffStrategy;

  /// Disable TLS. RPCs are sent in clear text.
  const ChannelOptions.insecure(
      {Duration idleTimeout,
      BackoffStrategy backoffStrategy =
          defaultBackoffStrategy}) // Remove when dart-lang/sdk#31066 is fixed.
      : this._(false, null, null, null, idleTimeout, backoffStrategy);

  /// Enable TLS and optionally specify the [certificate]s to trust. If
  /// [certificates] is not provided, the default trust store is used.
  const ChannelOptions.secure(
      {List<int> certificate,
      String password,
      String authority,
      Duration idleTimeout,
      BackoffStrategy backoffStrategy =
          defaultBackoffStrategy}) // Remove when dart-lang/sdk#31066 is fixed.
      : this._(true, certificate, password, authority, idleTimeout,
            backoffStrategy);

  SecurityContext get securityContext {
    if (!isSecure) return null;
    if (_certificateBytes != null) {
      return createSecurityContext(false)
        ..setTrustedCertificatesBytes(_certificateBytes,
            password: _certificatePassword);
    }
    final context = new SecurityContext(withTrustedRoots: true);
    if (SecurityContext.alpnSupported) {
      context.setAlpnProtocols(supportedAlpnProtocols, false);
    }
    return context;
  }
}

enum ConnectionState {
  /// Actively trying to connect.
  connecting,

  /// Connection successfully established.
  ready,

  /// Some transient failure occurred, waiting to re-connect.
  transientFailure,

  /// Not currently connected, and no pending RPCs.
  idle,

  /// Shutting down, no further RPCs allowed.
  shutdown
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

  final String host;
  final int port;
  final ChannelOptions options;

  ConnectionState _state = ConnectionState.idle;
  void Function(ClientConnection connection) onStateChanged;
  final _pendingCalls = <ClientCall>[];

  ClientTransportConnection _transport;

  /// Used for idle and reconnect timeout, depending on [_state].
  Timer _timer;
  Duration _currentReconnectDelay;

  ClientConnection(this.host, this.port, this.options);

  ConnectionState get state => _state;

  static List<Header> createCallHeaders(bool useTls, String authority,
      String path, Duration timeout, Map<String, String> metadata) {
    final headers = [
      _methodPost,
      useTls ? _schemeHttps : _schemeHttp,
      new Header.ascii(':path', path),
      new Header.ascii(':authority', authority),
    ];
    if (timeout != null) {
      headers.add(new Header.ascii('grpc-timeout', toTimeoutString(timeout)));
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

  String get authority => options.authority ?? host;

  @visibleForTesting
  Future<ClientTransportConnection> connectTransport() async {
    final securityContext = options.securityContext;

    var socket = await Socket.connect(host, port);
    if (_state == ConnectionState.shutdown) {
      socket.destroy();
      throw 'Shutting down';
    }
    if (securityContext != null) {
      socket = await SecureSocket.secure(socket,
          host: authority, context: securityContext);
      if (_state == ConnectionState.shutdown) {
        socket.destroy();
        throw 'Shutting down';
      }
    }
    socket.done.then(_handleSocketClosed);
    return new ClientTransportConnection.viaSocket(socket);
  }

  void _connect() {
    if (_state != ConnectionState.idle &&
        _state != ConnectionState.transientFailure) {
      return;
    }
    _setState(ConnectionState.connecting);
    connectTransport().then((transport) {
      _currentReconnectDelay = null;
      _transport = transport;
      _transport.onActiveStateChanged = _handleActiveStateChanged;
      _setState(ConnectionState.ready);
      _pendingCalls.forEach(_startCall);
      _pendingCalls.clear();
    }).catchError(_handleTransientFailure);
  }

  void dispatchCall(ClientCall call) {
    switch (_state) {
      case ConnectionState.ready:
        _startCall(call);
        break;
      case ConnectionState.shutdown:
        _shutdownCall(call);
        break;
      default:
        _pendingCalls.add(call);
        if (_state == ConnectionState.idle) {
          _connect();
        }
    }
  }

  ClientTransportStream makeRequest(
      String path, Duration timeout, Map<String, String> metadata) {
    final headers =
        createCallHeaders(options.isSecure, authority, path, timeout, metadata);
    return _transport.makeRequest(headers);
  }

  void _startCall(ClientCall call) {
    if (call._isCancelled) return;
    call._onConnectionReady(this);
  }

  void _shutdownCall(ClientCall call) {
    if (call._isCancelled) return;
    call._onConnectionError(
        new GrpcError.unavailable('Connection shutting down.'));
  }

  /// Shuts down this connection.
  ///
  /// No further calls may be made on this connection, but existing calls
  /// are allowed to finish.
  Future<Null> shutdown() {
    if (_state == ConnectionState.shutdown) return new Future.value();
    _setShutdownState();
    return _transport?.finish() ?? new Future.value();
  }

  /// Terminates this connection.
  ///
  /// All open calls are terminated immediately, and no further calls may be
  /// made on this connection.
  Future<Null> terminate() {
    _setShutdownState();
    return _transport?.terminate() ?? new Future.value();
  }

  void _setShutdownState() {
    _setState(ConnectionState.shutdown);
    _cancelTimer();
    _pendingCalls.forEach(_shutdownCall);
    _pendingCalls.clear();
  }

  void _setState(ConnectionState state) {
    _state = state;
    if (onStateChanged != null) {
      onStateChanged(this);
    }
  }

  void _handleIdleTimeout() {
    if (_timer == null || _state != ConnectionState.ready) return;
    _cancelTimer();
    _transport?.finish()?.catchError((_) => {}); // TODO(jakobr): Log error.
    _transport = null;
    _setState(ConnectionState.idle);
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _handleActiveStateChanged(bool isActive) {
    if (isActive) {
      _cancelTimer();
    } else {
      if (options.idleTimeout != null) {
        _timer ??= new Timer(options.idleTimeout, _handleIdleTimeout);
      }
    }
  }

  bool _hasPendingCalls() {
    // Get rid of pending calls that have timed out.
    _pendingCalls.removeWhere((call) => call._isCancelled);
    return _pendingCalls.isNotEmpty;
  }

  void _handleTransientFailure(error) {
    _transport = null;
    if (_state == ConnectionState.shutdown || _state == ConnectionState.idle) {
      return;
    }
    // TODO(jakobr): Log error.
    _cancelTimer();
    if (!_hasPendingCalls()) {
      _setState(ConnectionState.idle);
      return;
    }
    _setState(ConnectionState.transientFailure);
    _currentReconnectDelay = options.backoffStrategy(_currentReconnectDelay);
    _timer = new Timer(_currentReconnectDelay, _handleReconnect);
  }

  void _handleReconnect() {
    if (_timer == null || _state != ConnectionState.transientFailure) return;
    _cancelTimer();
    _connect();
  }

  void _handleSocketClosed(Socket _) {
    _cancelTimer();
    if (_state != ConnectionState.idle && _state != ConnectionState.shutdown) {
      // We were not planning to close the socket.
      _handleTransientFailure('Socket closed');
    }
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

  // TODO(jakobr): Multiple connections, load balancing.
  ClientConnection _connection;

  bool _isShutdown = false;

  ClientChannel(this.host,
      {this.port = 443, this.options = const ChannelOptions.secure()});

  /// Shuts down this channel.
  ///
  /// No further RPCs can be made on this channel. RPCs already in progress will
  /// be allowed to complete.
  Future<Null> shutdown() {
    if (_isShutdown) return new Future.value();
    _isShutdown = true;
    return _connection.shutdown();
  }

  /// Terminates this channel.
  ///
  /// RPCs already in progress will be terminated. No further RPCs can be made
  /// on this channel.
  Future<Null> terminate() {
    _isShutdown = true;
    return _connection.terminate();
  }

  /// Returns a connection to this [Channel]'s RPC endpoint.
  ///
  /// The connection may be shared between multiple RPCs.
  Future<ClientConnection> getConnection() async {
    if (_isShutdown) throw new GrpcError.unavailable('Channel shutting down.');
    return _connection ??= new ClientConnection(host, port, options);
  }

  /// Initiates a new RPC on this connection.
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = new ClientCall(method, requests, options);
    getConnection().then((connection) {
      if (call._isCancelled) return;
      connection.dispatchCall(call);
    }, onError: call._onConnectionError);
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

/// Provides per-RPC metadata.
///
/// Metadata providers will be invoked for every RPC, and can add their own
/// metadata to the RPC. If the function returns a [Future], the RPC will await
/// completion of the returned [Future] before transmitting the request.
///
/// The metadata provider is given the current metadata map (possibly modified
/// by previous metadata providers), and is expected to modify the map before
/// returning or before completing the returned [Future].
typedef FutureOr<Null> MetadataProvider(Map<String, String> metadata);

/// Runtime options for an RPC.
class CallOptions {
  final Map<String, String> metadata;
  final Duration timeout;
  final List<MetadataProvider> metadataProviders;

  CallOptions._(this.metadata, this.timeout, this.metadataProviders);

  /// Creates a [CallOptions] object.
  ///
  /// [CallOptions] can specify static [metadata], set the [timeout], and
  /// configure per-RPC metadata [providers]. The metadata [providers] are
  /// invoked in order for every RPC, and can modify the outgoing metadata
  /// (including metadata provided by previous providers).
  factory CallOptions(
      {Map<String, String> metadata,
      Duration timeout,
      List<MetadataProvider> providers}) {
    return new CallOptions._(new Map.unmodifiable(metadata ?? {}), timeout,
        new List.unmodifiable(providers ?? []));
  }

  factory CallOptions.from(Iterable<CallOptions> options) =>
      options.fold(new CallOptions(), (p, o) => p.mergedWith(o));

  CallOptions mergedWith(CallOptions other) {
    if (other == null) return this;
    final mergedMetadata = new Map.from(metadata)..addAll(other.metadata);
    final mergedTimeout = other.timeout ?? timeout;
    final mergedProviders = new List.from(metadataProviders)
      ..addAll(other.metadataProviders);
    return new CallOptions._(new Map.unmodifiable(mergedMetadata),
        mergedTimeout, new List.unmodifiable(mergedProviders));
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
  final CallOptions options;

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

  ClientCall(this._method, this._requests, this.options) {
    _responses = new StreamController(onListen: _onResponseListen);
    if (options.timeout != null) {
      _timeoutTimer = new Timer(options.timeout, _onTimedOut);
    }
  }

  String get path => _method.path;

  void _onConnectionError(error) {
    _terminateWithError(new GrpcError.unavailable('Error connecting: $error'));
  }

  void _terminateWithError(GrpcError error) {
    if (!_responses.isClosed) {
      _responses.addError(error);
    }
    _safeTerminate();
  }

  static Map<String, String> _sanitizeMetadata(Map<String, String> metadata) {
    final sanitizedMetadata = <String, String>{};
    metadata.forEach((String key, String value) {
      final lowerCaseKey = key.toLowerCase();
      if (!lowerCaseKey.startsWith(':') &&
          !_reservedHeaders.contains(lowerCaseKey)) {
        sanitizedMetadata[lowerCaseKey] = value;
      }
    });
    return sanitizedMetadata;
  }

  void _onConnectionReady(ClientConnection connection) {
    if (_isCancelled) return;

    if (options.metadataProviders.isEmpty) {
      _sendRequest(connection, _sanitizeMetadata(options.metadata));
    } else {
      final metadata = new Map.from(options.metadata);
      Future
          .forEach(options.metadataProviders, (provider) => provider(metadata))
          .then((_) => _sendRequest(connection, _sanitizeMetadata(metadata)))
          .catchError(_onMetadataProviderError);
    }
  }

  void _onMetadataProviderError(error) {
    _terminateWithError(new GrpcError.internal('Error making call: $error'));
  }

  void _sendRequest(ClientConnection connection, Map<String, String> metadata) {
    _stream = connection.makeRequest(path, options.timeout, metadata);
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
