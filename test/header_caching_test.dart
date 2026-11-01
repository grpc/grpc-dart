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
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/call.dart' show WebCallOptions;
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/client_utils.mocks.dart';
import 'src/server_utils.dart';

class _MockConnector extends ClientTransportConnector {
  final ClientTransportConnection connection;
  String currentAuthority = 'example.test:443';
  final Completer<void> _done = Completer<void>();

  _MockConnector(this.connection);

  @override
  Future<ClientTransportConnection> connect() async => connection;

  @override
  String get authority => currentAuthority;

  @override
  Future<void> get done => _done.future;

  @override
  void shutdown() {
    if (!_done.isCompleted) {
      _done.complete();
    }
  }
}

class _HeaderEchoService extends Service {
  @override
  String get $name => 'test.HeaderService';

  static Stream<int> _emptyStream(
    ServiceCall call,
    Future<int> request,
  ) async* {
    await request;
  }

  _HeaderEchoService() {
    $addMethod(
      ServiceMethod<int, int>(
        'Unary',
        (ServiceCall call, Future<int> request) async => await request,
        false,
        false,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
    $addMethod(
      ServiceMethod<int, int>(
        'EmptyStream',
        _emptyStream,
        false,
        true,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
    $addMethod(
      ServiceMethod<int, int>(
        'CustomMetadata',
        (ServiceCall call, Future<int> request) async {
          final v = await request;
          call.headers![':status'] = '500';
          call.headers!['content-type'] = 'text/plain';
          call.headers!['x-server-hdr'] = 'hdr-$v';
          call.trailers![':status'] = '404';
          call.trailers!['content-type'] = 'text/html';
          call.trailers!['x-server-trl'] = 'trl-$v';
          return v;
        },
        false,
        false,
        (List<int> bytes) => bytes.isEmpty ? 0 : bytes[0],
        (int value) => Uint8List.fromList([value & 0xFF]),
      ),
    );
  }
}

Map<String, String> _decodeHeaderList(List<Header> headers) => {
  for (final h in headers) ascii.decode(h.name): utf8.decode(h.value),
};

Header _findHeader(List<Header> headers, String name) =>
    headers.firstWhere((h) => ascii.decode(h.name) == name);

Future<List<HeadersStreamMessage>> _runServerStreamCall(
  ConnectionServer server,
  String path, {
  List<int>? requestFrame,
}) async {
  final toServer = StreamController<StreamMessage>();
  final fromServer = StreamController<StreamMessage>();
  final messages = <StreamMessage>[];
  final done = Completer<void>();
  fromServer.stream.listen(messages.add, onDone: done.complete);

  server.serveStream_(
    stream: TestServerStream(toServer.stream, fromServer.sink),
  );
  toServer.add(
    HeadersStreamMessage(
      Http2ClientConnection.createCallHeaders(
        false,
        'localhost',
        path,
        null,
        null,
        null,
      ),
    ),
  );
  if (requestFrame != null) {
    toServer.add(DataStreamMessage(requestFrame));
  }
  await toServer.close();
  await done.future;
  await fromServer.close();
  return messages.whereType<HeadersStreamMessage>().toList();
}

void main() {
  test(
    'CallOptions reuses empty singleton and preserves WebCallOptions merge semantics',
    () {
      final empty1 = CallOptions();
      final empty2 = CallOptions(metadata: const {}, providers: const []);
      expect(identical(empty1, empty2), isTrue);

      final withMeta = CallOptions(metadata: {'x-key': 'val'});
      expect(identical(empty1.mergedWith(withMeta), withMeta), isTrue);
      expect(identical(withMeta.mergedWith(empty2), withMeta), isTrue);

      final webOpts = WebCallOptions(
        bypassCorsPreflight: true,
        withCredentials: true,
      );
      final merged1 = empty1.mergedWith(webOpts);
      final merged2 = webOpts.mergedWith(empty1);
      expect(merged1, isA<WebCallOptions>());
      expect((merged1 as WebCallOptions).bypassCorsPreflight, isTrue);
      expect(merged1.withCredentials, isTrue);
      expect(merged2, isA<WebCallOptions>());
      expect((merged2 as WebCallOptions).bypassCorsPreflight, isTrue);
      expect(merged2.withCredentials, isTrue);
    },
  );

  test(
    'Http2ClientConnection caches encoded request headers and static CallOptions metadata',
    () async {
      final mockTransport = MockClientTransportConnection();
      final capturedHeaders = <List<Header>>[];
      final controllers = <StreamController<StreamMessage>>[];

      when(mockTransport.isOpen).thenReturn(true);
      when(
        mockTransport.onInitialPeerSettingsReceived,
      ).thenAnswer((_) => Future<void>.value());
      when(mockTransport.finish()).thenAnswer((_) => Future<void>.value());
      when(mockTransport.terminate()).thenAnswer((_) => Future<void>.value());
      when(
        mockTransport.makeRequest(any, endStream: anyNamed('endStream')),
      ).thenAnswer((invocation) {
        capturedHeaders.add(
          invocation.positionalArguments.first as List<Header>,
        );
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
        incoming.add(
          HeadersStreamMessage([
            Header.ascii(':status', '200'),
            Header.ascii('content-type', 'application/grpc'),
            Header.ascii('grpc-status', '0'),
          ], endStream: true),
        );
        unawaited(incoming.close());
        return stream;
      });

      final connector = _MockConnector(mockTransport);
      final connection = Http2ClientConnection.fromClientTransportConnector(
        connector,
        ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          userAgent: 'custom-agent/1.0',
          codecRegistry: CodecRegistry(
            codecs: const [GzipCodec(), IdentityCodec()],
          ),
        ),
      );
      final method = ClientMethod<int, int>(
        '/test.HeaderService/Unary',
        (int v) => Uint8List.fromList([v]),
        (List<int> b) => b.isEmpty ? 0 : b[0],
      );
      final staticOptions = CallOptions(
        metadata: {
          'X-Api-Key': ' secret ',
          'content-type': 'ignored',
          ':pseudo': 'ignored',
        },
        compression: const GzipCodec(),
      );

      for (var i = 0; i < 2; i++) {
        final call = ClientCall<int, int>(
          method,
          Stream<int>.value(i),
          staticOptions,
        );
        connection.dispatchCall(call);
        await call.response.drain<void>();
        await call.trailers;
      }

      expect(capturedHeaders, hasLength(2));
      final first = capturedHeaders[0];
      final second = capturedHeaders[1];

      expect(_decodeHeaderList(first), {
        ':method': 'POST',
        ':scheme': 'http',
        ':path': '/test.HeaderService/Unary',
        ':authority': 'example.test:443',
        'content-type': 'application/grpc',
        'te': 'trailers',
        'user-agent': 'custom-agent/1.0',
        'grpc-accept-encoding': 'gzip,identity',
        'grpc-encoding': 'gzip',
        'x-api-key': 'secret',
      });

      // Every static/connection-scoped Header instance is reused across RPCs.
      for (final name in [
        ':method',
        ':scheme',
        ':path',
        ':authority',
        'content-type',
        'te',
        'user-agent',
        'grpc-accept-encoding',
        'grpc-encoding',
        'x-api-key',
      ]) {
        expect(
          identical(_findHeader(first, name), _findHeader(second, name)),
          isTrue,
          reason: 'Expected cached Header instance for $name',
        );
      }

      // Overriding grpc-accept-encoding per CallOptions is honored without
      // polluting the default connection header.
      final customAcceptCall = ClientCall<int, int>(
        method,
        Stream<int>.value(3),
        CallOptions(metadata: {'grpc-accept-encoding': 'identity'}),
      );
      connection.dispatchCall(customAcceptCall);
      await customAcceptCall.response.drain<void>();
      await customAcceptCall.trailers;
      expect(
        _decodeHeaderList(capturedHeaders[2])['grpc-accept-encoding'],
        'identity',
      );

      await connection.terminate();
      for (final c in controllers) {
        await c.close();
      }
    },
  );

  test(
    'ServerHandler reuses default response headers and trailers and strips reserved custom keys',
    () async {
      final server = ConnectionServer([_HeaderEchoService()]);
      final frame = Uint8List.fromList([0, 0, 0, 0, 1, 7]);

      final rpc1 = await _runServerStreamCall(
        server,
        '/test.HeaderService/Unary',
        requestFrame: frame,
      );
      final rpc2 = await _runServerStreamCall(
        server,
        '/test.HeaderService/Unary',
        requestFrame: frame,
      );
      expect(rpc1, hasLength(2));
      expect(rpc2, hasLength(2));
      expect(identical(rpc1[0].headers, rpc2[0].headers), isTrue);
      expect(identical(rpc1[1].headers, rpc2[1].headers), isTrue);

      // Trailers-Only OK response also reuses a pre-encoded header list.
      final empty1 = await _runServerStreamCall(
        server,
        '/test.HeaderService/EmptyStream',
        requestFrame: frame,
      );
      final empty2 = await _runServerStreamCall(
        server,
        '/test.HeaderService/EmptyStream',
        requestFrame: frame,
      );
      expect(empty1, hasLength(1));
      expect(identical(empty1[0].headers, empty2[0].headers), isTrue);
      expect(_decodeHeaderList(empty1[0].headers), {
        ':status': '200',
        'content-type': 'application/grpc',
        'grpc-status': '0',
      });

      // Custom metadata strips :status and content-type while preserving custom keys.
      final custom = await _runServerStreamCall(
        server,
        '/test.HeaderService/CustomMetadata',
        requestFrame: frame,
      );
      expect(_decodeHeaderList(custom[0].headers), {
        ':status': '200',
        'content-type': 'application/grpc',
        'x-server-hdr': 'hdr-7',
      });
      expect(_decodeHeaderList(custom[1].headers), {
        'x-server-trl': 'trl-7',
        'grpc-status': '0',
      });
    },
  );
}
