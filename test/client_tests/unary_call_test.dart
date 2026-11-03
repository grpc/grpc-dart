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

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

List<int> _identity(List<int> value) => value;

final _echo = ClientMethod('/test.Echo/Echo', _identity, _identity);
final _collect = ClientMethod('/test.Echo/Collect', _identity, _identity);

class _EchoClient extends Client {
  _EchoClient(super.channel, {super.interceptors});

  ResponseFuture<List<int>> echo(List<int> request, {CallOptions? options}) =>
      $createUnaryCall(_echo, request, options: options);

  ResponseFuture<List<int>> collect(Stream<List<int>> requests) =>
      $createStreamingCall(_collect, requests).single;
}

/// A request received by [_Server].
class _Request {
  final ServerTransportStream stream;
  final Map<String, String> headers;

  /// The END_STREAM flags of the received DATA frames.
  final endStreamFlags = <bool>[];

  /// The first request message, decompressed.
  List<int> message = const [];

  _Request(this.stream, this.headers);
}

/// The server end of an in-memory HTTP/2 connection to [connection].
class _Server {
  final requests = <_Request>[];

  /// Called with the first message of each request.
  void Function(_Request request) onRequest = _echoRequest;

  final _toServer = StreamController<List<int>>();
  final _toClient = StreamController<List<int>>();
  late final connection = _CountingConnection(
    ClientTransportConnection.viaStreams(_toClient.stream, _toServer.sink),
  );
  late final _transport = ServerTransportConnection.viaStreams(
    _toServer.stream,
    _toClient.sink,
  );

  _Server() {
    _transport.incomingStreams.listen(_onStream);
  }

  void _onStream(ServerTransportStream stream) {
    late final _Request request;
    stream.incomingMessages.listen((message) {
      switch (message) {
        case HeadersStreamMessage(:final headers):
          request = _Request(stream, {
            for (final header in headers)
              ascii.decode(header.name): ascii.decode(header.value),
          });
          requests.add(request);
        case DataStreamMessage(:final bytes, :final endStream):
          request.endStreamFlags.add(endStream);
          if (request.endStreamFlags.length > 1) return;
          final payload = bytes.sublist(5);
          request.message = bytes[0] == 1
              ? const GzipCodec().decompress(payload)
              : payload;
          onRequest(request);
      }
    }, onError: (_) {});
  }

  /// Echoes the request message and its `x-` headers, unless there is an
  /// `x-hang` header.
  static void _echoRequest(_Request request) {
    if (request.headers.containsKey('x-hang')) return;
    respond(request, frame(request.message), [
      for (final MapEntry(:key, :value) in request.headers.entries)
        if (key.startsWith('x-')) Header.ascii(key, value),
    ]);
  }

  static void respond(
    _Request request,
    List<int>? data, [
    List<Header> headers = const [],
    String status = '0',
  ]) {
    request.stream.sendHeaders([
      Header.ascii(':status', '200'),
      Header.ascii('content-type', 'application/grpc'),
      ...headers,
    ]);
    if (data != null) request.stream.sendData(data);
    request.stream.sendHeaders([
      Header.ascii('grpc-status', status),
    ], endStream: true);
  }

  ClientTransportConnector get connector => _Connector(connection);

  Future<void> close() async {
    await _transport.finish();
    await _toServer.close();
    await _toClient.close();
  }
}

class _Connector extends ClientTransportConnector {
  final ClientTransportConnection _connection;
  final _done = Completer<void>();

  _Connector(this._connection);

  @override
  Future<ClientTransportConnection> connect() async => _connection;

  @override
  String get authority => 'localhost';

  @override
  Future<void> get done => _done.future;

  @override
  void shutdown() {
    if (!_done.isCompleted) _done.complete();
  }
}

/// Counts the HTTP/2 streams that the client opens.
class _CountingConnection implements ClientTransportConnection {
  final ClientTransportConnection _inner;
  int requests = 0;

  _CountingConnection(this._inner);

  @override
  ClientTransportStream makeRequest(
    List<Header> headers, {
    bool endStream = false,
  }) {
    requests++;
    return _inner.makeRequest(headers, endStream: endStream);
  }

  @override
  bool get isOpen => _inner.isOpen;

  @override
  set onActiveStateChanged(ActiveStateHandler callback) =>
      _inner.onActiveStateChanged = callback;

