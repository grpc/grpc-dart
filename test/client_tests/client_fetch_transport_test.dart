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

// The fetch transport driven through a real ClientCall with a fake request:
// framing across chunk boundaries, incremental delivery, trailers, and the
// GrpcError each failure reports. It has no browser imports, so it runs on
// every platform.

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/call.dart' show WebCallOptions;
import 'package:grpc/src/client/transport/fetch_transport.dart';
import 'package:grpc/src/version.dart';
import 'package:test/test.dart';

final _method = ClientMethod<List<int>, List<int>>(
  '/svc.Test/Call',
  (v) => v,
  (v) => v,
);
final _grpcWebHeaders = {'content-type': 'application/grpc-web+proto'};

Uint8List _frame(int type, List<int> payload) => Uint8List.fromList([
  type,
  ...(ByteData(4)..setUint32(0, payload.length)).buffer.asUint8List(),
  ...payload,
]);

Uint8List _data(List<int> message) => _frame(0x00, message);

Uint8List _trailers(String block) => _frame(0x80, ascii.encode(block));

final _okTrailers = _trailers(
  'grpc-status:0\r\ngrpc-message:\r\nx-trailer:t\r\n',
);

class _FakeResponse implements FetchResponse {
  _FakeResponse(this.status, this.headers);

  @override
  final int status;
  @override
  final Map<String, String> headers;
  // Tests close it to end the body, or leave it open.
  // ignore: close_sinks
  final chunks = StreamController<Uint8List>();
  var bodyCancelled = false;

  @override
  Stream<Uint8List> get body {
    chunks.onCancel = () => bodyCancelled = true;
    return chunks.stream;
  }
}

class _FakeRequest implements FetchRequest {
  _FakeRequest(this.uri, this.headers, {required this.withCredentials});

  final Uri uri;
  final Map<String, String> headers;
  final bool withCredentials;
  final sent = <Uint8List>[];
  final _response = Completer<FetchResponse>();
  var aborts = 0;

  @override
  Future<FetchResponse> send(Uint8List body) {
    sent.add(body);
    return _response.future;
  }

  @override
  void abort() => aborts++;

  _FakeResponse respond({int status = 200, Map<String, String>? headers}) {
    final response = _FakeResponse(status, headers ?? _grpcWebHeaders);
    _response.complete(response);
    return response;
  }

  void fail() => _response.completeError(StateError('network down'));
}

class _Harness {
  final requests = <_FakeRequest>[];
  late final connection = FetchClientConnection(
    Uri.parse('https://query.example.test/base/'),
    (uri, headers, {required withCredentials}) {
      final request = _FakeRequest(
        uri,
        Map.of(headers),
        withCredentials: withCredentials,
      );
      requests.add(request);
      return request;
    },
  );

  /// Starts a call and waits until its request body is sent.
  Future<(ClientCall<List<int>, List<int>>, _FakeRequest)> start({
    CallOptions? options,
    List<int> request = const [1, 2, 3],
  }) async {
    final call = ClientCall(
      _method,
      Stream.value(request),
      options ?? CallOptions(),
    );
    connection.dispatchCall(call);
    await pumpEventQueue();
    return (call, requests.last);
  }
}

/// Collects a call's messages and its terminal error.
class _Outcome {
  _Outcome(ClientCall<List<int>, List<int>> call) {
    call.response.listen(
      messages.add,
      onError: (Object e) => error = e,
      onDone: done.complete,
    );
  }

  final messages = <List<int>>[];
  Object? error;
  final done = Completer<void>();

  GrpcError get grpcError => error! as GrpcError;
}

