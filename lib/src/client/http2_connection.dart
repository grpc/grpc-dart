// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
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
import 'dart:io';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:http2/transport.dart';

import '../shared/codec.dart';
import '../shared/status.dart';
import '../shared/timeout.dart';
import 'call.dart';
import 'client_keepalive.dart';
import 'client_transport_connector.dart';
import 'connection.dart' hide ClientConnection;
import 'connection.dart' as connection;
import 'options.dart';
import 'proxy.dart';
import 'transport/http2_credentials.dart';
import 'transport/http2_transport.dart';
import 'transport/transport.dart';

class Http2ClientConnection
    implements
        connection.ClientConnection,
        connection.NonMutatingMetadataConnection {
  static final _methodPost = Header.ascii(':method', 'POST');
  static final _schemeHttp = Header.ascii(':scheme', 'http');
  static final _schemeHttps = Header.ascii(':scheme', 'https');
  static final _pathNameBytes = ascii.encode(':path');
  static final _authorityNameBytes = ascii.encode(':authority');
  static final _contentTypeGrpc = Header.ascii(
    'content-type',
    'application/grpc',
  );
  static final _teTrailers = Header.ascii('te', 'trailers');
  static final _defaultUserAgentHeader = Header.ascii(
    'user-agent',
    defaultUserAgent,
  );
  static final _gzipEncodingHeader = Header.ascii('grpc-encoding', 'gzip');
  static final _identityEncodingHeader = Header.ascii(
    'grpc-encoding',
    'identity',
  );
  static final Expando<List<Header>> _cachedCallOptionHeaders =
      Expando<List<Header>>();
  static const int _maxCachedPathHeaders = 256;

  final ChannelOptions options;

  late final Header _userAgentHeader = options.userAgent == defaultUserAgent
      ? _defaultUserAgentHeader
      : Header.ascii('user-agent', options.userAgent);
  final Map<String, Header> _pathHeaderCache = {};
  String? _cachedAuthority;
  Header? _cachedAuthorityHeader;
  String? _cachedSupportedEncodings;
  Header? _cachedAcceptEncodingHeader;

  connection.ConnectionState _state = ConnectionState.idle;

  void Function(connection.ConnectionState)? onStateChanged;

  final _pendingCalls = <ClientCall>[];

  final ClientTransportConnector _transportConnector;
  ClientTransportConnection? _transportConnection;
  Completer<void>? _connectingShutdown;

  /// Used for idle and reconnect timeout, depending on [_state].
  Timer? _timer;

  /// Used for making sure a single connection is not kept alive too long.
  final Stopwatch _connectionLifeTimer = Stopwatch();

  Duration? _currentReconnectDelay;

  ClientKeepAlive? keepAliveManager;

  Http2ClientConnection(Object host, int port, this.options)
    : _transportConnector = SocketTransportConnector(host, port, options);

  Http2ClientConnection.fromClientTransportConnector(
    this._transportConnector,
    this.options,
  );

  ChannelCredentials get credentials => options.credentials;

  @override
  String get authority => _transportConnector.authority;

  @override
  String get scheme => options.credentials.isSecure ? 'https' : 'http';

  ConnectionState get state => _state;

  Future<ClientTransportConnection> connectTransport() async {
    final connectStopwatch = options.connectTimeout != null
        ? (clock.stopwatch()..start())
        : null;
    final connection = await _transportConnector.connect();
    if (_state == ConnectionState.shutdown) {
      _transportConnector.shutdown();
      throw _ShutdownException();
    }

    final connectorDone = _transportConnector.done;
    final shutdownSignal = Completer<void>();
    _connectingShutdown = shutdownSignal;

    final outcomeFuture = Future.any<_InitialSettingsOutcome>([
      connection.onInitialPeerSettingsReceived.then(
        _InitialSettingsOutcome.onReceived,
      ),
      connectorDone.then(
        _InitialSettingsOutcome.onClosed,
        onError: _InitialSettingsOutcome.onClosed,
      ),
      shutdownSignal.future.then(_InitialSettingsOutcome.onShutdown),
    ]);

    late final _InitialSettingsOutcome outcome;
    try {
      if (connectStopwatch != null) {
        final remaining = options.connectTimeout! - connectStopwatch.elapsed;
        if (remaining <= Duration.zero) {
          throw TimeoutException(
            'Timed out waiting for initial HTTP/2 SETTINGS frame.',
            options.connectTimeout,
          );
        }
        outcome = await outcomeFuture.timeout(remaining);
      } else {
        outcome = await outcomeFuture;
      }
    } on TimeoutException {
      _transportConnector.shutdown();
      throw GrpcError.unavailable(
        'Timed out waiting for initial HTTP/2 SETTINGS frame.',
      );
    } catch (_) {
      _transportConnector.shutdown();
      rethrow;
    } finally {
      if (identical(_connectingShutdown, shutdownSignal)) {
        _connectingShutdown = null;
      }
    }

    if (outcome == _InitialSettingsOutcome.shutdown ||
        _state == ConnectionState.shutdown) {
      _transportConnector.shutdown();
      throw _ShutdownException();
    }
    if (outcome != _InitialSettingsOutcome.received || !connection.isOpen) {
      _transportConnector.shutdown();
      throw GrpcError.unavailable(
        'Connection closed before receiving initial HTTP/2 SETTINGS frame.',
      );
    }

    connectorDone.then(_abandonConnection, onError: _abandonConnection);
    return connection;
  }

  void _connect() {
    if (_state != ConnectionState.idle &&
        _state != ConnectionState.transientFailure) {
      return;
    }
    _setState(ConnectionState.connecting);
    connectTransport()
        .then<void>((transport) async {
          _currentReconnectDelay = null;
          _transportConnection = transport;
          if (options.keepAlive.shouldSendPings) {
            keepAliveManager = ClientKeepAlive(
              options: options.keepAlive,
              ping: () {
                if (transport.isOpen) {
                  transport.ping();
                }
              },
              onPingTimeout: () => transport.finish(),
            );
            transport.onFrameReceived.listen(
              (_) => keepAliveManager?.onFrameReceived(),
            );
          }
          _connectionLifeTimer
            ..reset()
            ..start();
          transport.onActiveStateChanged = _handleActiveStateChanged;
          _setState(ConnectionState.ready);

          if (_hasPendingCalls()) {
            // Take all pending calls out, and reschedule.
            final pendingCalls = _pendingCalls.toList();
            _pendingCalls.clear();
            pendingCalls.forEach(dispatchCall);
          }
        })
        .catchError(_handleConnectionFailure);
  }

  /// Abandons the current connection if it is unhealthy or has been open for
  /// too long.
  ///
  /// Assumes [_transportConnection] is not `null`.
  void _refreshConnectionIfUnhealthy() {
    final isHealthy = _transportConnection!.isOpen;
    final shouldRefresh =
        _connectionLifeTimer.elapsed > options.connectionTimeout;
    if (shouldRefresh) {
      _transportConnection!.finish();
      keepAliveManager?.onTransportTermination();
    }
    if (!isHealthy || shouldRefresh) {
      _abandonConnection();
    }
  }

  @override
  void dispatchCall(ClientCall call) {
    if (_transportConnection != null) {
      _refreshConnectionIfUnhealthy();
    }
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

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onRequestFailure, {
    CallOptions? callOptions,
  }) {
    final compressionCodec = callOptions?.compression;
    final headers = _buildRequestHeaders(
      path,
      timeout,
      metadata,
      compressionCodec,
      callOptions: callOptions,
    );
    final stream = _transportConnection!.makeRequest(headers);
    return Http2TransportStream(
      stream,
      onRequestFailure,
      options.codecRegistry,
      compressionCodec,
    );
  }

  Header _pathHeader(String path) {
    final existing = _pathHeaderCache[path];
    if (existing != null) return existing;
    if (_pathHeaderCache.length >= _maxCachedPathHeaders) {
      _pathHeaderCache.clear();
    }
    final encoded = Header(_pathNameBytes, utf8.encode(path));
    _pathHeaderCache[path] = encoded;
    return encoded;
  }

  Header _authorityHeader() {
    final currentAuthority = _transportConnector.authority;
    if (identical(_cachedAuthority, currentAuthority) ||
        _cachedAuthority == currentAuthority) {
      return _cachedAuthorityHeader!;
    }
    final encoded = Header(_authorityNameBytes, utf8.encode(currentAuthority));
    _cachedAuthority = currentAuthority;
    _cachedAuthorityHeader = encoded;
    return encoded;
  }

  Header? _defaultAcceptEncodingHeader() {
    final supported = options.codecRegistry?.supportedEncodings;
    if (supported == null) return null;
    if (identical(_cachedSupportedEncodings, supported) ||
        _cachedSupportedEncodings == supported) {
      return _cachedAcceptEncodingHeader;
    }
    final encoded = Header.ascii('grpc-accept-encoding', supported);
    _cachedSupportedEncodings = supported;
    _cachedAcceptEncodingHeader = encoded;
    return encoded;
  }

  static Header _encodingHeader(Codec codec) {
    final name = codec.encodingName;
    if (name == 'gzip') return _gzipEncodingHeader;
    if (name == 'identity') return _identityEncodingHeader;
    return Header.ascii('grpc-encoding', name);
  }

  static List<Header> _encodeMetadataHeaders(Map<String, String> metadata) {
    final encoded = <Header>[];
    metadata.forEach((key, value) {
      encoded.add(Header(ascii.encode(key), utf8.encode(value)));
    });
    return encoded;
  }

  List<Header> _buildRequestHeaders(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    Codec? compressionCodec, {
    CallOptions? callOptions,
  }) {
    final customAccept = callOptions == null
        ? null
        : customGrpcAcceptEncodingOf(callOptions);
    final acceptHeader = customAccept != null
        ? Header.ascii('grpc-accept-encoding', customAccept)
        : _defaultAcceptEncodingHeader();

    final headers = <Header>[
      _methodPost,
      credentials.isSecure ? _schemeHttps : _schemeHttp,
      _pathHeader(path),
      _authorityHeader(),
      if (timeout != null)
        Header.ascii('grpc-timeout', toTimeoutString(timeout)),
      _contentTypeGrpc,
      _teTrailers,
      _userAgentHeader,
      ?acceptHeader,
      if (compressionCodec != null) _encodingHeader(compressionCodec),
    ];

    if (metadata.isNotEmpty) {
      if (callOptions != null &&
          identical(metadata, sanitizedMetadataOf(callOptions))) {
        var cached = _cachedCallOptionHeaders[callOptions];
        if (cached == null) {
          cached = _encodeMetadataHeaders(metadata);
          _cachedCallOptionHeaders[callOptions] = cached;
        }
        headers.addAll(cached);
      } else {
        metadata.forEach((key, value) {
          headers.add(Header(ascii.encode(key), utf8.encode(value)));
        });
      }
    }
    return headers;
  }

  void _startCall(ClientCall call) {
    if (call.isCancelled) return;
    call.onConnectionReady(this);
  }

  void _failCall(ClientCall call, dynamic error) {
    if (call.isCancelled) return;
    call.onConnectionError(error);
  }

  void _shutdownCall(ClientCall call) {
    _failCall(call, 'Connection shutting down.');
  }

  @override
  Future<void> shutdown() async {
    if (_state == ConnectionState.shutdown) return;
    _setShutdownState();
    await _transportConnection?.finish();
    keepAliveManager?.onTransportTermination();
  }

  @override
  Future<void> terminate() async {
    _setShutdownState();
    await _transportConnection?.terminate();
    keepAliveManager?.onTransportTermination();
  }

  void _setShutdownState() {
    _setState(ConnectionState.shutdown);
    final connectingShutdown = _connectingShutdown;
    _connectingShutdown = null;
    if (connectingShutdown != null && !connectingShutdown.isCompleted) {
      connectingShutdown.complete();
    }
    _cancelTimer();
    _pendingCalls.forEach(_shutdownCall);
    _pendingCalls.clear();
  }

  void _setState(ConnectionState state) {
    _state = state;
    onStateChanged?.call(state);
  }

  void _handleIdleTimeout() {
    if (_timer == null || _state != ConnectionState.ready) return;
    _cancelTimer();
    _transportConnection?.finish().catchError(
      (_) {},
    ); // TODO(jakobr): Log error.
    keepAliveManager?.onTransportTermination();
    _disconnect();
    _setState(ConnectionState.idle);
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _handleActiveStateChanged(bool isActive) {
    if (isActive) {
      _cancelTimer();
      keepAliveManager?.onTransportActive();
    } else {
      if (options.idleTimeout != null) {
        _timer ??= Timer(options.idleTimeout!, _handleIdleTimeout);
      }
      keepAliveManager?.onTransportIdle();
    }
  }

  bool _hasPendingCalls() {
    // Get rid of pending calls that have timed out.
    _pendingCalls.removeWhere((call) => call.isCancelled);
    return _pendingCalls.isNotEmpty;
  }

  void _handleConnectionFailure(Object error) {
    _disconnect();
    if (_state == ConnectionState.shutdown || _state == ConnectionState.idle) {
      return;
    }
    // TODO(jakobr): Log error.
    _cancelTimer();
    for (var call in _pendingCalls) {
      _failCall(call, error);
    }
    _pendingCalls.clear();
    keepAliveManager?.onTransportIdle();
    _setState(ConnectionState.idle);
  }

  void _handleReconnect() {
    if (_timer == null || _state != ConnectionState.transientFailure) return;
    _cancelTimer();
    _connect();
  }

  void _disconnect() {
    _transportConnection = null;
    keepAliveManager?.onTransportTermination();
    keepAliveManager = null;
  }

  void _abandonConnection([Object? _, StackTrace? _]) {
    _cancelTimer();
    _disconnect();

    if (_state == ConnectionState.idle || _state == ConnectionState.shutdown) {
      // All good.
      return;
    }

    // We were not planning to close the socket.
    if (!_hasPendingCalls()) {
      // No pending calls. Just hop to idle, and wait for a new RPC.
      keepAliveManager?.onTransportIdle();
      _setState(ConnectionState.idle);
      return;
    }

    // We have pending RPCs. Reconnect after backoff delay.
    _setState(ConnectionState.transientFailure);
    _currentReconnectDelay = options.backoffStrategy(_currentReconnectDelay);
    _timer = Timer(_currentReconnectDelay!, _handleReconnect);
  }

  static List<Header> createCallHeaders(
    bool useTls,
    String authority,
    String path,
    Duration? timeout,
    Map<String, String>? metadata,
    Codec? compressionCodec, {
    String? userAgent,
    String? grpcAcceptEncodings,
  }) {
    final headers = [
      _methodPost,
      useTls ? _schemeHttps : _schemeHttp,
      Header(_pathNameBytes, utf8.encode(path)),
      Header(_authorityNameBytes, utf8.encode(authority)),
      if (timeout != null)
        Header.ascii('grpc-timeout', toTimeoutString(timeout)),
      _contentTypeGrpc,
      _teTrailers,
      userAgent == null
          ? _defaultUserAgentHeader
          : Header.ascii('user-agent', userAgent),
      if (grpcAcceptEncodings != null)
        Header.ascii('grpc-accept-encoding', grpcAcceptEncodings),
      if (compressionCodec != null) _encodingHeader(compressionCodec),
    ];
    metadata?.forEach((key, value) {
      headers.add(Header(ascii.encode(key), utf8.encode(value)));
    });
    return headers;
  }
}

class SocketTransportConnector implements ClientTransportConnector {
  /// Either [InternetAddress] or [String].
  final Object _host;
  final int _port;
  final ChannelOptions _options;
  late Socket socket;
  Completer<void>? _doneCompleter;

  Proxy? get proxy => _options.proxy;
  Object get host => proxy == null ? _host : proxy!.host;
  int get port => proxy == null ? _port : proxy!.port;

  SocketTransportConnector(this._host, this._port, this._options)
    : assert(_host is InternetAddress || _host is String);

  @override
  Future<ClientTransportConnection> connect() async {
    final doneCompleter = Completer<void>();
    _doneCompleter = doneCompleter;
    void completeDone([Object? _, StackTrace? _]) {
      if (!doneCompleter.isCompleted) {
        doneCompleter.complete();
      }
    }

    final securityContext = _options.credentials.securityContext;
    var incoming = await connectImpl(proxy);

    // Don't wait for io buffers to fill up before sending requests.
    if (socket.address.type != InternetAddressType.unix) {
      socket.setOption(SocketOption.tcpNoDelay, true);
    }
    if (securityContext != null) {
      // Todo(sigurdm): We want to pass supportedProtocols: ['h2'].
      // http://dartbug.com/37950
      socket = await SecureSocket.secure(
        socket,
        // This is not really the host, but the authority to verify the TLC
        // connection against.
        //
        // We don't use `this.authority` here, as that includes the port.
        host: _options.credentials.authority ?? host,
        context: securityContext,
        onBadCertificate: _validateBadCertificate,
      );
      incoming = socket;
    }
    socket.done.then(completeDone, onError: completeDone);
    return ClientTransportConnection.viaStreams(
      _DisconnectAwareStream(incoming, completeDone),
      socket,
    );
  }

  Future<Stream<List<int>>> connectImpl(Proxy? proxy) async {
    socket = await initSocket(host, port);
    if (proxy == null) {
      return socket;
    }
    return await connectToProxy(proxy);
  }

  Future<Socket> initSocket(Object host, int port) async {
    return await Socket.connect(host, port, timeout: _options.connectTimeout);
  }

  void _sendConnect(Map<String, String> headers) {
    const linebreak = '\r\n';
    socket.write('CONNECT $_host:$_port HTTP/1.1');
    socket.write(linebreak);
    headers.forEach((key, value) {
      socket.write('$key: $value');
      socket.write(linebreak);
    });
    socket.write(linebreak);
  }

  @override
  String get authority {
    return _options.credentials.authority ?? _makeAuthority();
  }

  String _makeAuthority() {
    final host = _host;
    final portSuffix = _port == 443 ? '' : ':$_port';
    final String hostName;
    if (host is String) {
      hostName = host;
    } else {
      host as InternetAddress;
      if (host.type == InternetAddressType.unix) {
        return 'localhost'; // UDS don't have a meaningful authority.
      }
      hostName = host.host;
    }
    return '$hostName$portSuffix';
  }

  @override
  Future get done {
    ArgumentError.checkNotNull(socket);
    return _doneCompleter?.future ?? socket.done;
  }

  @override
  void shutdown() {
    ArgumentError.checkNotNull(socket);
    socket.destroy();
    final doneCompleter = _doneCompleter;
    if (doneCompleter != null && !doneCompleter.isCompleted) {
      doneCompleter.complete();
    }
  }

  bool _validateBadCertificate(X509Certificate certificate) {
    final credentials = _options.credentials;
    final validator = credentials.onBadCertificate;

    if (validator == null) return false;
    return validator(certificate, authority);
  }

  Future<Stream<List<int>>> connectToProxy(Proxy proxy) async {
    final headers = {'Host': '$_host:$_port'};
    if (proxy.isAuthenticated) {
      // If the proxy configuration contains user information use that
      // for proxy basic authorization.
      final authStr = '${proxy.username}:${proxy.password}';
      final auth = base64Encode(utf8.encode(authStr));
      headers[HttpHeaders.proxyAuthorizationHeader] = 'Basic $auth';
    }
    final completer = Completer<void>();

    /// Routes the events through after connection to the proxy has been
    /// established.
    final intermediate = StreamController<List<int>>();

    /// Route events after the successfull connect to the `intermediate`.
    socket.listen(
      (event) {
        if (completer.isCompleted) {
          intermediate.sink.add(event);
        } else {
          _waitForResponse(event, completer);
        }
      },
      onDone: intermediate.close,
      onError: intermediate.addError,
    );

    _sendConnect(headers);
    await completer.future;
    return intermediate.stream;
  }

  /// Wait for the response to the `CONNECT` request, which should be an
  /// acknowledgement with a 200 status code.
  void _waitForResponse(Uint8List chunk, Completer<void> completer) {
    final response = ascii.decode(chunk);
    print(response);
    if (response.startsWith('HTTP/1.1 200')) {
      completer.complete();
    } else {
      throw TransportException(
        'Error establishing proxy connection: $response',
      );
    }
  }
}

class _ShutdownException implements Exception {}

enum _InitialSettingsOutcome {
  received,
  closed,
  shutdown;

  static _InitialSettingsOutcome onReceived([Object? _]) => received;
  static _InitialSettingsOutcome onClosed([Object? _, StackTrace? _]) => closed;
  static _InitialSettingsOutcome onShutdown([Object? _]) => shutdown;
}

class _DisconnectAwareStream extends Stream<List<int>> {
  final Stream<List<int>> _source;
  final void Function() _onDisconnected;

  _DisconnectAwareStream(this._source, this._onDisconnected);

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _source.listen(
      onData,
      onError: onError == null
          ? (Object error, StackTrace stackTrace) {
              _onDisconnected();
              Zone.current.handleUncaughtError(error, stackTrace);
            }
          : (Object error, StackTrace stackTrace) {
              _onDisconnected();
              if (onError is void Function(Object, StackTrace)) {
                onError(error, stackTrace);
              } else {
                (onError as void Function(Object))(error);
              }
            },
      onDone: () {
        _onDisconnected();
        onDone?.call();
      },
      cancelOnError: cancelOnError,
    );
  }
}