  @override
  Future<void> get onInitialPeerSettingsReceived =>
      _inner.onInitialPeerSettingsReceived;

  @override
  Stream<void> get onFrameReceived => _inner.onFrameReceived;

  @override
  Stream<int> get onPingReceived => _inner.onPingReceived;

  @override
  Future<void> ping() => _inner.ping();

  @override
  Future<void> finish() => _inner.finish();

  @override
  Future<void> terminate([int? errorCode]) => _inner.terminate(errorCode);
}

/// A channel that logs calls and connection requests.
class _LoggingChannel extends ClientTransportConnectorChannel {
  final calls = <String>[];
  var connectionRequests = 0;

  _LoggingChannel(super.transportConnector);

  @override
  ClientCall<Q, R> createCall<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
  ) {
    calls.add(method.path);
    return super.createCall(method, requests, options);
  }

  @override
  Future<ClientConnection> getConnection() {
    connectionRequests++;
    return super.getConnection();
  }
}

class _MetadataInterceptor extends ClientInterceptor {
  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) => invoker(
    method,
    request,
    options.mergedWith(CallOptions(metadata: {'x-interceptor': 'yes'})),
  );
}

/// A non-HTTP/2 transport that echoes the requests.
class _EchoTransportStream extends GrpcTransportStream {
  final _incoming = StreamController<GrpcMessage>();
  final _outgoing = StreamController<List<int>>();

  _EchoTransportStream() {
    _outgoing.stream.listen(
      (message) => _incoming
        ..add(GrpcMetadata({':status': '200'}))
        ..add(GrpcData(message, isCompressed: false))
        ..add(GrpcMetadata({'grpc-status': '0'})),
      onDone: _incoming.close,
    );
  }

  @override
  Stream<GrpcMessage> get incomingMessages => _incoming.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoing.sink;

  @override
  Future<void> terminate() async {
    await _outgoing.close();
  }
}

class _EchoConnection implements ClientConnection {
  @override
  String get authority => 'echo';

  @override
  String get scheme => 'http';

  @override
  set onStateChanged(void Function(ConnectionState) cb) {}

  @override
  void dispatchCall(ClientCall call) => call.onConnectionReady(this);

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onRequestFailure, {
    CallOptions? callOptions,
  }) {
    if (metadata.containsKey('x-fail')) throw StateError('failed');
    return _EchoTransportStream();
  }

  @override
  Future<void> shutdown() async {}

  @override
  Future<void> terminate() async {}
}

class _EchoChannel extends ClientChannelBase {
  @override
  ClientConnection createConnection() => _EchoConnection();
}

Matcher _throwsGrpcError(int code) =>
    throwsA(isA<GrpcError>().having((e) => e.code, 'code', code));

