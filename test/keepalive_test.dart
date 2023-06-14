import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/shared/keepalive.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  test('Server terminates connection after too many pings without data',
      () async {
    final serverOptions = KeepAliveOptions.server(
      http2MaxPingStrikes: 5,
      http2MinRecvPingIntervalWithoutDataMs: 50,
    );
    final clientOptions = KeepAliveOptions.client(keepaliveTimeMs: 50);
    final server = Server.create(
      services: [FakeEchoService()],
      keepAliveOptions: serverOptions,
    );
    await server.serve(address: 'localhost', port: 8081);
    final channel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        keepAlive: clientOptions,
      ),
    );
    final client = EchoServiceClient(channel);
    await expectLater(client.echo(EchoRequest()), throwsA(isA<GrpcError>()));
    await server.shutdown();
  });

  test('Server doesnt terminate connection after pings, as data is sent',
      () async {
    final serverOptions = KeepAliveOptions.server(
      http2MaxPingStrikes: 5,
      http2MinRecvPingIntervalWithoutDataMs: 50,
    );
    final clientOptions = KeepAliveOptions.client(keepaliveTimeMs: 20);
    final server = Server.create(
      services: [FakeEchoService()],
      keepAliveOptions: serverOptions,
    );
    await server.serve(address: 'localhost', port: 8081);
    final channel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        keepAlive: clientOptions,
      ),
    );
    final client = EchoServiceClient(channel);
    final timer = Timer.periodic(
        Duration(milliseconds: 1000), (timer) => client.echo(EchoRequest()));
    await Future.delayed(Duration(milliseconds: 10000), () => timer.cancel());
    await server.shutdown();
  });
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    print('Echo');
    return EchoResponse(message: 'Echo messsage');
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) {
    // TODO: implement serverStreamingEcho
    throw UnimplementedError();
  }
}
