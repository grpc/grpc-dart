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

/// Exports [GrpcOrWebClientChannel] that underneath uses gRPC [ClientChannel]
/// on all platfroms except web, on which it uses [GrpcWebClientChannel].
///
/// Note that gRPC and gRPC-web are 2 different protocols and server must be
/// able to speak both of them for this to work.
/// As several existing implementations (such as in-process gRPC-web to gRPC
/// proxies or Envoy gRPC-web to gRPC proxy) expose gRPC and gRPC-web on
/// separate ports, the constructor requires 2 ports to be provided and
/// the channel will use the one for the actual protocol being used.
/// If the server supports both protocols on the same port (such as AspNetCore
/// implementation), then the same port value should be provided on both params.

export 'src/client/grpc_or_grpcweb_channel_grpc.dart'
    if (dart.library.html) 'src/client/grpc_or_grpcweb_channel_web.dart';
