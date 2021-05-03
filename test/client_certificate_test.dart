@TestOn('vm')
import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

class EchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    final subject = call.clientCertificate?.subject;
    return (EchoResponse()..message = subject ?? 'NO CERT');
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) {
    // TODO: implement serverStreamingEcho
    throw UnimplementedError();
  }
}

const String address = 'localhost';
const int port = 19360;
Future<void> main() async {
  test('Client certificate required', () async {
    //Server
    final server = Server(
      [EchoService()],
    );
    final serverContext =
        SecurityContextChannelCredentials.baseSecurityContext();

    serverContext.useCertificateChain('test/data/localhost.crt');
    serverContext.usePrivateKey('test/data/localhost.key');
    serverContext.setTrustedCertificates('test/data/localhost.crt');
    final ServerCredentials serverCredentials =
        SecurityContextServerCredentials(serverContext);

    await server.serve(
        address: address,
        port: port,
        security: serverCredentials,
        requireClientCertificate: true);

    //Client
    final channelContext =
        SecurityContextChannelCredentials.baseSecurityContext();
    channelContext.useCertificateChain(
      'test/data/localhost.crt',
    );
    channelContext.usePrivateKey('test/data/localhost.key');
    final channelCredentials = SecurityContextChannelCredentials(channelContext,
        onBadCertificate: (cert, s) {
      return true;
    });
    final channel = ClientChannel(address,
        port: port, options: ChannelOptions(credentials: channelCredentials));
    final client = EchoServiceClient(channel);
    expect((await client.echo(EchoRequest())).message, '/CN=localhost');
    await channel.shutdown();
    await server.shutdown();
  });

  test('Client certificate not required', () async {
    //Server
    final server = Server(
      [EchoService()],
    );
    final serverContext =
        SecurityContextChannelCredentials.baseSecurityContext();

    serverContext.useCertificateChain('test/data/localhost.crt');
    serverContext.usePrivateKey('test/data/localhost.key');
    serverContext.setTrustedCertificates('test/data/localhost.crt');
    final ServerCredentials serverCredentials =
        SecurityContextServerCredentials(serverContext);
    await server.serve(
      address: address,
      port: port,
      security: serverCredentials,
    );
    // Client
    final channelContext =
        SecurityContextChannelCredentials.baseSecurityContext();
    channelContext.useCertificateChain(
      'test/data/localhost.crt',
    );
    channelContext.usePrivateKey('test/data/localhost.key');
    final channelCredentials = SecurityContextChannelCredentials(channelContext,
        onBadCertificate: (cert, s) {
      return true;
    });
    final channel = ClientChannel(address,
        port: port, options: ChannelOptions(credentials: channelCredentials));
    final client = EchoServiceClient(channel);
    expect((await client.echo(EchoRequest())).message, 'NO CERT');
    await channel.shutdown();
    await server.shutdown();
  });
}

class SecurityContextChannelCredentials extends ChannelCredentials {
  final SecurityContext _securityContext;

  SecurityContextChannelCredentials(SecurityContext securityContext,
      {String? authority, BadCertificateHandler? onBadCertificate})
      : _securityContext = securityContext,
        super.secure(authority: authority, onBadCertificate: onBadCertificate);
  @override
  SecurityContext get securityContext => _securityContext;

  static SecurityContext baseSecurityContext() {
    return createSecurityContext(false);
  }
}

class SecurityContextServerCredentials extends ServerTlsCredentials {
  final SecurityContext _securityContext;

  SecurityContextServerCredentials(SecurityContext securityContext)
      : _securityContext = securityContext,
        super();
  @override
  SecurityContext get securityContext => _securityContext;
  static SecurityContext baseSecurityContext() {
    return createSecurityContext(true);
  }
}
