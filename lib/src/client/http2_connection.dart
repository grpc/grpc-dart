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

import 'package:http2/transport.dart';
import 'package:meta/meta.dart';

import '../shared/timeout.dart';

import 'call.dart';
import 'connection.dart' hide ClientConnection;
import 'connection.dart' as connection;

import 'options.dart';
import 'transport/http2_credentials.dart';
import 'transport/http2_transport.dart';
import 'transport/transport.dart';

class Http2ClientConnection implements connection.ClientConnection {
  static final _methodPost = Header.ascii(':method', 'POST');
  static final _schemeHttp = Header.ascii(':scheme', 'http');
  static final _schemeHttps = Header.ascii(':scheme', 'https');
  static final _contentTypeGrpc =
      Header.ascii('content-type', 'application/grpc');
  static final _teTrailers = Header.ascii('te', 'trailers');
  static final _grpcAcceptEncoding =
      Header.ascii('grpc-accept-encoding', 'identity');

  final ChannelOptions options;

  connection.ConnectionState _state = ConnectionState.idle;

  @visibleForTesting
  void Function(Http2ClientConnection connection) onStateChanged;
  final _pendingCalls = <ClientCall>[];

  ClientTransportConnection _transportConnection;

  /// Used for idle and reconnect timeout, depending on [_state].
  Timer _timer;
  Duration _currentReconnectDelay;

  final String host;
  final int port;

  Http2ClientConnection(this.host, this.port, this.options);

  ChannelCredentials get credentials => options.credentials;

  String get authority =>
      options.credentials.authority ?? (port == 443 ? host : "$host:$port");

  String get scheme => options.credentials.isSecure ? 'https' : 'http';

  ConnectionState get state => _state;

  Future<ClientTransportConnection> connectTransport() async {
    var socket = await Socket.connect(host, port);
    if (_state == ConnectionState.shutdown) {
      socket.destroy();
      // TODO(sigurdm): Throw something nicer...
      throw 'Shutting down';
    }
    final securityContext = credentials.securityContext;
    if (securityContext != null) {
      socket = await SecureSocket.secure(socket,
          host: authority,
          context: securityContext,
          onBadCertificate: _validateBadCertificate);
      if (_state == ConnectionState.shutdown) {
        socket.destroy();
        // TODO(sigurdm): Throw something nicer...
        throw 'Shutting down';
      }
    }
    socket.done.then((_) => _handleSocketClosed());
    return ClientTransportConnection.viaSocket(socket);
  }

  void _connect() {
    if (_state != ConnectionState.idle &&
        _state != ConnectionState.transientFailure) {
      return;
    }
    _setState(ConnectionState.connecting);
    connectTransport().then((transport) {
      _currentReconnectDelay = null;
      _transportConnection = transport;
      transport.onActiveStateChanged = _handleActiveStateChanged;
      _setState(ConnectionState.ready);
      _pendingCalls.forEach(_startCall);
      _pendingCalls.clear();
    }).catchError(_handleConnectionFailure);
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

  GrpcTransportStream makeRequest(String path, Duration timeout,
      Map<String, String> metadata, ErrorHandler onRequestFailure) {
    final headers = createCallHeaders(
        credentials.isSecure, authority, path, timeout, metadata,
        userAgent: options.userAgent);
    final stream = _transportConnection.makeRequest(headers);
    return Http2TransportStream(stream, onRequestFailure);
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

  Future<void> shutdown() async {
    if (_state == ConnectionState.shutdown) return null;
    _setShutdownState();
    await _transportConnection?.finish();
  }

  Future<void> terminate() async {
    _setShutdownState();
    await _transportConnection?.terminate();
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
    _transportConnection
        ?.finish()
        ?.catchError((_) => {}); // TODO(jakobr): Log error.
    _transportConnection = null;
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
        _timer ??= Timer(options.idleTimeout, _handleIdleTimeout);
      }
    }
  }

  bool _hasPendingCalls() {
    // Get rid of pending calls that have timed out.
    _pendingCalls.removeWhere((call) => call.isCancelled);
    return _pendingCalls.isNotEmpty;
  }

  void _handleConnectionFailure(error) {
    _transportConnection = null;
    if (_state == ConnectionState.shutdown || _state == ConnectionState.idle) {
      return;
    }
    // TODO(jakobr): Log error.
    _cancelTimer();
    _pendingCalls.forEach((call) => _failCall(call, error));
    _pendingCalls.clear();
    _setState(ConnectionState.idle);
  }

  void _handleReconnect() {
    if (_timer == null || _state != ConnectionState.transientFailure) return;
    _cancelTimer();
    _connect();
  }

  void _handleSocketClosed() {
    _cancelTimer();
    _transportConnection = null;

    if (_state == ConnectionState.idle && _state == ConnectionState.shutdown) {
      // All good.
      return;
    }

    // We were not planning to close the socket.
    if (!_hasPendingCalls()) {
      // No pending calls. Just hop to idle, and wait for a new RPC.
      _setState(ConnectionState.idle);
      return;
    }

    // We have pending RPCs. Reconnect after backoff delay.
    _setState(ConnectionState.transientFailure);
    _currentReconnectDelay = options.backoffStrategy(_currentReconnectDelay);
    _timer = Timer(_currentReconnectDelay, _handleReconnect);
  }

  static List<Header> createCallHeaders(bool useTls, String authority,
      String path, Duration timeout, Map<String, String> metadata,
      {String userAgent}) {
    final headers = [
      _methodPost,
      useTls ? _schemeHttps : _schemeHttp,
      Header(ascii.encode(':path'), utf8.encode(path)),
      Header(ascii.encode(':authority'), utf8.encode(authority)),
    ];
    if (timeout != null) {
      headers.add(Header.ascii('grpc-timeout', toTimeoutString(timeout)));
    }
    headers.addAll([
      _contentTypeGrpc,
      _teTrailers,
      _grpcAcceptEncoding,
      Header.ascii('user-agent', userAgent ?? defaultUserAgent),
    ]);
    metadata?.forEach((key, value) {
      headers.add(Header(ascii.encode(key), utf8.encode(value)));
    });
    return headers;
  }

  bool _validateBadCertificate(X509Certificate certificate) {
    final credentials = this.credentials;
    final validator = credentials.onBadCertificate;

    if (validator == null) return false;
    return validator(certificate, authority);
  }
}
