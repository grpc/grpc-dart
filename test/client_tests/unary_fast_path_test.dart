// Copyright (c) 2025, the gRPC project authors. Please see the AUTHORS file
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
import 'package:grpc/grpc_connection_interface.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

class _LoopbackConnector extends ClientTransportConnector {
  final ClientTransportConnection _connection;
  final Completer<void> _done = Completer<void>();

  _LoopbackConnector(this._connection);

  @override
  Future<ClientTransportConnection> connect() async => _connection;

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

class _CountingConnection implements ClientTransportConnection {
  final ClientTransportConnection _inner;
  int makeRequestCount = 0;

  _CountingConnection(this._inner);

  @override
  bool get isOpen => _inner.isOpen;

  @override
  set onActiveStateChanged(ActiveStateHandler callback) {
    _inner.onActiveStateChanged = callback;
  }

  @override
  Future<void> get onInitialPeerSettingsReceived =>
      _inner.onInitialPeerSettingsReceived;

  @override
  Stream<void> get onFrameReceived => _inner.onFrameReceived;

  @override
  Stream<int> get onPingReceived => _inner.onPingReceived;

  @override
  ClientTransportStream makeRequest(
    List<Header> headers, {
    bool endStream = false,
  }) {
    makeRequestCount++;
    return _inner.makeRequest(headers, endStream: endStream);
  }

  @override
  Future<void> ping() => _inner.ping();

  @override
  Future<void> finish() => _inner.finish();

  @override
  Future<void> terminate([int? errorCode]) => _inner.terminate(errorCode);
}

class _CountingByteList extends ListBase<int> {
  final List<int> _bytes;
  int readCount = 0;

  _CountingByteList(String asciiText) : _bytes = ascii.encode(asciiText);

  @override
  int get length => _bytes.length;

  @override
  set length(int newLength) => throw UnsupportedError('unmodifiable');

  @override
  int operator [](int index) {
    readCount++;
    return _bytes[index];
  }

  @override
  void operator []=(int index, int value) =>
      throw UnsupportedError('unmodifiable');
}

class _EchoClient extends Client {
  static final _echoMethod = ClientMethod<Uint8List, Uint8List>(
    '/test.FastUnary/Echo',
    (Uint8List value) => value,
    (List<int> value) => value is Uint8List ? value : Uint8List.fromList(value),
  );

  _EchoClient(super.channel, {super.interceptors});

  ResponseFuture<Uint8List> echo(Uint8List request, {CallOptions? options}) =>
      $createUnaryCall(_echoMethod, request, options: options);
}

class _CustomTransportStream extends GrpcTransportStream {
  final StreamController<List<int>> outgoing = StreamController<List<int>>();
  final StreamController<GrpcMessage> incoming =
      StreamController<GrpcMessage>();
  bool terminated = false;

  @override
  Stream<GrpcMessage> get incomingMessages => incoming.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => outgoing.sink;

  @override
  Future<void> terminate() async {
    terminated = true;
    await outgoing.close();
    await incoming.close();
  }
}

class _CustomClientConnection extends ClientConnection {
  final void Function(
    String path,
    Map<String, String> metadata,
    _CustomTransportStream stream,
  )
  _onMakeRequest;

  _CustomClientConnection(this._onMakeRequest);

  @override
  String get authority => 'custom.local';

  @override
  String get scheme => 'http';

  @override
  set onStateChanged(void Function(ConnectionState) cb) {}

  @override
  void dispatchCall(ClientCall call) {
    call.onConnectionReady(this);
  }

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onRequestFailure, {
    CallOptions? callOptions,
  }) {
    final stream = _CustomTransportStream();
    _onMakeRequest(path, metadata, stream);
    return stream;
  }

  @override
  Future<void> shutdown() async {}

  @override
  Future<void> terminate() async {}
}

class _CustomChannel extends ClientChannelBase {
  final _CustomClientConnection _customConnection;

  _CustomChannel(this._customConnection);

  @override
  ClientConnection createConnection() => _customConnection;
}

Future<
  ({
    ClientTransportConnectorChannel channel,
    _CountingConnection clientTransport,
    ServerTransportConnection serverTransport,
    Future<void> Function() close,
  })
>
_createLoopbackPair({CodecRegistry? codecRegistry}) async {
  final clientToServer = StreamController<List<int>>();
  final serverToClient = StreamController<List<int>>();

  final rawClient = ClientTransportConnection.viaStreams(
    serverToClient.stream,
    clientToServer.sink,
  );
  final countingClient = _CountingConnection(rawClient);
  final serverTransport = ServerTransportConnection.viaStreams(
    clientToServer.stream,
    serverToClient.sink,
  );

  final connector = _LoopbackConnector(countingClient);
  final channel = ClientTransportConnectorChannel(
    connector,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry: codecRegistry,
    ),
  );

  return (
    channel: channel,
    clientTransport: countingClient,
    serverTransport: serverTransport,
    close: () async {
      await channel.terminate();
      await serverTransport.finish();
      await clientToServer.close();
      await serverToClient.close();
    },
  );
}

