@TestOn('vm')
import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/proxy.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  late Server server;
  late EchoServiceClient fakeClient;
  late ClientChannel fakeChannel;

  setUp(() async {
    server = Server.create(services: [FakeEchoService()]);
    await server.serve(address: 'localhost', port: 8888);

    final proxy = Proxy(host: 'localhost', port: 8080);

    fakeChannel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        proxy: proxy,
      ),
    );
    fakeClient = EchoServiceClient(fakeChannel);
  });

  tearDown(() async {
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  test(
    'Sending and receiving over proxy works',
    () async {
      final echoRequest = EchoRequest(message: 'blablablubb');
      final echoResponse = await fakeClient.echo(echoRequest);
      expect(echoResponse.message, 'blibliblabb');
    },
    skip: 'Run this test iff you have a proxy running.',
  );
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async =>
      EchoResponse(message: 'blibliblabb');

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
          ServiceCall call, ServerStreamingEchoRequest request) =>
      throw UnimplementedError();
}