void main() {
  late _Harness harness;

  setUp(() => harness = _Harness());

  test('sends one framed POST body with the gRPC-web headers', () async {
    final (_, request) = await harness.start(
      options: WebCallOptions(
        metadata: {'Authorization': 'Bearer x'},
        withCredentials: true,
      ),
    );
    expect(request.uri.toString(), 'https://query.example.test/svc.Test/Call');
    expect(request.sent, [
      [0, 0, 0, 0, 3, 1, 2, 3],
    ]);
    expect(request.headers, {
      'authorization': 'Bearer x',
      'Content-Type': 'application/grpc-web+proto',
      'X-User-Agent': 'grpc-web-dart/$packageVersion',
      'X-Grpc-Web': '1',
    });
    expect(request.withCredentials, isTrue);
  });

  test(
    'moves headers into the query when bypassing the CORS preflight',
    () async {
      final (_, request) = await harness.start(
        options: WebCallOptions(bypassCorsPreflight: true),
      );
      expect(request.headers, isEmpty);
      expect(
        request.uri.queryParameters[r'$httpHeaders'],
        'Content-Type:application/grpc-web+proto\r\nX-User-Agent:grpc-web-dart/$packageVersion\r\nX-Grpc-Web:1\r\n',
      );
      expect(request.withCredentials, isFalse);
    },
  );

  test(
    'reassembles frames split at every byte, with headers and trailers',
    () async {
      final (call, request) = await harness.start();
      final outcome = _Outcome(call);
      final response = request.respond(
        headers: {..._grpcWebHeaders, 'x-header': 'h'},
      );
      final message = List<int>.generate(300, (i) => i % 251);
      for (final byte in [..._data(message), ..._okTrailers]) {
        response.chunks.add(Uint8List.fromList([byte]));
      }
      await response.chunks.close();
      await outcome.done.future;

      expect(outcome.error, isNull);
      expect(outcome.messages, [message]);
      expect(await call.headers, containsPair('x-header', 'h'));
      expect(await call.trailers, {
        'grpc-status': '0',
        'grpc-message': '',
        'x-trailer': 't',
      });
    },
  );

  test('reads a chunk that is a view into a larger buffer', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    final bytes = [
      ..._data([7, 8, 9]),
      ..._okTrailers,
    ];
    final backing = Uint8List(bytes.length + 20)
      ..setRange(10, 10 + bytes.length, bytes);
    response.chunks.add(Uint8List.sublistView(backing, 10, 10 + bytes.length));
    await response.chunks.close();
    await outcome.done.future;

    expect(outcome.error, isNull);
    expect(outcome.messages, [
      [7, 8, 9],
    ]);
  });

  test('delivers each streamed message when its chunk arrives', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(_data([1]));
    await pumpEventQueue();
    expect(outcome.messages, [
      [1],
    ]);

    response.chunks.add(_data([2]));
    await pumpEventQueue();
    expect(outcome.messages, [
      [1],
      [2],
    ]);

    response.chunks.add(_okTrailers);
    await response.chunks.close();
    await outcome.done.future;
    expect(outcome.error, isNull);
  });

  test('a trailer status fails the call with its code and message', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(
      _trailers('grpc-status:7\r\ngrpc-message:no%20access\r\n'),
    );
    await response.chunks.close();
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.permissionDenied);
    expect(outcome.grpcError.message, 'no access');
  });

  test(
    'a trailers-only response reports the status carried in its headers',
    () async {
      final (call, request) = await harness.start();
      final outcome = _Outcome(call);
      final response = request.respond(
        headers: {
          ..._grpcWebHeaders,
          'grpc-status': '16',
          'grpc-message': 'expired',
        },
      );
      await response.chunks.close();
      await outcome.done.future;

      expect(outcome.grpcError.code, StatusCode.unauthenticated);
      expect(outcome.grpcError.message, 'expired');
    },
  );

  test(
    'an HTTP error status fails before the body and aborts the request',
    () async {
      final (call, request) = await harness.start();
      final outcome = _Outcome(call);
      final response = request.respond(
        status: 401,
        headers: {'content-type': 'text/plain'},
      );
      await outcome.done.future;

      expect(outcome.grpcError.code, StatusCode.unauthenticated);
      expect(
        outcome.grpcError.message,
        'HTTP connection completed with 401 instead of 200',
      );
      expect(outcome.grpcError.rawResponse, '');
      expect(request.aborts, greaterThan(0));
      expect(response.chunks.hasListener, isFalse);
    },
  );

  test('an unsupported content type is an unknown error', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    request.respond(headers: {'content-type': 'text/html'});
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.unknown);
    expect(outcome.grpcError.message, 'unsupported content-type (text/html)');
  });

  test('a request that gets no response reports a missing status', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    request.fail();
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.unknown);
    expect(
      outcome.grpcError.message,
      'HTTP request completed without a status (potential CORS issue)',
    );
  });

  test('a body that fails after the headers is unavailable', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(_data([1]).sublist(0, 4));
    response.chunks.addError(StateError('connection reset'));
    await outcome.done.future;

    expect(outcome.messages, isEmpty);
    expect(outcome.grpcError.code, StatusCode.unavailable);
    expect(outcome.grpcError.message, 'Request failed with status: 0');
  });

  test('a body that ends inside a frame is unavailable', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(_data([1, 2, 3]).sublist(0, 6));
    await response.chunks.close();
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.unavailable);
    expect(outcome.grpcError.message, 'Closed in non-idle state');
  });

  test('an unknown frame type is unimplemented', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(_frame(0x01, [1]));
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.unimplemented);
    expect(outcome.grpcError.message, 'Invalid frame type: 1');
  });

  test('cancelling aborts the request and releases the body', () async {
    final (call, request) = await harness.start();
    final outcome = _Outcome(call);
    final response = request.respond();
    response.chunks.add(_data([1]));
    await pumpEventQueue();
    await call.cancel();
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.cancelled);
    expect(request.aborts, greaterThan(0));
    expect(response.bodyCancelled, isTrue);
  });

  test('a deadline aborts a request still waiting for its response', () async {
    final (call, request) = await harness.start(
      options: CallOptions(timeout: const Duration(milliseconds: 20)),
    );
    final outcome = _Outcome(call);
    await outcome.done.future;

    expect(outcome.grpcError.code, StatusCode.deadlineExceeded);
    expect(request.aborts, greaterThan(0));
    // A response arriving after the abort is ignored.
    request.respond().chunks.add(_data([1]));
    await pumpEventQueue();
    expect(outcome.messages, isEmpty);
  });

  test('terminating the connection aborts every open request', () async {
    final (first, firstRequest) = await harness.start();
    final (second, secondRequest) = await harness.start();
    final outcomes = [_Outcome(first), _Outcome(second)];
    await harness.connection.terminate();
    await pumpEventQueue();

    expect(firstRequest.aborts, greaterThan(0));
    expect(secondRequest.aborts, greaterThan(0));
    for (final outcome in outcomes) {
      expect(outcome.grpcError.code, StatusCode.unavailable);
    }
  });
}