void main() {
  group('over HTTP/2', () {
    late _Server server;
    late ClientTransportConnectorChannel channel;

    setUp(() {
      server = _Server();
      channel = ClientTransportConnectorChannel(
        server.connector,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(
            codecs: const [GzipCodec(), IdentityCodec()],
          ),
        ),
      );
    });

    tearDown(() async {
      await channel.terminate();
      await server.close();
    });

    test('a warm channel sends a unary request before returning, and ends '
        'the stream with its DATA frame', () async {
      final client = _EchoClient(channel);
      expect(await client.echo([1, 2, 3]), [1, 2, 3]);

      final call = client.echo([4, 5]);
      expect(server.connection.requests, 2);
      expect(await call, [4, 5]);
      expect(server.requests.map((r) => r.endStreamFlags), [
        [true],
        [true],
      ]);
    });

    test(
      'channels overriding createCall and getConnection see unary calls',
      () async {
        final channel = _LoggingChannel(server.connector);
        addTearDown(channel.terminate);
        final client = _EchoClient(channel);

        expect(await client.echo([1]), [1]);
        expect(await client.echo([2]), [2]);
        expect(channel.calls, ['/test.Echo/Echo', '/test.Echo/Echo']);
        expect(channel.connectionRequests, 2);
      },
    );

    test('interceptors and metadata providers see unary calls', () async {
      final client = _EchoClient(
        channel,
        interceptors: [_MetadataInterceptor()],
      );
      final call = client.echo(
        [3],
        options: CallOptions(
          providers: [
            (metadata, uri) async {
              await Future<void>.delayed(Duration.zero);
              metadata['x-provider'] = uri;
            },
          ],
        ),
      );

      expect(await call, [3]);
      final headers = await call.headers;
      expect(headers['x-interceptor'], 'yes');
      expect(headers['x-provider'], 'http://localhost/test.Echo');
      expect(server.requests.single.endStreamFlags, [true]);
    });

    test('unary calls work with timeline logging', () async {
      isTimelineLoggingEnabled = true;
      addTearDown(() => isTimelineLoggingEnabled = false);
      final client = _EchoClient(channel);

      expect(await client.echo([4]), [4]);
      server.onRequest = (request) => _Server.respond(request, null, [], '5');
      await expectLater(
        client.echo([4]),
        _throwsGrpcError(StatusCode.notFound),
      );
    });

    test(
      'cancel() without awaiting the call does not leak its error',
      () async {
        final clients = [
          _EchoClient(channel),
          _EchoClient(channel, interceptors: [_MetadataInterceptor()]),
        ];
        for (final client in clients) {
          final call = client.echo(
            [5],
            options: CallOptions(
              metadata: {'x-hang': ''},
              providers: [(metadata, uri) {}],
            ),
          );
          await pumpEventQueue();
          await call.cancel();
          await pumpEventQueue();
          expect(await call.headers, isEmpty);
          expect(await call.trailers, isEmpty);
          await expectLater(call, _throwsGrpcError(StatusCode.cancelled));
        }
      },
    );

    test('unary calls time out', () async {
      final call = _EchoClient(channel).echo(
        [6],
        options: CallOptions(
          metadata: {'x-hang': ''},
          timeout: const Duration(milliseconds: 10),
        ),
      );
      await expectLater(call, _throwsGrpcError(StatusCode.deadlineExceeded));
    });

    test('headers and trailers complete if the server sends nothing', () async {
      server.onRequest = (request) => request.stream.outgoingMessages.close();
      final call = _EchoClient(channel).echo([7]);

      await expectLater(call, _throwsGrpcError(StatusCode.unavailable));
      expect(await call.headers, isEmpty);
      expect(await call.trailers, isEmpty);
    });

    test('responses can be chunked and compressed', () async {
      final client = _EchoClient(channel);
      server.onRequest = (request) {
        final data = frame(request.message);
        request.stream
          ..sendHeaders([
            Header.ascii(':status', '200'),
            Header.ascii('content-type', 'application/grpc'),
          ])
          ..sendData(data.sublist(0, 3))
          ..sendData(data.sublist(3, 7))
          ..sendData(data.sublist(7))
          ..sendHeaders([Header.ascii('grpc-status', '0')], endStream: true);
      };
      expect(await client.echo([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5]);

      server.onRequest = (request) {
        expect(request.headers['grpc-encoding'], 'gzip');
        _Server.respond(request, frame(request.message, const GzipCodec()), [
          Header.ascii('grpc-encoding', 'gzip'),
          Header.ascii('x-h', 'h'),
        ]);
      };
      final message = List.generate(256, (i) => i);
      final call = client.echo(
        message,
        options: CallOptions(compression: const GzipCodec()),
      );
      expect(await call, message);
      expect((await call.headers)['x-h'], 'h');
      expect((await call.trailers)['grpc-status'], '0');
    });

    test(
      'a single response stops a client stream that is still sending',
      () async {
        server.onRequest = (request) => _Server.respond(request, frame([42]));
        final requests = StreamController<List<int>>();
        addTearDown(requests.close);
        final call = _EchoClient(channel).collect(requests.stream);
        requests.add([1]);

        expect(await call, [42]);
        await pumpEventQueue();
        expect(requests.hasListener, isFalse);
        expect(server.requests.single.endStreamFlags, [false]);
      },
    );
  });

  test('custom transports get the request and the end of the stream', () async {
    final channel = _EchoChannel();
    addTearDown(channel.terminate);
    final client = _EchoClient(channel);

    expect(await client.echo([8]), [8]);
    expect(await client.echo([9]), [9]);
    // Fails while the channel creates the call.
    await expectLater(
      client.echo([10], options: CallOptions(metadata: {'x-fail': ''})),
      _throwsGrpcError(StatusCode.unavailable),
    );
  });
}
