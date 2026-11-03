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
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'src/utils.dart';

Uint8List _asBytes(List<int> data) =>
    data is Uint8List ? data : Uint8List.fromList(data);

List<int> _identity(Uint8List value) => value;

typedef _UnaryHandler =
    FutureOr<Uint8List> Function(ServiceCall call, Future<Uint8List> request);

ServiceMethod<Uint8List, Uint8List> _unary(
  _UnaryHandler handler, {
  Uint8List Function(List<int> bytes) deserialize = _asBytes,
  List<int> Function(Uint8List value) serialize = _identity,
}) => ServiceMethod('Unary', handler, false, false, deserialize, serialize);

class _TestService extends Service {
  final void Function(ServiceCall call)? onMetadata;

  _TestService(List<ServiceMethod> methods, {this.onMetadata}) {
    methods.forEach($addMethod);
  }

  @override
  String get $name => 'Test';

  @override
  void $onMetadata(ServiceCall context) => onMetadata?.call(context);
}

/// Reverses requests and appends a 0 to responses.
class _ReversingMethod extends ServiceMethod<Uint8List, Uint8List> {
  _ReversingMethod(_UnaryHandler handler)
    : super('Unary', handler, false, false, _asBytes, _identity);

  @override
  Uint8List deserialize(List<int> data) =>
      Uint8List.fromList(data.reversed.toList());

  @override
  List<int> serialize(dynamic response) => [...response as List<int>, 0];
}

/// Appends 1 to requests and 2 to responses, without passing the original
/// streams to the handler.
class _MappingInterceptor extends ServerInterceptor {
  @override
  Stream<R> intercept<Q, R>(
    ServiceCall call,
    ServiceMethod<Q, R> method,
    Stream<Q> requests,
    ServerStreamingInvoker<Q, R> invoker,
  ) {
    final mapped = requests.map((r) => Uint8List.fromList([...r as List, 1]));
    return invoker(
      call,
      method,
      mapped as Stream<Q>,
    ).map((r) => Uint8List.fromList([...r as List, 2]) as R);
  }
}

class _PassThroughInterceptor extends ServerInterceptor {
  int calls = 0;

  @override
  Stream<R> intercept<Q, R>(
    ServiceCall call,
    ServiceMethod<Q, R> method,
    Stream<Q> requests,
    ServerStreamingInvoker<Q, R> invoker,
  ) {
    calls++;
    return super.intercept(call, method, requests, invoker);
  }
}

class _TestClient extends Client {
  static final _unary = ClientMethod<List<int>, List<int>>(
    '/Test/Unary',
    _asBytes,
    _asBytes,
  );

  _TestClient(super.channel);

  ResponseFuture<List<int>> unary(List<int> request, {CallOptions? options}) =>
      $createUnaryCall(_unary, request, options: options);
}

class _TestServerStream extends ServerTransportStream {
  @override
  final Stream<StreamMessage> incomingMessages;
  final _outgoing = StreamController<StreamMessage>();

  bool terminated = false;
  void Function(int?)? onTerminatedCallback;

  _TestServerStream(this.incomingMessages);

  @override
  StreamSink<StreamMessage> get outgoingMessages => _outgoing;

  /// The messages sent by the server, until it closes the stream.
  Stream<StreamMessage> get sent => _outgoing.stream;

  @override
  int get id => 1;

  @override
  void terminate() {
    terminated = true;
    _outgoing.close();
  }

  @override
  set onTerminated(void Function(int?) value) => onTerminatedCallback = value;

  @override
  bool get canPush => false;

  @override
  ServerTransportStream push(List<Header> requestHeaders) =>
      throw UnsupportedError('push');
}

class _CallbackSink implements Sink<void> {
  final void Function() _onData;

  _CallbackSink(this._onData);

  @override
  void add(void data) => _onData();

  @override
  void close() {}
}

/// A call to `/Test/<method>` on an in-memory stream, which delivers incoming
/// messages synchronously.
class _TestCall {
  final incoming = StreamController<StreamMessage>(sync: true);
  final outgoing = <StreamMessage>[];
  late final _TestServerStream stream;

  /// Completes when the server has closed the stream.
  late final Future<void> done;

