// Copyright (c) 2026, the gRPC project authors. Please see the AUTHORS file
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
import 'dart:io';

import 'package:fake_async/fake_async.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/channel.dart' show ClientChannelBase;
import 'package:grpc/src/client/connection.dart' show ClientConnection;
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/client_utils.mocks.dart';

class _EchoClient extends Client {
  static final _$echo = ClientMethod<int, int>(
    '/test.EchoService/Echo',
    (int value) => [value],
    (List<int> value) => value[0],
  );

  _EchoClient(super.channel);

  ResponseFuture<int> echo(int value, {CallOptions? options}) =>
      $createUnaryCall(_$echo, value, options: options);
}

class _EchoService extends Service {
  @override
  String get $name => 'test.EchoService';

  _EchoService() {
    $addMethod(
      ServiceMethod<int, int>(
        'Echo',
        (ServiceCall call, Future<int> request) async => await request,
        false,
        false,
        (List<int> value) => value[0],
        (int value) => [value],
      ),
    );
  }
}

class _FixedConnectionChannel extends ClientChannelBase {
  final Http2ClientConnection clientConnection;

  _FixedConnectionChannel(this.clientConnection);

  @override
  ClientConnection createConnection() => clientConnection;
}

class _DelayedSettingsConnector extends ClientTransportConnector {
  final ClientTransportConnection _connection;
  final doneCompleter = Completer<void>();
  bool isShutdown = false;

  _DelayedSettingsConnector(this._connection);

  @override
  Future<ClientTransportConnection> connect() async => _connection;

  @override
  String get authority => 'localhost';

  @override
  Future<void> get done => doneCompleter.future;

  @override
  void shutdown() {
    isShutdown = true;
    if (!doneCompleter.isCompleted) {
      doneCompleter.complete();
    }
  }
}

