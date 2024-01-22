@TestOn('vm')
import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  late Server server;
  late EchoServiceClient fakeClient;
  late ClientChannel fakeChannel;

  setUp(() async {
    server = Server.create(
      services: [EchoService()],
      codecRegistry: CodecRegistry(
        codecs: const [GzipCodec(), IdentityCodec()],
      ),
    );
    await server.serve(address: 'localhost', port: 8081);
    final options = ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry: CodecRegistry(
        codecs: const [GzipCodec(), IdentityCodec()],
      ),
    );
    fakeChannel = ClientChannel(
      'localhost',
      port: server.port!,
      options: options,
    );
    fakeClient = EchoServiceClient(fakeChannel);
  });

  tearDown(() async {
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  test('Ping twice', () async {
    final callOptions = CallOptions(
      timeout: Duration(microseconds: 50),
    );
    for (var i = 0; i < 100; i++) {
      expectLater(
        () => fakeClient.echo(
          EchoRequest(message: 'some message'),
          options: callOptions,
        ),
        throwsA(isA<GrpcError>()),
      );
    }
  });
}

class EchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    await Future.delayed(Duration(milliseconds: 1));
    return EchoResponse(
        message: String.fromCharCodes(request.message.codeUnits.reversed));
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) {
    throw UnimplementedError();
  }
}