  _TestCall(ConnectionServer server, {Sink<void>? onDataReceived}) {
    stream = _TestServerStream(incoming.stream);
    done = stream.sent.forEach(outgoing.add);
    server.serveStream_(stream: stream, onDataReceived: onDataReceived);
  }

  void sendHeaders({String method = 'Unary', Duration? timeout}) {
    incoming.add(
      HeadersStreamMessage(
        Http2ClientConnection.createCallHeaders(
          false,
          'test',
          '/Test/$method',
          timeout,
          null,
          null,
        ),
      ),
    );
  }

  void sendRequest(List<int> request) =>
      incoming.add(DataStreamMessage(frame(request)));

  /// Sends a complete unary request and closes the request stream.
  Future<void> sendUnary(List<int> request) {
    sendHeaders();
    sendRequest(request);
    return incoming.close();
  }

  Map<String, String> get trailers =>
      headersToMap((outgoing.last as HeadersStreamMessage).headers);

  List<List<int>> get responses => [
    for (final message in outgoing.whereType<DataStreamMessage>())
      message.bytes.sublist(5),
  ];
}

ConnectionServer _server(
  _UnaryHandler handler, {
  Uint8List Function(List<int> bytes) deserialize = _asBytes,
  List<int> Function(Uint8List value) serialize = _identity,
  void Function(ServiceCall call)? onMetadata,
}) => Server.create(
  services: [
    _TestService([
      _unary(handler, deserialize: deserialize, serialize: serialize),
    ], onMetadata: onMetadata),
  ],
);

/// An echo handler that passes the error of its request future to [onError].
_UnaryHandler _catchRequestError(void Function(Object error) onError) =>
    (call, request) async {
      try {
        return await request;
      } catch (error) {
        onError(error);
        rethrow;
      }
    };

