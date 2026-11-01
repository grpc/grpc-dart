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

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/client/transport/http2_transport.dart';
import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/client_utils.mocks.dart';
import 'src/server_utils.dart';

class _BytesClient extends Client {
  static final _$echo = ClientMethod<Uint8List, Uint8List>(
    '/test.BytesService/Echo',
    (Uint8List value) => value,
    (List<int> value) => value is Uint8List ? value : Uint8List.fromList(value),
  );

  static final _$bidi = ClientMethod<Uint8List, Uint8List>(
    '/test.BytesService/Bidi',
    (Uint8List value) => value,
    (List<int> value) => value is Uint8List ? value : Uint8List.fromList(value),
  );

  _BytesClient(super.channel);

  ResponseFuture<Uint8List> echo(Uint8List value, {CallOptions? options}) =>
      $createUnaryCall(_$echo, value, options: options);

  ResponseStream<Uint8List> bidi(
    Stream<Uint8List> values, {
    CallOptions? options,
  }) => $createStreamingCall(_$bidi, values, options: options);
}

class _BytesService extends Service {
  @override
  String get $name => 'test.BytesService';

  final Uint8List? fixedResponse;

  _BytesService({this.fixedResponse}) {
    $addMethod(
      ServiceMethod<Uint8List, Uint8List>(
        'Echo',
        (ServiceCall call, Future<Uint8List> request) async {
          final req = await request;
          return fixedResponse ?? req;
        },
        false,
        false,
        (List<int> value) =>
            value is Uint8List ? value : Uint8List.fromList(value),
        (Uint8List value) => value,
      ),
    );
    $addMethod(
      ServiceMethod<Uint8List, Uint8List>(
        'Bidi',
        (ServiceCall call, Stream<Uint8List> requests) async* {
          await for (final req in requests) {
            yield fixedResponse ?? req;
          }
        },
        true,
        true,
        (List<int> value) =>
            value is Uint8List ? value : Uint8List.fromList(value),
        (Uint8List value) => value,
      ),
    );
  }
}

Uint8List _patternedBytes(int length) {
  final bytes = Uint8List(length);
  for (var i = 0; i < length; i++) {
    bytes[i] = (i * 31 + 7) & 0xFF;
  }
  return bytes;
}

/// Parses HTTP/2 wire bytes and returns the payload lengths of non-empty
/// `DATA` frames (type `0x00`) on [streamId].
List<int> _parseHttp2DataFrameLengths(
  List<int> wireBytes, {
  required int streamId,
  bool skipConnectionPreface = false,
}) {
  // Client HTTP/2 connection preface is 24 bytes: "PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n".
  var offset = skipConnectionPreface ? 24 : 0;
  final lengths = <int>[];
  while (offset + 9 <= wireBytes.length) {
    final length =
        (wireBytes[offset] << 16) |
        (wireBytes[offset + 1] << 8) |
        wireBytes[offset + 2];
    final type = wireBytes[offset + 3];
    final frameStreamId =
        ((wireBytes[offset + 5] & 0x7F) << 24) |
        (wireBytes[offset + 6] << 16) |
        (wireBytes[offset + 7] << 8) |
        wireBytes[offset + 8];
    offset += 9 + length;
    if (type == 0x00 && frameStreamId == streamId && length > 0) {
      lengths.add(length);
    }
  }
  return lengths;
}

