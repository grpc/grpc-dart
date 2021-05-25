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

class GrpcOrGrpcWebClientChannel extends ClientChannel {
  GrpcOrGrpcWebClientChannel({
    required String host,
    required int grpcPort,
    required int grpcWebPort,
    required bool secure,
  }) : super(
          host,
          port: grpcPort,
          options: ChannelOptions(
            credentials: secure
                ? ChannelCredentials.secure()
                : ChannelCredentials.insecure(),
          ),
        ) {
    if (grpcWebPort == grpcPort) {
      throw ArgumentError('grpcPort and grpcWebPort cannot be the same');
    }
  }

  GrpcOrGrpcWebClientChannel.grpc(
    Object host, {
    int port = 443,
    ChannelOptions options = const ChannelOptions(),
  }) : super(host, port: port, options: options);
}
