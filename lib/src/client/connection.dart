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
import 'dart:io';

import 'package:http2/transport.dart';
import 'package:meta/meta.dart';

import '../shared/status.dart';
import '../shared/timeout.dart';

import 'call.dart';
import 'options.dart';

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
    if (call.isCancelled) return;
    call.onConnectionReady(this);
  }

  void _shutdownCall(ClientCall call) {
    if (call.isCancelled) return;
    call.onConnectionError(
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
    _pendingCalls.removeWhere((call) => call.isCancelled);
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
