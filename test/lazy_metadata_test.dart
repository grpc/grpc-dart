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
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/client_utils.mocks.dart';
import 'src/server_utils.dart';

class _CountingByteList extends ListBase<int> {
  final List<int> _inner;
  int byteReads = 0;

  _CountingByteList(String asciiText) : _inner = ascii.encode(asciiText);

  @override
  int get length => _inner.length;

  @override
  set length(int newLength) => throw UnsupportedError('unmodifiable');

  @override
  int operator [](int index) {
    byteReads++;
    return _inner[index];
  }

  @override
  void operator []=(int index, int value) =>
      throw UnsupportedError('unmodifiable');
}

class _MockConnector extends ClientTransportConnector {
  final ClientTransportConnection connection;
  final Completer<void> _done = Completer<void>();

  _MockConnector(this.connection);

  @override
  Future<ClientTransportConnection> connect() async => connection;

  @override
  String get authority => 'localhost';

  @override
  Future<void> get done => _done.future;

  @override
  void shutdown() {
    if (!_done.isCompleted) {
      _done.complete();
    }
  }
}

class _LazyMetaService extends Service {
  @override
  String get $name => 'test.LazyService';

  Map<String, String>? observedMetadata;
  DateTime? observedDeadline;

  _LazyMetaService() {
    $addMethod(
      ServiceMethod<int, int>(
        'FastEcho',
        (ServiceCall call, Future<int> request) async {
          observedDeadline = call.deadline;
          return await request;
        },
        false,
        false,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
    $addMethod(
      ServiceMethod<int, int>(
        'ReadMetadata',
        (ServiceCall call, Future<int> request) async {
          observedMetadata = call.clientMetadata;
          observedDeadline = call.deadline;
          return await request;
        },
        false,
        false,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
  }
}

void main() {
  test(
    'GrpcHttpDecoder and grpcDecompressor defer decoding unaccessed headers while validating status/content-type',
    () async {
      final customHdrValue = _CountingByteList('large-custom-header-value');
      final customTrlValue = _CountingByteList('large-custom-trailer-value');
      final codec = const GzipCodec();
      final compressedPayload = codec.compress([1, 2, 3, 4]);
      final framedCompressed = Uint8List.fromList([
        1,
        0,
        0,
        0,
        compressedPayload.length,
        ...compressedPayload,
      ]);

      final controller = StreamController<StreamMessage>();
      final decodedFuture = controller.stream
          .transform(GrpcHttpDecoder(forResponse: true))
          .transform(
            grpcDecompressor(codecRegistry: CodecRegistry(codecs: [codec])),
          )
          .toList();

      controller
        ..add(
          HeadersStreamMessage([
            Header.ascii(':status', '200'),
            Header.ascii('content-type', 'application/grpc+proto'),
            Header.ascii('grpc-encoding', 'gzip'),
            Header(ascii.encode('x-custom-hdr'), customHdrValue),
          ]),
        )
        ..add(DataStreamMessage(framedCompressed))
        ..add(
          HeadersStreamMessage([
            Header.ascii('grpc-status', '0'),
            Header(ascii.encode('x-custom-trl'), customTrlValue),
          ], endStream: true),
        );
      await controller.close();

      final messages = await decodedFuture;
      expect(messages, hasLength(3));
      expect((messages[1] as GrpcData).data, [1, 2, 3, 4]);

      // Neither custom header nor trailer value bytes were decoded yet!
      expect(customHdrValue.byteReads, 0);
      expect(customTrlValue.byteReads, 0);

      // Accessing .metadata decodes once and caches the resulting Map.
      final hdrMeta = (messages[0] as GrpcMetadata).metadata;
      expect(hdrMeta['x-custom-hdr'], 'large-custom-header-value');
      final readsAfterFirstAccess = customHdrValue.byteReads;
      expect(readsAfterFirstAccess, greaterThan(0));
      expect(
        identical((messages[0] as GrpcMetadata).metadata, hdrMeta),
        isTrue,
      );
      expect(customHdrValue.byteReads, readsAfterFirstAccess);

      final trlMeta = (messages[2] as GrpcMetadata).metadata;
      expect(trlMeta['x-custom-trl'], 'large-custom-trailer-value');

      // Non-200 HTTP status and invalid content-type still throw GrpcError synchronously.
      expect(
        () => GrpcHttpDecoder(forResponse: true).convert(
          HeadersStreamMessage([
            Header.ascii(':status', '503'),
            Header.ascii('content-type', 'text/html'),
          ]),
        ),
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );
      expect(
        () => GrpcHttpDecoder(forResponse: true).convert(
          HeadersStreamMessage([
            Header.ascii(':status', '200'),
            Header.ascii('content-type', 'text/plain'),
          ]),
        ),
        throwsA(
          isA<GrpcError>().having((e) => e.code, 'code', StatusCode.unknown),
        ),
      );
    },
  );

  test(
    'ClientCall skips metadata Map materialization unless headers or trailers are accessed',
    () async {
      final hdrBytes = _CountingByteList('server-header');
      final trlBytes = _CountingByteList('server-trailer');
      final mockTransport = MockClientTransportConnection();
      final controllers = <StreamController<StreamMessage>>[];

      when(mockTransport.isOpen).thenReturn(true);
      when(
        mockTransport.onInitialPeerSettingsReceived,
      ).thenAnswer((_) => Future<void>.value());
      when(mockTransport.terminate()).thenAnswer((_) => Future<void>.value());

      var callIndex = 0;
      when(
        mockTransport.makeRequest(any, endStream: anyNamed('endStream')),
      ).thenAnswer((_) {
        final idx = callIndex++;
        final incoming = StreamController<StreamMessage>();
        final outgoing = StreamController<StreamMessage>();
        outgoing.stream.listen((_) {});
        controllers
          ..add(incoming)
          ..add(outgoing);
        final stream = MockClientTransportStream();
        when(stream.incomingMessages).thenAnswer((_) => incoming.stream);
        when(stream.outgoingMessages).thenReturn(outgoing.sink);
        when(stream.terminate()).thenReturn(null);

        if (idx == 0) {
          incoming
            ..add(
              HeadersStreamMessage([
                Header.ascii(':status', '200'),
                Header.ascii('content-type', 'application/grpc'),
                Header(ascii.encode('x-hdr'), hdrBytes),
              ]),
            )
            ..add(DataStreamMessage(Uint8List.fromList([0, 0, 0, 0, 1, 9])))
            ..add(
              HeadersStreamMessage([
                Header.ascii('grpc-status', '0'),
                Header(ascii.encode('x-trl'), trlBytes),
              ], endStream: true),
            );
          unawaited(incoming.close());
        } else {
          // Trailers-Only error with percent-encoded grpc-message.
          incoming.add(
            HeadersStreamMessage([
              Header.ascii(':status', '200'),
              Header.ascii('content-type', 'application/grpc'),
              Header.ascii('grpc-status', '3'),
              Header.ascii('grpc-message', 'bad%20arg%3A%20x'),
              Header.ascii('x-err-trl', 'detail'),
            ], endStream: true),
          );
          unawaited(incoming.close());
        }
        return stream;
      });

      final connection = Http2ClientConnection.fromClientTransportConnector(
        _MockConnector(mockTransport),
        const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final method = ClientMethod<int, int>(
        '/test.LazyService/FastEcho',
        (int v) => Uint8List.fromList([v]),
        (List<int> b) => b.isEmpty ? 0 : b[0],
      );

      final call = ClientCall<int, int>(
        method,
        Stream<int>.value(9),
        CallOptions(),
      );
      connection.dispatchCall(call);
      expect(await call.response.single, 9);

      // Neither headers nor trailers were decoded during the successful RPC!
      expect(hdrBytes.byteReads, 0);
      expect(trlBytes.byteReads, 0);

      // Reading headers and trailers after completion materializes them on demand.
      expect((await call.headers)['x-hdr'], 'server-header');
      expect((await call.trailers)['x-trl'], 'server-trailer');
      expect(hdrBytes.byteReads, greaterThan(0));
      expect(trlBytes.byteReads, greaterThan(0));

      // Trailers-Only error still decodes grpc-message and custom trailers.
      final errCall = ClientCall<int, int>(
        method,
        Stream<int>.value(1),
        CallOptions(),
      );
      final preHeadersFuture = errCall.headers;
      final preTrailersFuture = errCall.trailers;
      connection.dispatchCall(errCall);
      await expectLater(
        errCall.response.single,
        throwsA(
          isA<GrpcError>()
              .having((e) => e.code, 'code', StatusCode.invalidArgument)
              .having((e) => e.message, 'message', 'bad arg: x')
              .having((e) => e.trailers?['x-err-trl'], 'trailer', 'detail'),
        ),
      );
      expect((await preHeadersFuture)['x-err-trl'], 'detail');
      expect((await preTrailersFuture)['x-err-trl'], 'detail');

      await connection.terminate();
      for (final c in controllers) {
        await c.close();
      }
    },
  );

  test(
    'ServerHandler skips clientMetadata Map materialization unless accessed by interceptor or handler',
    () async {
      final unusedClientMeta = _CountingByteList('unused-auth-token');
      final service = _LazyMetaService();
      final server = ConnectionServer(
        [service],
        const [],
        const [],
        CodecRegistry(codecs: const [GzipCodec()]),
      );

      // 1. RPC that does NOT read call.clientMetadata: zero reads on unused header!
      final toServer1 = StreamController<StreamMessage>();
      final fromServer1 = StreamController<StreamMessage>();
      final serverMsgs1 = <StreamMessage>[];
      final done1 = Completer<void>();
      fromServer1.stream.listen(serverMsgs1.add, onDone: done1.complete);

      server.serveStream_(
        stream: TestServerStream(toServer1.stream, fromServer1.sink),
      );
      toServer1.add(
        HeadersStreamMessage([
          Header.ascii(':method', 'POST'),
          Header.ascii(':scheme', 'http'),
          Header.ascii(':path', '/test.LazyService/FastEcho'),
          Header.ascii('grpc-timeout', '5S'),
          Header.ascii('grpc-accept-encoding', 'identity,gzip'),
          Header(ascii.encode('x-unused-meta'), unusedClientMeta),
        ]),
      );
      toServer1.add(DataStreamMessage(Uint8List.fromList([0, 0, 0, 0, 1, 42])));
      await toServer1.close();
      await done1.future;
      await fromServer1.close();

      expect(unusedClientMeta.byteReads, 0);
      expect(service.observedDeadline, isNotNull);
      // Negotiated gzip response encoding from raw grpc-accept-encoding header.
      final respHeaders1 = (serverMsgs1.first as HeadersStreamMessage).headers;
      expect(
        respHeaders1.any(
          (h) =>
              ascii.decode(h.name) == 'grpc-encoding' &&
              ascii.decode(h.value) == 'gzip',
        ),
        isTrue,
      );

      // 2. RPC with an Interceptor mutating call.clientMetadata + grpc-timeout:
      final mutatedMeta = _CountingByteList('initial-value');
      final interceptedService = _LazyMetaService();
      final interceptedServer = ConnectionServer(
        [interceptedService],
        [
          (ServiceCall call, ServiceMethod method) async {
            call.clientMetadata!['x-injected'] = 'from-interceptor';
            call.clientMetadata!['grpc-timeout'] = '10S';
            return null;
          },
        ],
      );

      final toServer2 = StreamController<StreamMessage>();
      final fromServer2 = StreamController<StreamMessage>();
      final done2 = Completer<void>();
      fromServer2.stream.listen((_) {}, onDone: done2.complete);

      interceptedServer.serveStream_(
        stream: TestServerStream(toServer2.stream, fromServer2.sink),
      );
      toServer2.add(
        HeadersStreamMessage([
          Header.ascii(':method', 'POST'),
          Header.ascii(':scheme', 'http'),
          Header.ascii(':path', '/test.LazyService/ReadMetadata'),
          Header(ascii.encode('x-mutated'), mutatedMeta),
        ]),
      );
      toServer2.add(DataStreamMessage(Uint8List.fromList([0, 0, 0, 0, 1, 7])));
      await toServer2.close();
      await done2.future;
      await fromServer2.close();

      expect(mutatedMeta.byteReads, greaterThan(0));
      expect(
        interceptedService.observedMetadata?['x-mutated'],
        'initial-value',
      );
      expect(
        interceptedService.observedMetadata?['x-injected'],
        'from-interceptor',
      );
      expect(interceptedService.observedDeadline, isNotNull);
    },
  );
}
