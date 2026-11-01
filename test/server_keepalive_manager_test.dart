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

import 'dart:async';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/server/server_keepalive.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

class _PingEchoService extends Service {
  @override
  String get $name => 'test.PingService';

  _PingEchoService() {
    $addMethod(
      ServiceMethod<int, int>(
        'Echo',
        (ServiceCall call, Future<int> request) async => await request,
        false,
        false,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
  }
}

void main() {
  late StreamController pingStream;
  late StreamController dataStream;
  late int maxBadPings;

  var goAway = false;

  void initServer([ServerKeepAliveOptions? options]) => ServerKeepAlive(
    options:
        options ??
        ServerKeepAliveOptions(
          maxBadPings: maxBadPings,
          minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
        ),
    pingNotifier: pingStream.stream,
    dataNotifier: dataStream.stream,
    tooManyBadPings: () async => goAway = true,
  ).handle();

  setUp(() {
    pingStream = StreamController();
    dataStream = StreamController();
    maxBadPings = 10;
    goAway = false;
  });

  tearDown(() {
    pingStream.close();
    dataStream.close();
  });

  final timeAfterPing = Duration(milliseconds: 10);

  test('Sending too many pings without data kills connection', () async {
    FakeAsync().run((async) {
      initServer();
      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });
  test(
    'Sending too many pings without data doesn`t kill connection if the server doesn`t care',
    () async {
      FakeAsync().run((async) {
        initServer(
          ServerKeepAliveOptions(
            maxBadPings: null,
            minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
          ),
        );
        // Send good ping
        pingStream.sink.add(null);
        async.elapse(timeAfterPing);

        // Send a lot of bad pings, that's still ok.
        for (var i = 0; i < 50; i++) {
          pingStream.sink.add(null);
        }
        async.elapse(timeAfterPing);
        expect(goAway, false);
      });
    },
  );

  test('Sending many pings with data doesn`t kill connection', () async {
    FakeAsync().run((async) {
      initServer();

      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Sending data resets the bad ping count
      dataStream.add(null);
      async.elapse(timeAfterPing);

      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });

  test(
    'ConnectionServer resets ping strikes synchronously when HEADERS and PING arrive in one chunk',
    () async {
      final c2sRaw = StreamController<List<int>>();
      final c2sForwarded = StreamController<List<int>>();
      final s2c = StreamController<List<int>>();

      var buffering = false;
      final bufferedBytes = BytesBuilder(copy: false);
      final sub = c2sRaw.stream.listen(
        (chunk) {
          if (buffering) {
            bufferedBytes.add(chunk);
          } else {
            c2sForwarded.add(chunk);
          }
        },
        onDone: c2sForwarded.close,
        onError: c2sForwarded.addError,
      );

      final clientConn = ClientTransportConnection.viaStreams(
        s2c.stream,
        c2sRaw.sink,
      );
      final serverConn = ServerTransportConnection.viaStreams(
        c2sForwarded.stream,
        s2c.sink,
      );

      final server = ConnectionServer(
        [_PingEchoService()],
        const [],
        const [],
        null,
        null,
        const ServerKeepAliveOptions(
          maxBadPings: 1,
          minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
        ),
      );
      await server.serveConnection(connection: serverConn);
      await clientConn.onInitialPeerSettingsReceived;

      // Good ping 1, then bad ping 1 (_badPings == 1 == maxBadPings).
      await clientConn.ping();
      await Future<void>.delayed(const Duration(milliseconds: 12));
      await clientConn.ping();
      await Future<void>.delayed(const Duration(milliseconds: 12));

      // Coalesce a new RPC (HEADERS + DATA) followed immediately by a PING
      // into a single socket chunk delivered to the server.
      buffering = true;
      final stream = clientConn.makeRequest(
        Http2ClientConnection.createCallHeaders(
          false,
          'localhost',
          '/test.PingService/Echo',
          null,
          null,
          null,
        ),
      );
      stream.outgoingMessages.add(
        DataStreamMessage(Uint8List.fromList([0, 0, 0, 0, 1, 77])),
      );
      final closeFuture = stream.outgoingMessages.close();
      final pingFuture = clientConn.ping();

      await Future<void>.delayed(Duration.zero);
      buffering = false;
      c2sForwarded.add(bufferedBytes.takeBytes());

      await closeFuture;
      await pingFuture;
      final responseMessages = await stream.incomingMessages.toList();
      final dataFrames = responseMessages.whereType<DataStreamMessage>();
      expect(dataFrames, isNotEmpty);
      expect(clientConn.isOpen, isTrue);

      // Completed handler is removed from ConnectionServer.handlers[serverConn].
      await Future<void>.delayed(Duration.zero);
      expect(server.handlers[serverConn], isEmpty);

      await clientConn.finish();
      await serverConn.finish();
      await sub.cancel();
      await c2sRaw.close();
      await s2c.close();
    },
  );
}
