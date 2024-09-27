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
@TestOn('browser')
library;

import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:grpc/grpc_web.dart';
import 'package:test/test.dart';

const host = 'example.com';
const port = 0;

void main() {
  test('Channel on web uses GrpcWebClientChannel with correct URI', () {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: host,
      port: port,
      transportSecure: true,
    );
    expect(channel is GrpcWebClientChannel, isTrue);
    final webChannel = channel as GrpcWebClientChannel;
    expect(
        webChannel.uri, equals(Uri(host: host, port: port, scheme: 'https')));
  });

  test('Constructor grpc on web throws UnsupportedError', () {
    expect(() => GrpcOrGrpcWebClientChannel.grpc(host, port: port),
        throwsUnsupportedError);
  });
}
