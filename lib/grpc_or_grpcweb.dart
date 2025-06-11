// Copyright (c) 2021, the gRPC project authors. Please see the AUTHORS file
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

import 'src/client/grpc_or_grpcweb_channel_grpc.dart'
    if (dart.library.js_interop) 'src/client/grpc_or_grpcweb_channel_web.dart';
import 'src/client/http2_channel.dart';
import 'src/client/options.dart';

export 'src/shared/api.dart';

/// A client channel that underneath uses gRPC [ClientChannel] on all platforms
/// except web, on which it uses [GrpcWebClientChannel].
///
/// Note that gRPC and gRPC-web are 2 different protocols and server must be
/// able to speak both of them for this to work.
/// Depending on its exact setup, the server may expose gRPC and gRPC-web on the
/// same port (this is the standard setup of AspNetCore implementation for
/// example), on separate ports of the same host (common setup of in-process
/// gRPC-web to gRPC proxies or colocated Envoy gRPC-web to gRPC proxy), or as
/// a completely separate endpoints (for example if Envoy and gRPC server are
/// exposed as different kubernetes services). A corresponding constructor is
/// provided for each case.
class GrpcOrGrpcWebClientChannel extends GrpcOrGrpcWebClientChannelInternal {
  GrpcOrGrpcWebClientChannel.toSeparateEndpoints({
    required super.grpcHost,
    required super.grpcPort,
    required super.grpcTransportSecure,
    required super.grpcWebHost,
    required super.grpcWebPort,
    required super.grpcWebTransportSecure,
  });

  GrpcOrGrpcWebClientChannel.toSeparatePorts({
    required String host,
    required super.grpcPort,
    required super.grpcTransportSecure,
    required super.grpcWebPort,
    required super.grpcWebTransportSecure,
  }) : super(grpcHost: host, grpcWebHost: host);

  GrpcOrGrpcWebClientChannel.toSingleEndpoint({
    required String host,
    required int port,
    required bool transportSecure,
  }) : super(
         grpcHost: host,
         grpcPort: port,
         grpcTransportSecure: transportSecure,
         grpcWebHost: host,
         grpcWebPort: port,
         grpcWebTransportSecure: transportSecure,
       );

  GrpcOrGrpcWebClientChannel.grpc(
    super.host, {
    super.port = 443,
    super.options = const ChannelOptions(),
  }) : super.grpc();
}