void main() {
  test(
    'frames large uncompressed Uint8List payloads without intermediate copy on HTTP/2 streams',
    () async {
      final clientToServer = StreamController<List<int>>();
      final serverToClient = StreamController<List<int>>();

      final clientWire = BytesBuilder(copy: false);
      final serverWire = BytesBuilder(copy: false);

      final c2sForwarded = StreamController<List<int>>();
      final s2cForwarded = StreamController<List<int>>();

      final sub1 = clientToServer.stream.listen(
        (chunk) {
          clientWire.add(chunk);
          c2sForwarded.add(chunk);
        },
        onDone: c2sForwarded.close,
        onError: c2sForwarded.addError,
      );
      final sub2 = serverToClient.stream.listen(
        (chunk) {
          serverWire.add(chunk);
          s2cForwarded.add(chunk);
        },
        onDone: s2cForwarded.close,
        onError: s2cForwarded.addError,
      );

      final clientConn = ClientTransportConnection.viaStreams(
        s2cForwarded.stream,
        clientToServer.sink,
      );
      final serverConn = ServerTransportConnection.viaStreams(
        c2sForwarded.stream,
        serverToClient.sink,
      );

      final responsePayload = _patternedBytes(32 * 1024);
      final server = ConnectionServer([
        _BytesService(fixedResponse: responsePayload),
      ]);
      await server.serveConnection(connection: serverConn);

      await clientConn.onInitialPeerSettingsReceived;

      // Stream 1: small payload (16379 bytes) fits in one 16384-byte DATA frame.
      final smallRequest = _patternedBytes(16379);
      final stream1 = Http2TransportStream(
        clientConn.makeRequest(
          Http2ClientConnection.createCallHeaders(
            false,
            'localhost',
            '/test.BytesService/Echo',
            null,
            null,
            null,
          ),
        ),
        (error, _) => fail('Unexpected stream1 error: $error'),
        CodecRegistry.empty(),
        null,
      );
      stream1.outgoingMessages.add(smallRequest);
      await stream1.outgoingMessages.close();
      await stream1.incomingMessages.drain<void>();

      // Stream 3: 32 KiB payload (> 16379 bytes) is emitted as a 5-byte gRPC
      // header DATA frame + two aligned 16384-byte DATA frames (no 32773-byte copy).
      final largeRequest = _patternedBytes(32 * 1024);
      final stream3 = Http2TransportStream(
        clientConn.makeRequest(
          Http2ClientConnection.createCallHeaders(
            false,
            'localhost',
            '/test.BytesService/Echo',
            null,
            null,
            null,
          ),
        ),
        (error, _) => fail('Unexpected stream3 error: $error'),
        CodecRegistry.empty(),
        null,
      );
      stream3.outgoingMessages.add(largeRequest);
      await stream3.outgoingMessages.close();
      final stream3Messages = await stream3.incomingMessages.toList();
      final decodedResponse = stream3Messages.whereType<GrpcData>().single.data;
      expect(decodedResponse, responsePayload);

      await clientConn.finish();
      await serverConn.finish();
      await sub1.cancel();
      await sub2.cancel();
      await clientToServer.close();
      await serverToClient.close();
      await c2sForwarded.close();
      await s2cForwarded.close();

      final clientBytes = clientWire.takeBytes();
      final serverBytes = serverWire.takeBytes();

      expect(
        _parseHttp2DataFrameLengths(
          clientBytes,
          streamId: 1,
          skipConnectionPreface: true,
        ),
        [16384],
      );
      expect(
        _parseHttp2DataFrameLengths(
          clientBytes,
          streamId: 3,
          skipConnectionPreface: true,
        ),
        [5, 16384, 16384],
      );
      expect(_parseHttp2DataFrameLengths(serverBytes, streamId: 3), [
        5,
        16384,
        16384,
      ]);
    },
  );

  test(
    'emits 5-byte header DataStreamMessage followed by identical payload Uint8List without copying',
    () async {
      final mockStream = MockClientTransportStream();
      final outgoing = StreamController<StreamMessage>();
      final incoming = StreamController<StreamMessage>();
      when(mockStream.outgoingMessages).thenReturn(outgoing.sink);
      when(mockStream.incomingMessages).thenAnswer((_) => incoming.stream);
      when(mockStream.terminate()).thenReturn(null);

      final sent = <StreamMessage>[];
      final sub = outgoing.stream.listen(sent.add);

      final transportStream = Http2TransportStream(
        mockStream,
        (error, _) => fail('Unexpected error: $error'),
        CodecRegistry.empty(),
        null,
      );
      final largePayload = _patternedBytes(32 * 1024);
      transportStream.outgoingMessages.add(largePayload);
      await transportStream.outgoingMessages.close();
      await outgoing.done;

      expect(sent, hasLength(2));
      expect((sent[0] as DataStreamMessage).bytes, [0, 0, 0, 128, 0]);
      expect(
        identical((sent[1] as DataStreamMessage).bytes, largePayload),
        isTrue,
      );

      await sub.cancel();
      await transportStream.terminate();
      unawaited(incoming.close());
      await outgoing.close();

      // ServerHandler also emits header + identical payload Uint8List without copying.
      final toServer = StreamController<StreamMessage>();
      final fromServer = StreamController<StreamMessage>();
      final server = ConnectionServer([
        _BytesService(fixedResponse: largePayload),
      ]);
      final serverMessages = <StreamMessage>[];
      final done = Completer<void>();
      fromServer.stream.listen(serverMessages.add, onDone: done.complete);

      server.serveStream_(
        stream: TestServerStream(toServer.stream, fromServer.sink),
      );
      toServer.add(
        HeadersStreamMessage(
          Http2ClientConnection.createCallHeaders(
            false,
            'localhost',
            '/test.BytesService/Echo',
            null,
            null,
            null,
          ),
        ),
      );
      toServer.add(DataStreamMessage(Uint8List.fromList([0, 0, 0, 0, 1, 42])));
      await toServer.close();
      await done.future;
      await fromServer.close();

      final dataMessages = serverMessages
          .whereType<DataStreamMessage>()
          .toList();
      expect(dataMessages, hasLength(2));
      expect(dataMessages[0].bytes, [0, 0, 0, 128, 0]);
      expect(identical(dataMessages[1].bytes, largePayload), isTrue);
    },
  );

  test(
    'round-trips 64 KiB and 1 MiB uncompressed and gzip payloads across HTTP/2 flow-control windows',
    () async {
      final codecs = CodecRegistry(
        codecs: const [GzipCodec(), IdentityCodec()],
      );
      final server = Server.create(
        services: [_BytesService()],
        codecRegistry: codecs,
      );
      await server.serve(address: InternetAddress.loopbackIPv4, port: 0);
      addTearDown(server.shutdown);

      final channel = ClientChannel(
        InternetAddress.loopbackIPv4,
        port: server.port!,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry: codecs,
        ),
      );
      addTearDown(channel.terminate);

      final client = _BytesClient(channel);

      // 64 KiB and 1 MiB exceed the default 65,535-byte HTTP/2 initial window.
      final payload64K = _patternedBytes(64 * 1024);
      final payload1M = _patternedBytes(1024 * 1024);

      expect(await client.echo(payload64K), payload64K);
      expect(await client.echo(payload1M), payload1M);

      // Explicit IdentityCodec exercises the identity zero-copy branch too.
      expect(
        await client.echo(
          payload1M,
          options: CallOptions(compression: const IdentityCodec()),
        ),
        payload1M,
      );

      // Gzip-compressed 1 MiB round-trip.
      expect(
        await client.echo(
          payload1M,
          options: CallOptions(compression: const GzipCodec()),
        ),
        payload1M,
      );

      // Bidirectional streaming with multiple 256 KiB messages.
      final chunkA = _patternedBytes(256 * 1024);
      final chunkB = _patternedBytes(256 * 1024 + 17);
      final streamed = await client
          .bidi(Stream.fromIterable([chunkA, chunkB]))
          .toList();
      expect(streamed, hasLength(2));
      expect(streamed[0], chunkA);
      expect(streamed[1], chunkB);
    },
  );
}
