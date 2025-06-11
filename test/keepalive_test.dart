// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:async';

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
  late FakeClientChannel unresponsiveChannel;

  final pingInterval = Duration(milliseconds: 10);
  final timeout = Duration(milliseconds: 30);
  final maxBadPings = 5;

  setUp(() async {
    final serverOptions = ServerKeepAliveOptions(
      maxBadPings: maxBadPings,
      minIntervalBetweenPingsWithoutData: Duration(milliseconds: 10),
    );
    final clientOptions = ClientKeepAliveOptions(
      pingInterval: pingInterval,
      timeout: timeout,
      permitWithoutCalls: true,
    );

    server = Server.create(
      services: [FakeEchoService()],
      keepAliveOptions: serverOptions,
    );
    await server.serve(address: 'localhost', port: 0);
    fakeChannel = FakeClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        keepAlive: clientOptions,
      ),
    );
    fakeClient = EchoServiceClient(fakeChannel);

    unresponsiveChannel = UnresponsiveClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        keepAlive: clientOptions,
      ),
    );
    unresponsiveClient = EchoServiceClient(unresponsiveChannel);
  });

  tearDown(() async {
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  test(
    'Server terminates connection after too many pings without data',
    () async {
      await fakeClient.echo(EchoRequest());
      await Future.delayed(timeout * maxBadPings * 2);
      await fakeClient.echo(EchoRequest());
      // Check that the server closed the connection, the next request then has
      // to build a new one.
      expect(fakeChannel.newConnectionCounter, 2);
    },
  );

  test(
    'Server doesnt terminate connection after pings, as data is sent',
    () async {
      for (var i = 0; i < 10; i++) {
        await fakeClient.echo(EchoRequest());
        await Future.delayed(timeout * 0.2);
      }

      // Check that the server never closed the connection
      expect(fakeChannel.newConnectionCounter, 1);
    },
  );

  test(
    'Server doesnt ack the ping, making the client shutdown the transport',
    () async {
      //Send a first request, get a connection
      await unresponsiveClient.echo(EchoRequest());
      expect(unresponsiveChannel.newConnectionCounter, 1);

      //Ping is not being acked on time
      await Future.delayed(timeout * 2);

      //A second request gets a new connection
      await unresponsiveClient.echo(EchoRequest());
      expect(unresponsiveChannel.newConnectionCounter, 2);
    },
  );
}

/// A wrapper around a [FakeHttp2ClientConnection]
class FakeClientChannel extends ClientChannel {
  FakeHttp2ClientConnection? fakeHttp2ClientConnection;
  FakeClientChannel(
    super.host, {
    super.port,
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
class UnresponsiveClientChannel extends FakeClientChannel {
  UnresponsiveClientChannel(
    super.host, {
    super.port,
    super.options = const ChannelOptions(),
    super.channelShutdownHandler,
  });

  @override
  ClientConnection createConnection() {
    fakeHttp2ClientConnection = UnresponsiveHttp2ClientConnection(
      host,
      port,
      options,
    );
    return fakeHttp2ClientConnection!;
  }
}

class UnresponsiveHttp2ClientConnection extends FakeHttp2ClientConnection {
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
  FakeClientKeepAlive({
    required super.options,
    required super.ping,
    required super.onPingTimeout,
  });

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
    ServiceCall call,
    ServerStreamingEchoRequest request,
  ) => throw UnsupportedError('Not used in this test');
}
