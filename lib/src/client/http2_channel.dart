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

import 'dart:io';
import 'dart:vmservice_io';

import '../../grpc_connection_interface.dart' show ClientCall;
import '../../service_api.dart' show ClientMethod;
import 'call.dart';
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
  ClientCall<Q, R> createCall<Q, R>(ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    var newPath = method.path;
    if (host is String){
      var uri = Uri.parse(host as String);
      newPath = joinPathComponents(uri.path, method.path);
    } else if (host is InternetAddress){
      newPath = joinPathComponents((host as InternetAddress).address, newPath);
    }

    ClientMethod(newPath, method.requestSerializer, method.responseDeserializer);
    return super.createCall(method, requests, options);
  }

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
