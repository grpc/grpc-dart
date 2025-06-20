// Copyright (c) 2019, the gRPC project authors. Please see the AUTHORS file
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

import 'channel.dart';
import 'client_transport_connector.dart';
import 'connection.dart';
import 'http2_connection.dart' show Http2ClientConnection;
import 'options.dart';

/// A channel to a virtual gRPC endpoint.
///
/// For each RPC, the channel picks a [Http2ClientConnection] to dispatch the call.
/// RPCs on the same channel may be sent to different connections, depending on
/// load balancing settings.
class ClientChannel extends ClientChannelBase {
  /// Starts the [Server] with the given options.
  /// [address] can be either a [String] or an [InternetAddress], in the latter
  /// case it can be a Unix Domain Socket address.
  final Object host;
  final int port;
  final ChannelOptions options;

  ClientChannel(
    this.host, {
    this.port = 443,
    this.options = const ChannelOptions(),
    super.channelShutdownHandler,
  });

  @override
  ClientConnection createConnection() =>
      Http2ClientConnection(host, port, options);
}

class ClientTransportConnectorChannel extends ClientChannelBase {
  final ClientTransportConnector transportConnector;
  final ChannelOptions options;

  ClientTransportConnectorChannel(
    this.transportConnector, {
    this.options = const ChannelOptions(),
  });

  @override
  ClientConnection createConnection() =>
      Http2ClientConnection.fromClientTransportConnector(
        transportConnector,
        options,
      );
}