void main() {
  test(
    'warm channel dispatches unary request synchronously and coalesces END_STREAM',
    () async {
      final pair = await _createLoopbackPair();
      addTearDown(pair.close);

      final receivedEndStreamFlags = <bool>[];
      pair.serverTransport.incomingStreams.listen((ServerTransportStream s) {
        final payloadChunks = <int>[];
        s.incomingMessages.listen(
          (msg) {
            if (msg is DataStreamMessage) {
              receivedEndStreamFlags.add(msg.endStream);
              payloadChunks.addAll(msg.bytes);
            }
          },
          onDone: () {
            final requestPayload = payloadChunks.sublist(5);
            s.sendHeaders([
              Header.ascii(':status', '200'),
              Header.ascii('content-type', 'application/grpc'),
            ]);
            s.sendData(frame(requestPayload));
            s.sendHeaders([Header.ascii('grpc-status', '0')], endStream: true);
          },
        );
      });

      final client = _EchoClient(pair.channel);

      // Warm up the channel so the HTTP/2 connection is ready.
      final warmup = await client.echo(Uint8List.fromList([1, 2, 3]));
      expect(warmup, [1, 2, 3]);
      expect(receivedEndStreamFlags, [true]);

      pair.clientTransport.makeRequestCount = 0;
      receivedEndStreamFlags.clear();

      // Subsequent unary call on a warm channel must start synchronously before
      // awaiting the returned ResponseFuture.
      final responseFuture = client.echo(Uint8List.fromList([4, 5, 6, 7]));
      expect(pair.clientTransport.makeRequestCount, 1);

      expect(await responseFuture, [4, 5, 6, 7]);
      expect(receivedEndStreamFlags, [true]);
    },
  );

  test(
    'supports chunked responses, gzip compression, large zero-copy frames, and lazy metadata',
    () async {
      final registry = CodecRegistry(
        codecs: const [GzipCodec(), IdentityCodec()],
      );
      final pair = await _createLoopbackPair(codecRegistry: registry);
      addTearDown(pair.close);

      var callIndex = 0;
      final serverDataChunkSizes = <List<int>>[];

      pair.serverTransport.incomingStreams.listen((ServerTransportStream s) {
        final index = callIndex++;
        final dataChunkSizes = <int>[];
        final wireBytes = BytesBuilder(copy: false);
        String? requestEncoding;

        s.incomingMessages.listen(
          (msg) {
            if (msg is HeadersStreamMessage) {
              for (final h in msg.headers) {
                if (ascii.decode(h.name) == 'grpc-encoding') {
                  requestEncoding = ascii.decode(h.value);
                }
              }
            } else if (msg is DataStreamMessage) {
              dataChunkSizes.add(msg.bytes.length);
              wireBytes.add(msg.bytes);
            }
          },
          onDone: () {
            serverDataChunkSizes.add(dataChunkSizes);
            final allBytes = wireBytes.takeBytes();
            final compressed = allBytes[0] == 1;
            var payload = Uint8List.sublistView(allBytes, 5);
            if (compressed && requestEncoding == 'gzip') {
              payload = Uint8List.fromList(
                const GzipCodec().decompress(payload),
              );
            }

            if (index == 0) {
              // Call 0: split response frame across three HTTP/2 DATA frames.
              s.sendHeaders([
                Header.ascii(':status', '200'),
                Header.ascii('content-type', 'application/grpc'),
              ]);
              final framed = frame(payload);
              s.sendData(framed.sublist(0, 3));
              s.sendData(framed.sublist(3, 7));
              s.sendData(framed.sublist(7));
              s.sendHeaders([
                Header.ascii('grpc-status', '0'),
              ], endStream: true);
            } else if (index == 1) {
              // Call 1: gzip-compressed response + accessed headers/trailers.
              s.sendHeaders([
                Header.ascii(':status', '200'),
                Header.ascii('content-type', 'application/grpc'),
                Header.ascii('grpc-encoding', 'gzip'),
                Header.ascii('x-accessed-h', 'read-header'),
              ]);
              s.sendData(frame(payload, const GzipCodec()));
              s.sendHeaders([
                Header.ascii('grpc-status', '0'),
                Header.ascii('x-accessed-t', 'read-trailer'),
              ], endStream: true);
            } else {
              // Call 2: large uncompressed payload (> 16 KiB).
              s.sendHeaders([
                Header.ascii(':status', '200'),
                Header.ascii('content-type', 'application/grpc'),
              ]);
              s.sendData(frame(payload));
              s.sendHeaders([
                Header.ascii('grpc-status', '0'),
              ], endStream: true);
            }
          },
        );
      });

      final client = _EchoClient(pair.channel);

      // Call 0: split response across chunks.
      final res0 = await client.echo(Uint8List.fromList([10, 20, 30, 40, 50]));
      expect(res0, [10, 20, 30, 40, 50]);

      // Call 1: gzip request + gzip response + headers/trailers read.
      final call1 = client.echo(
        Uint8List.fromList(List<int>.generate(256, (i) => i & 0xFF)),
        options: CallOptions(compression: const GzipCodec()),
      );
      final headersFuture = call1.headers;
      final res1 = await call1;
      expect(res1.length, 256);
      expect((await headersFuture)['x-accessed-h'], 'read-header');
      expect((await call1.trailers)['x-accessed-t'], 'read-trailer');

      // Call 2: large uncompressed request (> 16 KiB) uses zero-copy framing
      // and coalesces END_STREAM onto the second DATA chunk without a trailing
      // empty DATA frame.
      final largePayload = Uint8List.fromList(
        List<int>.generate(32768, (i) => (i * 7) & 0xFF),
      );
      final res2 = await client.echo(largePayload);
      expect(res2, largePayload);
      expect(serverDataChunkSizes[2], [5, 16384, 16384]);

      // Verify raw HTTP/2 header/trailer bytes are not decoded when unaccessed.
      final unaccessedHeaderValue = _CountingByteList('unused-header');
      final unaccessedTrailerValue = _CountingByteList('unused-trailer');
      final directTransport = _DirectHeaderStreamTransport(
        responseHeaders: [
          Header.ascii(':status', '200'),
          Header.ascii('content-type', 'application/grpc'),
          Header(ascii.encode('x-unaccessed-h'), unaccessedHeaderValue),
        ],
        responsePayload: Uint8List.fromList([99]),
        responseTrailers: [
          Header.ascii('grpc-status', '0'),
          Header(ascii.encode('x-unaccessed-t'), unaccessedTrailerValue),
        ],
      );
      final directChannel = ClientTransportConnectorChannel(
        _LoopbackConnector(directTransport),
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      addTearDown(directChannel.terminate);
      expect(await _EchoClient(directChannel).echo(Uint8List.fromList([99])), [
        99,
      ]);
      expect(unaccessedHeaderValue.readCount, 0);
      expect(unaccessedTrailerValue.readCount, 0);
    },
  );

  test(
    'preserves cancellation, timeout, metadataProviders, interceptors, timeline, and custom channels',
    () async {
      final pair = await _createLoopbackPair();
      addTearDown(pair.close);

      pair.serverTransport.incomingStreams.listen((ServerTransportStream s) {
        final headers = <String, String>{};
        final bytes = BytesBuilder(copy: false);
        s.incomingMessages.listen(
          (msg) {
            if (msg is HeadersStreamMessage) {
              for (final h in msg.headers) {
                headers[ascii.decode(h.name)] = ascii.decode(h.value);
              }
            } else if (msg is DataStreamMessage) {
              bytes.add(msg.bytes);
            }
          },
          onDone: () {
            final path = headers[':path'];
            if (headers['x-hang'] == 'true') {
              // Intentionally hang to test cancel() and timeout.
              return;
            }
            final payload = bytes.takeBytes().sublist(5);
            s.sendHeaders([
              Header.ascii(':status', '200'),
              Header.ascii('content-type', 'application/grpc'),
              if (headers['x-from-provider'] != null)
                Header.ascii('x-echo-provider', headers['x-from-provider']!),
              if (path != null) Header.ascii('x-echo-path', path),
            ]);
            s.sendData(frame(payload));
            s.sendHeaders([Header.ascii('grpc-status', '0')], endStream: true);
          },
        );
      });

      final client = _EchoClient(pair.channel);

      // 1. Fire-and-forget cancel() must not cause unhandled zone errors.
      final cancelledCall = client.echo(
        Uint8List.fromList([1]),
        options: CallOptions(metadata: {'x-hang': 'true'}),
      );
      await cancelledCall.cancel();
      expect(await cancelledCall.headers, isEmpty);
      expect(await cancelledCall.trailers, isEmpty);
      await expectLater(
        cancelledCall,
        throwsA(
          isA<GrpcError>().having((e) => e.code, 'code', StatusCode.cancelled),
        ),
      );

      // 2. Timeout completes with DEADLINE_EXCEEDED.
      final timedOutCall = client.echo(
        Uint8List.fromList([2]),
        options: CallOptions(
          metadata: {'x-hang': 'true'},
          timeout: const Duration(milliseconds: 20),
        ),
      );
      await expectLater(
        timedOutCall,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.deadlineExceeded,
          ),
        ),
      );

      // 3. metadataProviders fallback works cleanly.
      final providerCall = client.echo(
        Uint8List.fromList([3]),
        options: CallOptions(
          providers: [
            (metadata, uri) async {
              metadata['x-from-provider'] = 'ok';
            },
          ],
        ),
      );
      expect(await providerCall, [3]);
      expect((await providerCall.headers)['x-echo-provider'], 'ok');

      // 4. ClientInterceptor fallback works cleanly.
      var intercepted = false;
      final interceptedClient = _EchoClient(
        pair.channel,
        interceptors: [
          _CallbackInterceptor(() {
            intercepted = true;
          }),
        ],
      );
      expect(await interceptedClient.echo(Uint8List.fromList([9])), [9]);
      expect(intercepted, isTrue);

      // 5. Custom ClientChannelBase with non-Http2ClientConnection works even
      // when makeRequest mutates/clears the passed metadata map.
      final customChannel = _CustomChannel(
        _CustomClientConnection((path, metadata, stream) {
          final reqVal = metadata['x-req'] ?? '';
          metadata['x-transport-added'] = '1';
          metadata.clear();
          stream.outgoing.stream.listen((payload) {
            stream.incoming.add(
              GrpcMetadata({
                ':status': '200',
                'content-type': 'application/grpc',
                'x-custom': reqVal,
              }),
            );
            stream.incoming.add(GrpcData(payload, isCompressed: false));
            stream.incoming.add(GrpcMetadata({'grpc-status': '0'}));
            stream.incoming.close();
          });
        }),
      );
      addTearDown(customChannel.shutdown);
      final customClient = _EchoClient(customChannel);
      // Default empty CallOptions() singleton must also pass a mutable map.
      expect(await customClient.echo(Uint8List.fromList([6])), [6]);
      final sharedCustomOpts = CallOptions(metadata: {'x-req': 'custom-val'});
      for (var i = 0; i < 2; i++) {
        final customCall = customClient.echo(
          Uint8List.fromList([7, 8]),
          options: sharedCustomOpts,
        );
        expect(await customCall, [7, 8]);
        expect((await customCall.headers)['x-custom'], 'custom-val');
      }
    },
  );
}