void main() {
  test('starts the handler on HEADERS when there are no Interceptors, and '
      'deserializes the request without copying it', () async {
    var handlerStarted = false;
    late List<int> deserialized;
    DateTime? deadline;
    final call = _TestCall(
      _server((call, request) async {
        handlerStarted = true;
        final value = await request;
        deadline = call.deadline;
        return Uint8List.fromList(value.reversed.toList());
      }, deserialize: (bytes) => _asBytes(deserialized = bytes)),
    );

    call.sendHeaders(timeout: const Duration(minutes: 1));
    expect(handlerStarted, isTrue);

    final chunk = _asBytes(frame([1, 2, 3]));
    call.incoming.add(DataStreamMessage(chunk, endStream: true));
    expect(
      deserialized,
      isA<Uint8List>().having((d) => d.offsetInBytes, 'offsetInBytes', 5),
    );
    chunk[5] = 9;
    expect(deserialized, [9, 2, 3]);
    chunk[5] = 1;

    await call.incoming.close();
    await call.done;
    expect(call.outgoing, hasLength(3));
    validateResponseHeaders(
      headersToMap((call.outgoing.first as HeadersStreamMessage).headers),
    );
    expect(call.responses, [
      [3, 2, 1],
    ]);
    validateResponseTrailers(call.trailers);
    expect(deadline, isNotNull);
  });

  test('passes requests split across DATA frames to the handler', () async {
    var dataReceived = 0;
    final call = _TestCall(
      _server((call, request) => request),
      onDataReceived: _CallbackSink(() => dataReceived++),
    );
    final framed = frame([9, 8, 7, 6, 5]);
    call
      ..sendHeaders()
      ..incoming.add(DataStreamMessage(framed.sublist(0, 2)))
      ..incoming.add(DataStreamMessage(framed.sublist(2, 6)))
      ..incoming.add(DataStreamMessage(framed.sublist(6)));
    await call.incoming.close();
    await call.done;
    expect(call.responses, [
      [9, 8, 7, 6, 5],
    ]);
    // Once for the headers and once for the request.
    expect(dataReceived, 2);
  });

  test('round-trips compressed unary calls and metadata over HTTP/2', () async {
    final codecRegistry = CodecRegistry(
      codecs: const [GzipCodec(), IdentityCodec()],
    );
    final server = Server.create(
      services: [
        _TestService([
          _unary((call, request) async {
            call.headers!['x-header'] = call.clientMetadata!['x-request']!;
            call.trailers!['x-trailer'] = 'trailer';
            return Uint8List.fromList([...await request, 1]);
          }),
        ]),
      ],
      codecRegistry: codecRegistry,
    );
    await server.serve(address: 'localhost', port: 0);
    addTearDown(server.shutdown);
    final channel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry: codecRegistry,
      ),
    );
    addTearDown(channel.shutdown);

    final payload = List.filled(1000, 42);
    final response = _TestClient(channel).unary(
      payload,
      options: CallOptions(
        metadata: {'x-request': 'header'},
        compression: const GzipCodec(),
      ),
    );
    expect(await response, [...payload, 1]);
    final headers = await response.headers;
    expect(headers['grpc-encoding'], 'gzip');
    expect(headers['x-header'], 'header');
    expect(await response.trailers, containsPair('x-trailer', 'trailer'));
  });

  group('unary protocol errors', () {
    test('missing request', () async {
      Object? requestError;
      final call = _TestCall(
        _server(_catchRequestError((e) => requestError = e)),
      );
      call.sendHeaders();
      await call.incoming.close();
      await call.done;
      expect(requestError, GrpcError.unimplemented('No request received'));
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.unimplemented,
        message: 'No request received',
      );
    });

    test('too many requests', () async {
      Object? requestError;
      final call = _TestCall(
        _server(_catchRequestError((e) => requestError = e)),
      );
      call
        ..sendHeaders()
        ..sendRequest([1])
        ..sendRequest([2]);
      await call.incoming.close();
      await call.done;
      expect(requestError, GrpcError.unimplemented('Too many requests'));
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.unimplemented,
        message: 'Too many requests',
      );
    });

    test('request stream closed in the middle of a message', () async {
      Object? requestError;
      var isCanceled = false;
      final call = _TestCall(
        _server((call, request) async {
          try {
            return await request;
          } catch (error) {
            requestError = error;
            isCanceled = call.isCanceled;
            rethrow;
          }
        }),
      );
      call
        ..sendHeaders()
        ..incoming.add(DataStreamMessage([0, 0, 0, 0, 10, 1, 2]));
      await call.incoming.close();
      await call.done;
      expect(call.stream.terminated, isTrue);
      expect(call.outgoing, isEmpty);
      expect(requestError, GrpcError.cancelled('Cancelled'));
      expect(isCanceled, isTrue);
    });

    test('request deserialization error', () async {
      Object? requestError;
      final call = _TestCall(
        _server(
          _catchRequestError((e) => requestError = e),
          deserialize: (_) => throw 'bad request',
        ),
      );
      await call.sendUnary([1]);
      await call.done;
      final error = GrpcError.internal(
        'Error deserializing request: bad request',
      );
      expect(requestError, error);
      validateResponseTrailers(
        call.trailers,
        status: error.code,
        message: error.message,
      );
    });

    test('response serialization error', () async {
      final call = _TestCall(
        _server((call, request) => request, serialize: (_) => throw 'bad'),
      );
      await call.sendUnary([1]);
      await call.done;
      expect(call.outgoing, hasLength(1));
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.internal,
        message: 'Error sending response: bad',
      );
    });

    test(r'$onMetadata throwing', () async {
      final call = _TestCall(
        _server(
          (call, request) => fail('handler called'),
          onMetadata: (_) => throw GrpcError.permissionDenied('denied'),
        ),
      );
      call.sendHeaders();
      await call.done;
      expect(call.stream.terminated, isTrue);
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.permissionDenied,
        message: 'denied',
      );
    });

    test('handler throwing synchronously', () async {
      final call = _TestCall(_server((call, request) => throw 'failed'));
      await call.sendUnary([1]);
      await call.done;
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.unknown,
        message: 'failed',
      );
    });
  });

  test('ignores responses after the call is canceled or timed out', () async {
    final respond = Completer<void>();
    var isCanceled = false;
    final canceled = _TestCall(
      _server((call, request) async {
        final value = await request;
        await respond.future;
        isCanceled = call.isCanceled;
        return value;
      }),
    );
    await canceled.sendUnary([1]);
    canceled.stream.onTerminatedCallback!(ErrorCode.CANCEL);

    final timedOut = _TestCall(
      _server((call, request) async {
        final value = await request;
        await respond.future;
        return value;
      }),
    );
    timedOut.sendHeaders(timeout: const Duration(milliseconds: 1));
    timedOut.sendRequest([1]);
    await timedOut.incoming.close();
    await timedOut.done;

    respond.complete();
    await pumpEventQueue();
    expect(isCanceled, isTrue);
    expect(canceled.outgoing, isEmpty);
    expect(timedOut.outgoing, hasLength(1));
    validateResponseTrailers(
      timedOut.trailers,
      status: StatusCode.deadlineExceeded,
      message: 'Deadline exceeded',
    );
  });

  test('ignores repeated calls to sendTrailers', () async {
    final call = _TestCall(
      _server((call, request) async {
        call.sendTrailers(status: StatusCode.aborted, message: 'aborted');
        call.sendTrailers();
        return request;
      }),
    );
    await call.sendUnary([1]);
    await call.done;
    expect(call.outgoing, hasLength(1));
    validateResponseTrailers(
      call.trailers,
      status: StatusCode.aborted,
      message: 'aborted',
    );
  });

  test('honors ServiceMethod overriding deserialize and serialize', () async {
    final call = _TestCall(
      Server.create(
        services: [
          _TestService([_ReversingMethod((call, request) => request)]),
        ],
      ),
    );
    await call.sendUnary([1, 2]);
    await call.done;
    expect(call.responses, [
      [2, 1, 0],
    ]);
  });

  test('invokes ServerInterceptors for unary calls', () async {
    final passThrough = _PassThroughInterceptor();
    Future<List<List<int>>> echo(List<ServerInterceptor> interceptors) async {
      final call = _TestCall(
        Server.create(
          services: [
            _TestService([_unary((call, request) => request)]),
          ],
          serverInterceptors: interceptors,
        ),
      );
      await call.sendUnary([0]);
      await call.done;
      validateResponseTrailers(call.trailers);
      return call.responses;
    }

    expect(await echo([passThrough]), [
      [0],
    ]);
    expect(passThrough.calls, 1);
    expect(await echo([passThrough, _MappingInterceptor(), passThrough]), [
      [0, 1, 2],
    ]);
    expect(passThrough.calls, 3);
  });

  test(
    'consumes the request stream after an Interceptor rejects a call',
    () async {
      final call = _TestCall(
        Server.create(
          services: [
            _TestService([_unary((call, request) => fail('handler called'))]),
          ],
          interceptors: [
            (call, method) async => GrpcError.permissionDenied('denied'),
          ],
        ),
      );
      call
        ..sendHeaders()
        ..sendRequest([1]);
      unawaited(call.incoming.close());
      await call.done;
      validateResponseTrailers(
        call.trailers,
        status: StatusCode.permissionDenied,
        message: 'denied',
      );
      await pumpEventQueue();
      expect(call.incoming.hasListener, isFalse);
    },
  );

  test('runs streaming calls without interceptors', () async {
    final server = Server.create(
      services: [
        _TestService([
          ServiceMethod<Uint8List, Uint8List>(
            'ServerStreaming',
            (ServiceCall call, Future<Uint8List> request) async* {
              final value = await request;
              yield value;
              yield value;
            },
            false,
            true,
            _asBytes,
            _identity,
          ),
          ServiceMethod<Uint8List, Uint8List>(
            'ClientStreaming',
            (ServiceCall call, Stream<Uint8List> requests) async =>
                Uint8List.fromList(await requests.expand((r) => r).toList()),
            true,
            false,
            _asBytes,
            _identity,
          ),
        ]),
      ],
    );
    final serverStreaming = _TestCall(server)
      ..sendHeaders(method: 'ServerStreaming')
      ..sendRequest([1]);
    final clientStreaming = _TestCall(server)
      ..sendHeaders(method: 'ClientStreaming')
      ..sendRequest([1])
      ..sendRequest([2, 3]);
    await serverStreaming.incoming.close();
    await clientStreaming.incoming.close();
    await serverStreaming.done;
    await clientStreaming.done;
    expect(serverStreaming.responses, [
      [1],
      [1],
    ]);
    expect(clientStreaming.responses, [
      [1, 2, 3],
    ]);
  });
}