void main() {
  test(
    'becomes ready as soon as initial peer SETTINGS arrive without 20ms sleep',
    () {
      fakeAsync((async) {
        final transport = MockClientTransportConnection();
        final settingsCompleter = Completer<void>();
        when(
          transport.onInitialPeerSettingsReceived,
        ).thenAnswer((_) => settingsCompleter.future);
        when(transport.onActiveStateChanged = any).thenReturn(null);
        when(transport.isOpen).thenReturn(true);

        final connector = _DelayedSettingsConnector(transport);
        final connection = Http2ClientConnection.fromClientTransportConnector(
          connector,
          const ChannelOptions(credentials: ChannelCredentials.insecure()),
        );
        final channel = _FixedConnectionChannel(connection);
        final states = <ConnectionState>[];
        channel.onConnectionStateChanged.listen(states.add);

        // Trigger connection establishment via a pending call, then cancel the
        // call once ready so we isolate the connection handshake timing.
        final stream = MockClientTransportStream();
        final outgoing = StreamController<StreamMessage>();
        final incoming = StreamController<StreamMessage>();
        when(
          transport.makeRequest(any, endStream: anyNamed('endStream')),
        ).thenReturn(stream);
        when(stream.outgoingMessages).thenReturn(outgoing.sink);
        when(stream.incomingMessages).thenAnswer((_) => incoming.stream);
        when(stream.terminate()).thenReturn(null);

        final call = _EchoClient(channel).echo(42);

        async.flushMicrotasks();
        expect(connection.state, ConnectionState.connecting);

        // Peer SETTINGS arrive after 2ms (well below the legacy 20ms sleep).
        async.elapse(const Duration(milliseconds: 2));
        settingsCompleter.complete();
        async.flushMicrotasks();

        expect(connection.state, ConnectionState.ready);
        expect(states, [ConnectionState.connecting, ConnectionState.ready]);

        call.cancel().ignore();
        outgoing.close();
        incoming.close();
      });
    },
  );

  test(
    'waits for delayed initial SETTINGS (> 20ms) before opening streams',
    () async {
      final server = ConnectionServer([_EchoService()]);
      final serverSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(serverSocket.close);

      var acceptedConnections = 0;
      final openSockets = <Socket>[];
      addTearDown(() async {
        for (final s in openSockets) {
          s.destroy();
        }
      });

      serverSocket.listen((socket) async {
        openSockets.add(socket);
        final connectionIndex = ++acceptedConnections;
        if (connectionIndex == 1) {
          // Delay sending the server HTTP/2 SETTINGS preface beyond 20ms.
          await Future<void>.delayed(const Duration(milliseconds: 60));
        }
        final transport = ServerTransportConnection.viaSocket(
          socket,
          settings: const ServerSettings(concurrentStreamLimit: 2),
        );
        await server.serveConnection(connection: transport);
      });

      final channel = ClientChannel(
        InternetAddress.loopbackIPv4,
        port: serverSocket.port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      addTearDown(channel.terminate);

      final client = _EchoClient(channel);
      final results = await Future.wait([
        client.echo(1),
        client.echo(2),
        client.echo(3),
        client.echo(4),
      ]);

      expect(results, [1, 2, 3, 4]);
      // Because concurrentStreamLimit is 2, waiting for SETTINGS before
      // dispatching ensures only 2 streams open on connection 1 and the
      // remaining calls reconnect onto connection 2.
      expect(acceptedConnections, 2);
    },
  );

  test(
    'fails immediately without becoming ready if peer closes before SETTINGS',
    () async {
      final serverSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(serverSocket.close);

      serverSocket.listen((socket) {
        socket.destroy();
      });

      final connection = Http2ClientConnection(
        InternetAddress.loopbackIPv4,
        serverSocket.port,
        const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final channel = _FixedConnectionChannel(connection);
      addTearDown(channel.terminate);
      final states = <ConnectionState>[];
      channel.onConnectionStateChanged.listen(states.add);

      final client = _EchoClient(channel);
      await expectLater(
        client.echo(1).timeout(const Duration(seconds: 2)),
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );
      expect(states, isNot(contains(ConnectionState.ready)));
    },
  );

  test(
    'fails immediately if peer sends HTTP/1.1 response instead of SETTINGS',
    () async {
      final serverSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(serverSocket.close);

      final peerSockets = <Socket>[];
      addTearDown(() async {
        for (final s in peerSockets) {
          s.destroy();
        }
      });

      serverSocket.listen((socket) {
        peerSockets.add(socket);
        socket.write('HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n\r\n');
      });

      final connection = Http2ClientConnection(
        InternetAddress.loopbackIPv4,
        serverSocket.port,
        const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final channel = _FixedConnectionChannel(connection);
      addTearDown(channel.terminate);
      final states = <ConnectionState>[];
      channel.onConnectionStateChanged.listen(states.add);

      final client = _EchoClient(channel);
      await expectLater(
        client.echo(1).timeout(const Duration(seconds: 2)),
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );
      expect(states, isNot(contains(ConnectionState.ready)));
    },
  );

  test(
    'honors connectTimeout and shutdown when peer never sends SETTINGS',
    () async {
      final serverSocket = await ServerSocket.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(serverSocket.close);

      final peerSockets = <Socket>[];
      addTearDown(() async {
        for (final s in peerSockets) {
          s.destroy();
        }
      });

      final accepted = Completer<void>();
      serverSocket.listen((socket) {
        peerSockets.add(socket);
        if (!accepted.isCompleted) {
          accepted.complete();
        }
      });

      // 1. connectTimeout aborts waiting for SETTINGS.
      final timeoutChannel = ClientChannel(
        InternetAddress.loopbackIPv4,
        port: serverSocket.port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectTimeout: Duration(milliseconds: 50),
        ),
      );
      addTearDown(timeoutChannel.terminate);

      await expectLater(
        _EchoClient(
          timeoutChannel,
        ).echo(1).timeout(const Duration(milliseconds: 500)),
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );

      // 2. Without connectTimeout, channel.shutdown() aborts waiting cleanly.
      final shutdownChannel = ClientChannel(
        InternetAddress.loopbackIPv4,
        port: serverSocket.port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final pendingRpc = _EchoClient(shutdownChannel).echo(1);
      final rpcExpectation = expectLater(
        pendingRpc,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );
      await accepted.future;
      await shutdownChannel.shutdown().timeout(const Duration(seconds: 2));
      await rpcExpectation;
    },
  );

  test(
    'handles connector.done completing with an error before and after SETTINGS',
    () async {
      // 1. Error on connector.done before SETTINGS arrives.
      final transport1 = MockClientTransportConnection();
      when(
        transport1.onInitialPeerSettingsReceived,
      ).thenAnswer((_) => Completer<void>().future);
      final connector1 = _DelayedSettingsConnector(transport1);
      final connection1 = Http2ClientConnection.fromClientTransportConnector(
        connector1,
        const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final future1 = connection1.connectTransport();
      connector1.doneCompleter.completeError(StateError('socket error'));
      await expectLater(
        future1,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );

      // 2. Error on connector.done after connection becomes ready abandons cleanly.
      final transport2 = MockClientTransportConnection();
      when(
        transport2.onInitialPeerSettingsReceived,
      ).thenAnswer((_) => Future<void>.value());
      when(transport2.onActiveStateChanged = any).thenReturn(null);
      when(transport2.isOpen).thenReturn(true);
      final connector2 = _DelayedSettingsConnector(transport2);
      final connection2 = Http2ClientConnection.fromClientTransportConnector(
        connector2,
        const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final channel2 = _FixedConnectionChannel(connection2);
      final stream = MockClientTransportStream();
      final outgoing = StreamController<StreamMessage>()..stream.listen((_) {});
      final incoming = StreamController<StreamMessage>();
      when(
        transport2.makeRequest(any, endStream: anyNamed('endStream')),
      ).thenReturn(stream);
      when(stream.outgoingMessages).thenReturn(outgoing.sink);
      when(stream.incomingMessages).thenAnswer((_) => incoming.stream);
      when(stream.terminate()).thenReturn(null);

      final call = _EchoClient(channel2).echo(1)..ignore();
      await Future<void>.delayed(Duration.zero);
      expect(connection2.state, ConnectionState.ready);

      connector2.doneCompleter.completeError(StateError('dropped'));
      await Future<void>.delayed(Duration.zero);
      expect(connection2.state, ConnectionState.idle);

      await call.cancel();
      await outgoing.close();
      await incoming.close();
    },
  );
}