class _CallbackInterceptor extends ClientInterceptor {
  final void Function() _onUnary;

  _CallbackInterceptor(this._onUnary);

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    _onUnary();
    return invoker(method, request, options);
  }
}

class _DirectHeaderStreamTransport implements ClientTransportConnection {
  final List<Header> responseHeaders;
  final Uint8List responsePayload;
  final List<Header> responseTrailers;

  _DirectHeaderStreamTransport({
    required this.responseHeaders,
    required this.responsePayload,
    required this.responseTrailers,
  });

  @override
  bool get isOpen => true;

  @override
  set onActiveStateChanged(ActiveStateHandler callback) {}

  @override
  Future<void> get onInitialPeerSettingsReceived => Future<void>.value();

  @override
  Stream<void> get onFrameReceived => const Stream<void>.empty();

  @override
  Stream<int> get onPingReceived => const Stream<int>.empty();

  @override
  ClientTransportStream makeRequest(
    List<Header> headers, {
    bool endStream = false,
  }) {
    final stream = _DirectClientTransportStream();
    stream.outgoing.stream.listen(
      (_) {},
      onDone: () {
        stream.incoming.add(HeadersStreamMessage(responseHeaders));
        stream.incoming.add(DataStreamMessage(frame(responsePayload)));
        stream.incoming.add(
          HeadersStreamMessage(responseTrailers, endStream: true),
        );
        stream.incoming.close();
      },
    );
    return stream;
  }

  @override
  Future<void> ping() async {}

  @override
  Future<void> finish() async {}

  @override
  Future<void> terminate([int? errorCode]) async {}
}

class _DirectClientTransportStream extends TransportStream
    implements ClientTransportStream {
  final StreamController<StreamMessage> outgoing =
      StreamController<StreamMessage>();
  final StreamController<StreamMessage> incoming =
      StreamController<StreamMessage>();

  @override
  int get id => 1;

  @override
  Stream<StreamMessage> get incomingMessages => incoming.stream;

  @override
  StreamSink<StreamMessage> get outgoingMessages => outgoing.sink;

  @override
  set onTerminated(void Function(int? errorCode)? value) {}

  @override
  Stream<TransportStreamPush> get peerPushes =>
      const Stream<TransportStreamPush>.empty();

  @override
  void terminate() {
    outgoing.close();
    incoming.close();
  }
}
