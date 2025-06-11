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

import 'call.dart';

import 'transport/transport.dart';

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
  shutdown,
}

abstract class ClientConnection {
  String get authority;
  String get scheme;

  /// Put [call] on the queue to be dispatched when the connection is ready.
  void dispatchCall(ClientCall call);

  /// Start a request for [path] with [metadata].
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onRequestFailure, {
    required CallOptions callOptions,
  });

  /// Shuts down this connection.
  ///
  /// No further calls may be made on this connection, but existing calls
  /// are allowed to finish.
  Future<void> shutdown();

  /// Terminates this connection.
  ///
  /// All open calls are terminated immediately, and no further calls may be
  /// made on this connection.
  Future<void> terminate();

  /// Set state change listener for this connection. The given callback will be
  /// invoked when the state of this connection changes.
  // no need for this to be public,
  // but needed in the actual implementations
  set onStateChanged(void Function(ConnectionState) cb);
}
