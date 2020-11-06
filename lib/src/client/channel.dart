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

import '../shared/profiler.dart';
import '../shared/status.dart';

import 'call.dart';
import 'connection.dart';
import 'method.dart';

/// A channel to a virtual RPC endpoint.
abstract class ClientChannel {
  /// Shuts down this channel.
  ///
  /// No further RPCs can be made on this channel. RPCs already in progress will
  /// be allowed to complete.
  Future<void> shutdown();

  /// Terminates this channel.
  ///
  /// RPCs already in progress will be terminated. No further RPCs can be made
  /// on this channel.
  Future<void> terminate();

  /// Initiates a new RPC on this connection.
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options);
}

/// Auxiliary base class implementing much of ClientChannel.
abstract class ClientChannelBase implements ClientChannel {
  // TODO(jakobr): Multiple connections, load balancing.
  ClientConnection _connection;

  bool _isShutdown = false;

  ClientChannelBase();

  @override
  Future<void> shutdown() async {
    if (_isShutdown) return;
    _isShutdown = true;
    if (_connection != null) await _connection.shutdown();
  }

  @override
  Future<void> terminate() async {
    _isShutdown = true;
    if (_connection != null) await _connection.terminate();
  }

  ClientConnection createConnection();

  /// Returns a connection to this [Channel]'s RPC endpoint.
  ///
  /// The connection may be shared between multiple RPCs.
  Future<ClientConnection> getConnection() async {
    if (_isShutdown) throw GrpcError.unavailable('Channel shutting down.');
    return _connection ??= createConnection();
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = ClientCall(
        method,
        requests,
        options,
        isTimelineLoggingEnabled
            ? timelineTaskFactory(filterKey: clientTimelineFilterKey)
            : null);
    getConnection().then((connection) {
      if (call.isCancelled) return;
      connection.dispatchCall(call);
    }, onError: call.onConnectionError);
    return call;
  }
}
