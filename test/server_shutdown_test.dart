// Copyright (c) 2026, the gRPC project authors. Please see the AUTHORS file
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
@Timeout(Duration(seconds: 10))
library;

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

/// Answers each call once the test lets it.
class EchoService extends EchoServiceBase {
  final echoCalled = Completer<void>();
  final echoAnswer = Completer<EchoResponse>();

  final streamCalled = Completer<void>();
  late Stream<ServerStreamingEchoResponse> responses;

  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) {
    echoCalled.complete();
    return echoAnswer.future;
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
    ServiceCall call,
    ServerStreamingEchoRequest request,
  ) {
    streamCalled.complete();
    return responses;
  }
}

void main() {
  late EchoService service;
  late Server server;
  late ClientChannel channel;

  setUp(() async {
    service = EchoService();
    server = Server.create(services: [service]);
    await server.serve(address: 'localhost', port: 0);
    channel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  });

  tearDown(() async {
    // ends the connection also when a test failed with a call still running
    await channel.terminate();
    await server.shutdown();
  });

  // The client may not get the answer: package:http2's finish() closes the
  // socket without writing the frames it still queues. These tests check the
  // server's side, so they only wait for the call to end.
  Future<void> ended(Future<Object?> call) =>
      call.then((_) {}, onError: (_) {});

  test('a unary call that answers while the server shuts down ends, and the '
      'shutdown completes', () async {
    final call = ended(
      EchoServiceClient(channel).echo(EchoRequest(message: 'hello')),
    );
    await service.echoCalled.future;

    final shutdown = server.shutdown();
    service.echoAnswer.complete(EchoResponse(message: 'hello'));

    await shutdown;
    await call;
  });

  test('a server stream that ends as the server starts to shut down ends, '
      'and the shutdown completes', () async {
    final sent = StreamController<ServerStreamingEchoResponse>();
    service.responses = sent.stream;
    final call = ended(
      EchoServiceClient(
        channel,
      ).serverStreamingEcho(ServerStreamingEchoRequest()).toList(),
    );
    await service.streamCalled.future;
    sent.add(ServerStreamingEchoResponse(message: 'one'));

    // the end reaches the call's handler only after the shutdown began
    unawaited(sent.close());
    await server.shutdown();
    await call;
  });

  test('a call whose connection breaks is cancelled', () async {
    final cancelled = Completer<void>();
    final sent = StreamController<ServerStreamingEchoResponse>(
      onCancel: cancelled.complete,
    );
    service.responses = sent.stream;
    final call = ended(
      EchoServiceClient(
        channel,
      ).serverStreamingEcho(ServerStreamingEchoRequest()).toList(),
    );
    await service.streamCalled.future;

    await channel.terminate();

    await cancelled.future;
    await call;
    await sent.close();
  });
}
