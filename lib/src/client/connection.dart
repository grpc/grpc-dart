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

import 'package:meta/meta.dart';

import '../shared/status.dart';
import 'call.dart';
import 'options.dart';
import 'transport/http2_transport.dart';
import 'transport/transport.dart';
import 'transport/xhr_transport_stub.dart'
    if (dart.library.html) 'transport/xhr_transport.dart';

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
  final String host;
  final int port;
  final ChannelOptions options;

  ConnectionState _state = ConnectionState.idle;
  void Function(ClientConnection connection) onStateChanged;
  final _pendingCalls = <ClientCall>[];

  Transport _transport;

  /// Used for idle and reconnect timeout, depending on [_state].
  Timer _timer;
  Duration _currentReconnectDelay;

  ClientConnection(this.host, this.port, this.options);

  ConnectionState get state => _state;

  String get authority => options.credentials.authority ?? host;

  @visibleForTesting
  Future<Transport> connectTransport() async {
    Transport transport;
    switch (options.transportType) {
      case TransportType.Http2:
        transport = Http2Transport(host, port, options);
        break;
      case TransportType.Xhr:
        transport = XhrTransport(host, port, options);
        break;
      case TransportType.Websocket:
        throw GrpcError.unimplemented(
            "Websocket support for grpc-web is not currently supported");
    }

    await transport.connect();
    return transport;
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
      _transport.onSocketClosed = _handleSocketClosed;
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

  GrpcTransportStream makeRequest(
      String path, Duration timeout, Map<String, String> metadata) {
    return _transport.makeRequest(path, timeout, metadata);
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

  /// Shuts down this connection.
  ///
  /// No further calls may be made on this connection, but existing calls
  /// are allowed to finish.
  Future<Null> shutdown() async {
    if (_state == ConnectionState.shutdown) return null;
    _setShutdownState();
    await _transport?.finish();
  }

  /// Terminates this connection.
  ///
  /// All open calls are terminated immediately, and no further calls may be
  /// made on this connection.
  Future<Null> terminate() async {
    _setShutdownState();
    await _transport?.terminate();
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

  void _handleConnectionFailure(error) {
    _transport = null;
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
    _transport = null;

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
    _timer = new Timer(_currentReconnectDelay, _handleReconnect);
  }
}
