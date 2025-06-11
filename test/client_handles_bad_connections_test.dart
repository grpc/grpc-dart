// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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

@TestOn('vm')
library;

import 'dart:async';

import 'package:grpc/grpc.dart' as grpc;
import 'package:grpc/src/client/channel.dart';
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/http2.dart';
import 'package:test/test.dart';

import 'common.dart';

class TestClient extends grpc.Client {
  static final _$stream = grpc.ClientMethod<int, int>(
    '/test.TestService/stream',
    (int value) => [value],
    (List<int> value) => value[0],
  );

  TestClient(super.channel);

  grpc.ResponseStream<int> stream(int request, {grpc.CallOptions? options}) {
    return $createStreamingCall(
      _$stream,
      Stream.value(request),
      options: options,
    );
  }
}

class TestService extends grpc.Service {
  @override
  String get $name => 'test.TestService';

  TestService() {
    $addMethod(
      grpc.ServiceMethod<int, int>(
        'stream',
        stream,
        false,
        true,
        (List<int> value) => value[0],
        (int value) => [value],
      ),
    );
  }

  Stream<int> stream(grpc.ServiceCall call, Future request) async* {
    yield 1;
    yield 2;
    yield 3;
  }
}

class FixedConnectionClientChannel extends ClientChannelBase {
  final Http2ClientConnection clientConnection;
  List<grpc.ConnectionState> states = <grpc.ConnectionState>[];

  FixedConnectionClientChannel(this.clientConnection) {
    onConnectionStateChanged.listen((state) {
      states.add(state);
    });
  }

  @override
  ClientConnection createConnection() => clientConnection;
}

Future<void> main() async {
  testTcpAndUds('client reconnects after the connection gets old', (
    address,
  ) async {
    // client reconnect after a short delay.
    final server = grpc.Server.create(services: [TestService()]);
    await server.serve(address: address, port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        grpc.ChannelOptions(
          idleTimeout: Duration(minutes: 1),
          // Short delay to test that it will time out.
          connectionTimeout: Duration(milliseconds: 100),
          credentials: grpc.ChannelCredentials.insecure(),
        ),
      ),
    );

    final testClient = TestClient(channel);
    expect(await testClient.stream(1).toList(), [1, 2, 3]);
    await Future.delayed(Duration(milliseconds: 200));
    expect(await testClient.stream(1).toList(), [1, 2, 3]);
    expect(
      channel.states.where((x) => x == grpc.ConnectionState.ready).length,
      2,
    );
    server.shutdown();
  });

  testTcpAndUds('client reconnects when stream limit is used', (address) async {
    // client reconnect after setting stream limit.
    final server = grpc.Server.create(services: [TestService()]);
    await server.serve(
      address: address,
      port: 0,
      http2ServerSettings: ServerSettings(concurrentStreamLimit: 2),
    );

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
      ),
    );
    final states = <grpc.ConnectionState>[];
    channel.onConnectionStateChanged.listen((state) {
      states.add(state);
    });
    final testClient = TestClient(channel);

    await Future.wait(<Future>[
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
    ]);
    expect(states.where((x) => x == grpc.ConnectionState.ready).length, 2);
    server.shutdown();
  });
}
