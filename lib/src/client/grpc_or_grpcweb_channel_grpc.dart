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

import 'http2_channel.dart';
import 'options.dart';
import 'transport/http2_credentials.dart';

class GrpcOrGrpcWebClientChannelInternal extends ClientChannel {
  GrpcOrGrpcWebClientChannelInternal({
    required String grpcHost,
    required int grpcPort,
    required bool grpcTransportSecure,
    required String grpcWebHost,
    required int grpcWebPort,
    required bool grpcWebTransportSecure,
  }) : super(
          grpcHost,
          port: grpcPort,
          options: ChannelOptions(
            credentials: grpcTransportSecure
                ? ChannelCredentials.secure()
                : ChannelCredentials.insecure(),
          ),
        );

  GrpcOrGrpcWebClientChannelInternal.grpc(
    super.host, {
    required super.port,
    required super.options,
  });
}
