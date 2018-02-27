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

import '../shared/status.dart';

import 'call.dart';
import 'connection.dart';
import 'method.dart';
import 'options.dart';

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
      {this.port = 443, this.options = const ChannelOptions()});

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
      if (call.isCancelled) return;
      connection.dispatchCall(call);
    }, onError: call.onConnectionError);
    return call;
  }
}
