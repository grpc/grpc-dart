@TestOn('vm')
import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/client_keepalive.dart';
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  late Server server;
  late EchoServiceClient fakeClient;
  late FakeClientChannel fakeChannel;
  late EchoServiceClient unresponsiveClient;

  final pingInterval = Duration(milliseconds: 10);
  final timeout = Duration(milliseconds: 30);
  final minIntervalBetweenPings = Duration(milliseconds: 10);
  final maxBadPings = 5;

  setUp(() async {
    final serverOptions = ServerKeepAliveOptions(
      maxBadPings: maxBadPings,
      minIntervalBetweenPingsWithoutData: minIntervalBetweenPings,
    );
    final clientOptions = ClientKeepAliveOptions(
      pingInterval: pingInterval,
      timeout: timeout,
      permitWithoutCalls: true,
    );

    final channelOptions = ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      keepAlive: clientOptions,
    );
    server = Server.create(
      services: [FakeEchoService()],
      keepAliveOptions: serverOptions,
    );
    await server.serve(address: 'localhost', port: 8081);
    fakeChannel = FakeClientChannel(
      'localhost',
      port: server.port!,
      options: channelOptions,
    );
    fakeClient = EchoServiceClient(fakeChannel);

    unresponsiveClient = EchoServiceClient(UnresponsiveClientChannel(
      'localhost',
      port: server.port!,
      options: channelOptions,
    ));
  });

  tearDown(() async {
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  final fakeAsync = FakeAsync();

  test('Server terminates connection after too many pings without data',
      () async {
    await fakeAsync.run((async) async {
      await fakeClient.echo(EchoRequest());
      async.elapse(pingInterval * maxBadPings);
      await fakeClient.echo(EchoRequest());
      // Check that the server closed the connection, the next request then has
      // to build a new one.
      expect(fakeChannel.newConnectionCounter, 2);
    });
  });

  test(
      'Server doesnt terminate connection after pings, as data is sent',
      () async => fakeAsync
        ..run((async) async {
          // Send data often enough
          var counter = 0;
          Timer.periodic(
            minIntervalBetweenPings ~/ 2,
            (timer) {
              fakeClient.echo(EchoRequest());
              if (counter++ > 3) timer.cancel();
            },
          );
          async.flushTimers();

          // Wait for last request to be sent
          async.elapse(Duration(milliseconds: 20));

          // Check that the server never closed the connection
          expect(fakeChannel.newConnectionCounter, 1);
        }));

  test(
      'Server doesnt ack the ping, making the client shutdown the connection',
      () async => fakeAsync.run((async) {
            unresponsiveClient.echo(EchoRequest());
            async.flushMicrotasks();
            async.elapseBlocking(timeout * 10);
            expectLater(
              unresponsiveClient.echo(EchoRequest()),
              throwsA(isA<GrpcError>()),
            );
            async.flushMicrotasks();
          }));
}

/// A wrapper around a [FakeHttp2ClientConnection]
class FakeClientChannel extends ClientChannel {
  FakeHttp2ClientConnection? fakeHttp2ClientConnection;
  FakeClientChannel(
    super.host, {
    super.port = 443,
    super.options = const ChannelOptions(),
    super.channelShutdownHandler,
  });

  @override
  ClientConnection createConnection() {
    fakeHttp2ClientConnection = FakeHttp2ClientConnection(host, port, options);
    return fakeHttp2ClientConnection!;
  }

  int get newConnectionCounter =>
      fakeHttp2ClientConnection?.newConnectionCounter ?? 0;
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

/// A wrapper around a [FakeHttp2ClientConnection]
class UnresponsiveClientChannel extends ClientChannel {
  UnresponsiveClientChannel(
    super.host, {
    super.port = 443,
    super.options = const ChannelOptions(),
    super.channelShutdownHandler,
  });

  @override
  ClientConnection createConnection() =>
      UnresponsiveHttp2ClientConnection(host, port, options);
}

class UnresponsiveHttp2ClientConnection extends Http2ClientConnection {
  UnresponsiveHttp2ClientConnection(super.host, super.port, super.options);

  @override
  set keepAliveManager(ClientKeepAlive? value) {
    if (value != null) {
      super.keepAliveManager = FakeClientKeepAlive(
        options: super.options.keepAlive,
        ping: value.ping,
        onPingTimeout: value.onPingTimeout,
      );
    }
  }
}

class FakeClientKeepAlive extends ClientKeepAlive {
  FakeClientKeepAlive(
      {required super.options,
      required super.ping,
      required super.onPingTimeout});

  @override
  void onFrameReceived() {
    // Do nothing here, to simulate a server not responding to pings.
  }
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async =>
      EchoResponse(message: 'Echo messsage');

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
          ServiceCall call, ServerStreamingEchoRequest request) =>
      throw UnsupportedError('Not needed for testing');
}
