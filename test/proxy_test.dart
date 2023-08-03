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
    await server.serve(address: 'localhost', port: 8081);
    var proxy = Proxy.direct();
    // proxy = Proxy(host: 'localhost', port: 8080);
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
    print('Start teardown');
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  test('Server terminates connection after too many pings without data',
      () async {
    final echoRequest = EchoRequest(message: 'blablablubb');
    print('Send request ${echoRequest.message}');
    final echoResponse = await fakeClient.echo(echoRequest);
    print(echoResponse.message);
  });
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    print('Got request ${request.message}');
    final echoResponse = EchoResponse(message: 'blibliblabb');
    print('Send response ${echoResponse.message}');
    return echoResponse;
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) {
    // TODO: implement serverStreamingEcho
    throw UnimplementedError();
  }
}
