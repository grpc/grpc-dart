// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

class EchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) =>
      throw UnimplementedError();

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
    ServiceCall call,
    ServerStreamingEchoRequest request,
  ) async* {
    for (var i = 0; i < request.messageCount; i++) {
      yield ServerStreamingEchoResponse(message: '$i');
      await Future.delayed(Duration(milliseconds: request.messageInterval));
    }
  }
}

void main() {
  late Server server;
  late ClientChannel channel;

  int numberHandlers() =>
      server.handlers.entries.firstOrNull?.value.length ?? 0;

  setUp(() async {
    server = Server.create(services: [EchoService()]);
    await server.serve(address: 'localhost', port: 0);
    channel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  });

  tearDown(() async {
    await channel.shutdown();
    await server.shutdown();
  });

  test('Handlers get removed from map after stream is done.', () async {
    final request = ServerStreamingEchoRequest(
      messageCount: 5,
      messageInterval: 5,
    );
    final stream1 = EchoServiceClient(
      channel,
    ).serverStreamingEcho(request).asBroadcastStream();
    final stream2 = EchoServiceClient(
      channel,
    ).serverStreamingEcho(request).asBroadcastStream();

    expect(numberHandlers(), 0);

    await stream1.take(1).toList();
    await stream2.take(1).toList();
    expect(numberHandlers(), 2);

    await stream1.drain();
    await stream2.drain();
    expect(numberHandlers(), 0);
  });
}
