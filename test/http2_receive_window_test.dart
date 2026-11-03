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
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

const _settingsFrameType = 0x4;
const _windowUpdateFrameType = 0x8;
const _settingsMaxConcurrentStreams = 0x3;
const _settingsInitialWindowSize = 0x4;
const _defaultWindowSize = 65535;
const _clientPreface = 'PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n';

class _Frame {
  final int type;
  final int streamId;
  final Uint8List payload;

  _Frame(this.type, this.streamId, this.payload);

  /// The (identifier, value) pairs of a SETTINGS frame.
  Map<int, int> get settings {
    final data = ByteData.sublistView(payload);
    return {
      for (var i = 0; i + 6 <= payload.length; i += 6)
        data.getUint16(i): data.getUint32(i + 2),
    };
  }

  int get windowSizeIncrement =>
      ByteData.sublistView(payload).getUint32(0) & 0x7fffffff;
}

/// Reads the first [count] HTTP/2 frames from [bytes], after skipping
/// [skip] leading bytes (e.g. the client connection preface).
Future<List<_Frame>> _readFrames(
  Stream<List<int>> bytes,
  int count, {
  int skip = 0,
}) async {
  final buffer = BytesBuilder();
  final frames = <_Frame>[];
  await for (final chunk in bytes) {
    buffer.add(chunk);
    final data = buffer.toBytes();
    if (data.length < skip) continue;
    var offset = skip;
    frames.clear();
    while (frames.length < count && offset + 9 <= data.length) {
      final header = ByteData.sublistView(data, offset, offset + 9);
      final length = (header.getUint16(0) << 8) | header.getUint8(2);
      if (offset + 9 + length > data.length) break;
      frames.add(
        _Frame(
          header.getUint8(3),
          header.getUint32(5) & 0x7fffffff,
          Uint8List.sublistView(data, offset + 9, offset + 9 + length),
        ),
      );
      offset += 9 + length;
    }
    if (frames.length == count) return frames;
  }
  throw StateError('Connection closed after ${frames.length} frames');
}

class _EchoService extends Service {
  @override
  String get $name => 'test.Echo';

  _EchoService() {
    $addMethod(
      ServiceMethod<List<int>, List<int>>(
        'Echo',
        (ServiceCall call, Future<List<int>> request) => request,
        false,
        false,
        (List<int> value) => value,
        (List<int> value) => value,
      ),
    );
  }
}

void main() {
  test('client connections request larger receive windows', () async {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    addTearDown(server.close);
    final accepted = server.first;

    final channel = ClientChannel(
      InternetAddress.loopbackIPv4,
      port: server.port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectTimeout: Duration(seconds: 5),
      ),
    );
    addTearDown(channel.terminate);
    final call = channel.createCall(
      ClientMethod<List<int>, List<int>>(
        '/test.Echo/Echo',
        (value) => value,
        (value) => value,
      ),
      Stream.value(const [1]),
      CallOptions(),
    );
    call.response.listen((_) {}, onError: (_) {});

    final socket = await accepted;
    addTearDown(socket.destroy);
    final frames = await _readFrames(
      socket,
      2,
      skip: ascii.encode(_clientPreface).length,
    );

    expect(frames[0].type, _settingsFrameType);
    expect(frames[0].settings[_settingsInitialWindowSize], 256 * 1024);
    expect(frames[1].type, _windowUpdateFrameType);
    expect(frames[1].streamId, 0);
    expect(frames[1].windowSizeIncrement, 1024 * 1024 - _defaultWindowSize);
  });

  group('server connections', () {
    Future<List<_Frame>> serverFrames({ServerSettings? settings}) async {
      final server = Server.create(services: [_EchoService()]);
      await server.serve(
        address: InternetAddress.loopbackIPv4,
        port: 0,
        http2ServerSettings: settings,
      );
      addTearDown(server.shutdown);
      final socket = await Socket.connect(
        InternetAddress.loopbackIPv4,
        server.port!,
      );
      addTearDown(socket.destroy);
      // Client preface followed by an empty SETTINGS frame.
      socket
        ..add(ascii.encode(_clientPreface))
        ..add([0, 0, 0, _settingsFrameType, 0, 0, 0, 0, 0]);
      return _readFrames(socket, settings == null ? 2 : 1);
    }

    test('grant larger receive windows by default', () async {
      final frames = await serverFrames();
      expect(frames[0].type, _settingsFrameType);
      expect(frames[0].settings[_settingsInitialWindowSize], 256 * 1024);
      expect(frames[1].type, _windowUpdateFrameType);
      expect(frames[1].streamId, 0);
      expect(frames[1].windowSizeIncrement, 1024 * 1024 - _defaultWindowSize);
    });

    test('use http2ServerSettings as given', () async {
      final frames = await serverFrames(
        settings: const ServerSettings(concurrentStreamLimit: 7),
      );
      expect(frames[0].type, _settingsFrameType);
      expect(frames[0].settings[_settingsMaxConcurrentStreams], 7);
      expect(frames[0].settings, isNot(contains(_settingsInitialWindowSize)));
    });
  });
}
