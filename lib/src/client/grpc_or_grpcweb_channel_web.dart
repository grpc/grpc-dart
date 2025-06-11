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

import 'options.dart';
import 'web_channel.dart';

class GrpcOrGrpcWebClientChannelInternal extends GrpcWebClientChannel {
  GrpcOrGrpcWebClientChannelInternal({
    required String grpcHost,
    required int grpcPort,
    required bool grpcTransportSecure,
    required String grpcWebHost,
    required int grpcWebPort,
    required bool grpcWebTransportSecure,
  }) : super.xhr(
         Uri(
           host: grpcWebHost,
           port: grpcWebPort,
           scheme: grpcWebTransportSecure ? 'https' : 'http',
         ),
       );

  GrpcOrGrpcWebClientChannelInternal.grpc(
    Object host, {
    required int port,
    required ChannelOptions options,
  }) : super.xhr(
         Uri(
           host: host.toString(),
           port: port,
           scheme: options.credentials.isSecure ? 'https' : 'http',
         ),
       ) {
    // Do not silently ignore options as caller may expect them to have effects.
    throw UnsupportedError('not supported by gRPC-web');
  }
}
