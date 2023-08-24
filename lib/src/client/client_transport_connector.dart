// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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

import 'package:http2/transport.dart';

/// A transport-specific configuration used by gRPC clients to connect.
abstract class ClientTransportConnector {
  /// Creates a HTTP/2 client connection.
  Future<ClientTransportConnection> connect();

  /// A future that completes when the client closes or when an error occurs.
  Future get done;

  /// Shuts down the connection, which should at least close the client.
  void shutdown();

  /// Header populated from any credentials or hostname information.
  String get authority;
}
