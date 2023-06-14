import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/keepalive.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  late EchoServiceClient client;
  late Server server;
  late FakeClientChannel channel;

  setUp(() async {
    final serverOptions = KeepAliveOptions.server(
      http2MaxPingStrikes: 5,
      http2MinRecvPingIntervalWithoutDataMs: 10,
    );
    final clientOptions = KeepAliveOptions.client(
      keepaliveTimeMs: 10,
      keepalivePermitWithoutCalls: true,
    );

    server = Server.create(
      services: [FakeEchoService()],
      keepAliveOptions: serverOptions,
    );
    await server.serve(address: 'localhost', port: 8081);
    channel = FakeClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        keepAlive: clientOptions,
      ),
    );
    client = EchoServiceClient(channel);
  });

  tearDown(() async {
    await channel.terminate();
    await server.shutdown();
  });

  test('Server terminates connection after too many pings without data',
      () async {
    await client.echo(EchoRequest());
    await Future.delayed(Duration(milliseconds: 200));
    await client.echo(EchoRequest());
    // Check that the server closed the connection, the next request then has
    // to build a new one.
    expect(channel.newConnectionCounter, 2);
  });

  test('Server doesnt terminate connection after pings, as data is sent',
      () async {
    final timer = Timer.periodic(
        Duration(milliseconds: 40), (timer) => client.echo(EchoRequest()));
    await Future.delayed(Duration(milliseconds: 200), () => timer.cancel());
    // Check that the server never closed the connection
    expect(channel.newConnectionCounter, 1);
  });
}

/// A wrapper around a [FakeHttp2ClientConnection]
class FakeClientChannel extends ClientChannel {
  late FakeHttp2ClientConnection fakeHttp2ClientConnection;
  FakeClientChannel(
    super.host, {
    super.port = 443,
    super.options = const ChannelOptions(),
    super.channelShutdownHandler,
  });

  @override
  ClientConnection createConnection() {
    fakeHttp2ClientConnection = FakeHttp2ClientConnection(host, port, options);
    return fakeHttp2ClientConnection;
  }

  int get newConnectionCounter =>
      fakeHttp2ClientConnection.newConnectionCounter;
}

/// A [Http2ClientConnection] exposing a counter for new connections
class FakeHttp2ClientConnection extends Http2ClientConnection {
  int newConnectionCounter = 0;

  FakeHttp2ClientConnection(super.host, super.port, super.options);

  @override
  Future<ClientTransportConnection> connectTransport() {
    newConnectionCounter++;
    return super.connectTransport();
  }
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async =>
      EchoResponse(message: 'Echo messsage');

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) {
    // TODO: implement serverStreamingEcho
    throw UnimplementedError();
  }
}
