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
import 'dart:typed_data';

import 'package:grpc/grpc.dart' as grpc;
import 'package:test/test.dart';

class TestClient extends grpc.Client {
  static final _$unary = grpc.ClientMethod<int, int>(
    '/test.TestService/unary',
    (int value) => [value],
    (List<int> value) => value[0],
  );

  TestClient(super.channel);

  grpc.ResponseFuture<int> unary(int request) =>
      $createUnaryCall(_$unary, request);
}

/// `SO_LINGER {on, 0}`: closing the socket sends RST instead of FIN.
RawSocketOption _lingerZero() {
  if (Platform.isWindows) {
    // struct linger { u_short l_onoff; u_short l_linger; }, SO_LINGER 0x0080.
    return RawSocketOption(
      RawSocketOption.levelSocket,
      0x0080,
      Uint8List.fromList([1, 0, 0, 0]),
    );
  }
  // struct linger { int l_onoff; int l_linger; }; SO_LINGER is 13 on Linux,
  // 0x0080 on BSD/macOS.
  return RawSocketOption(
    RawSocketOption.levelSocket,
    Platform.isLinux ? 13 : 0x0080,
    Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0]),
  );
}

/// A plaintext server that, on every connection, waits for the client's first
/// HEADERS frame (the call has started on a ready connection) and then resets
/// the TCP connection.
class ResettingServer {
  ResettingServer._(this._server);

  final ServerSocket _server;
  int connections = 0;

  int get port => _server.port;

  static Future<ResettingServer> start() async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    final resetting = ResettingServer._(server);
    server.listen(resetting._accept);
    return resetting;
  }

  void _accept(Socket socket) {
    connections++;
    final buffer = <int>[];
    var reset = false;
    socket.listen((data) {
      if (reset) return;
      buffer.addAll(data);
      // Client preface (24 bytes), then frames: 3-byte length, 1-byte type,
      // 1-byte flags, 4-byte stream id.
      var i = 24;
      while (buffer.length >= i + 9) {
        final length = (buffer[i] << 16) | (buffer[i + 1] << 8) | buffer[i + 2];
        if (buffer[i + 3] == 0x1) {
          reset = true;
          socket.setRawOption(_lingerZero());
          socket.destroy();
          return;
        }
        i += 9 + length;
      }
    }, onError: (_) {});
  }

  Future<void> close() => _server.close();
}

void main() {
  late ResettingServer server;

  setUp(() async => server = await ResettingServer.start());
  tearDown(() => server.close());

  test('a connection reset by the server after a call has started is '
      'abandoned: the next call reconnects and shutdown() completes', () async {
    for (var i = 0; i < 5; i++) {
      final channel = grpc.ClientChannel(
        '127.0.0.1',
        port: server.port,
        options: const grpc.ChannelOptions(
          credentials: grpc.ChannelCredentials.insecure(),
        ),
      );
      final connectionsBefore = server.connections;
      try {
        for (var call = 0; call < 2; call++) {
          await expectLater(
            TestClient(channel).unary(1),
            throwsA(isA<grpc.GrpcError>()),
            reason: 'attempt $i, call $call',
          );
        }
        expect(
          server.connections - connectionsBefore,
          greaterThanOrEqualTo(2),
          reason: 'the second call must open a new connection',
        );
      } finally {
        var completed = true;
        await channel.shutdown().timeout(
          const Duration(seconds: 5),
          onTimeout: () => completed = false,
        );
        if (!completed) await channel.terminate();
        expect(
          completed,
          isTrue,
          reason: 'attempt $i: shutdown() did not complete within 5 s',
        );
      }
    }
  });
}
