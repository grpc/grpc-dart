@TestOn('vm')
import 'dart:async';
import 'dart:io';

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
    await server.serve(
      address: 'localhost',
      port: 8888,
      security: ServerTlsCredentials(
        certificate: File('test/data/localhost.crt').readAsBytesSync(),
        privateKey: File('test/data/localhost.key').readAsBytesSync(),
      ),
    );
    // ignore: prefer_final_locals
    var proxy = Proxy.direct();

    /// Run this test iff you have proxy running on the port 8080.
    proxy = Proxy(host: 'localhost', port: 8080);
    final proxyCAName = '/CN=mitmproxy/O=mitmproxy';

    fakeChannel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.secure(
          certificates: File('test/data/localhost.crt').readAsBytesSync(),
          authority: 'localhost',
          onBadCertificate: (certificate, host) {
            /// Workaround to avoid having to add the proxy to our list of
            /// trusted CAs.
            return certificate.issuer == proxyCAName;
          },
        ),
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
    'Sending and receiving over secure proxy works',
    () async {
      final echoRequest = EchoRequest(message: 'blablablubb');
      final echoResponse = await fakeClient.echo(echoRequest);
      expect(echoResponse.message, 'blibliblabb');
    },
    skip: 'Run this test iff you have proxy running.',
  );
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    expect(request.message, 'blablablubb');
    return EchoResponse(message: 'blibliblabb');
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
          ServiceCall call, ServerStreamingEchoRequest request) =>
      throw UnimplementedError();
}
