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

@TestOn('browser')
library;

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:grpc/grpc.dart' show Client, ClientMethod;
import 'package:grpc/grpc_web.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

// The fetch transport's browser request against a stand-in `fetch`: request
// shape, a body streamed in chunks that split frames, response headers,
// cancellation and a failed request.

final _method = ClientMethod<List<int>, List<int>>(
  '/svc.Test/Call',
  (v) => v,
  (v) => v,
);

class _TestClient extends Client {
  _TestClient(super.channel);

  ResponseFuture<List<int>> call(List<int> request, {CallOptions? options}) =>
      $createUnaryCall(_method, request, options: options);
}

Uint8List _frame(int type, List<int> payload) => Uint8List.fromList([
  type,
  ...(ByteData(4)..setUint32(0, payload.length)).buffer.asUint8List(),
  ...payload,
]);

/// What the stand-in `fetch` saw.
class _Seen {
  late String url;
  late web.RequestInit init;
  late Uint8List body;
  var sourceCancelled = false;
}

/// Replaces the global `fetch` for one test. [respond] builds the response
/// from the request; returning null makes the request fail as a network error
/// does.
_Seen _stubFetch(web.Response? Function(_Seen seen, JSObject source) respond) {
  final seen = _Seen();
  final original = web.window.getProperty<JSFunction>('fetch'.toJS);
  addTearDown(() => web.window.setProperty('fetch'.toJS, original));
  web.window.setProperty(
    'fetch'.toJS,
    ((JSString url, web.RequestInit init) {
      seen
        ..url = url.toDart
        ..init = init
        ..body = (init.body as JSUint8Array).toDart;
      final source = JSObject()
        ..setProperty(
          'cancel'.toJS,
          ((JSAny? _) => seen.sourceCancelled = true).toJS,
        );
      final response = respond(seen, source);
      return response == null
          ? Future<web.Response>.error(StateError('network down')).toJS
          : Future.value(response).toJS;
    }).toJS,
  );
  return seen;
}

/// A streamed response body that delivers [chunks] and then closes, or stays
/// open when [close] is false.
web.Response _streamed(
  JSObject source,
  List<List<int>> chunks, {
  bool close = true,
  Map<String, List<String>> headers = const {},
}) {
  source.setProperty(
    'start'.toJS,
    ((web.ReadableStreamDefaultController controller) {
      for (final chunk in chunks) {
        controller.enqueue(Uint8List.fromList(chunk).toJS);
      }
      if (close) controller.close();
    }).toJS,
  );
  final responseHeaders = web.Headers()
    ..append('content-type', 'application/grpc-web+proto');
  for (final MapEntry(key: name, value: values) in headers.entries) {
    for (final value in values) {
      responseHeaders.append(name, value);
    }
  }
  return web.Response(
    web.ReadableStream(source),
    web.ResponseInit(status: 200, headers: responseHeaders),
  );
}

void main() {
  late GrpcWebClientChannel channel;
  late _TestClient client;

  setUp(() {
    channel = GrpcWebClientChannel(
      Uri.parse('https://query.example.test/'),
      transport: GrpcWebTransport.fetch,
    );
    client = _TestClient(channel);
  });

  tearDown(() => channel.shutdown());

  test('posts one framed message and decodes a chunked response', () async {
    final message = List<int>.generate(70000, (i) => i % 253);
    final trailers = ascii.encode('grpc-status:0\r\nx-trailer:t\r\n');
    final body = [..._frame(0, message), ..._frame(0x80, trailers)];
    final seen = _stubFetch(
      (seen, source) => _streamed(
        source,
        [body.sublist(0, 3), body.sublist(3, 40000), body.sublist(40000)],
        headers: {
          'x-repeated': ['a', 'b'],
        },
      ),
    );

    final call = client.call(
      [1, 2, 3],
      options: WebCallOptions(
        metadata: {'authorization': 'Bearer x'},
        withCredentials: true,
      ),
    );
    expect(await call, message);
    expect(await call.headers, containsPair('x-repeated', 'a, b'));
    expect(await call.trailers, {'grpc-status': '0', 'x-trailer': 't'});

    expect(seen.url, 'https://query.example.test/svc.Test/Call');
    expect(seen.init.method, 'POST');
    expect(seen.init.credentials, 'include');
    expect(seen.body, [0, 0, 0, 0, 3, 1, 2, 3]);
    final sentHeaders = seen.init.headers as web.Headers;
    expect(sentHeaders.get('authorization'), 'Bearer x');
    expect(sentHeaders.get('content-type'), 'application/grpc-web+proto');
    expect(sentHeaders.get('x-grpc-web'), '1');
  });

  test('cancelling a call aborts the fetch and its body', () async {
    final seen = _stubFetch(
      (seen, source) => _streamed(source, [
        _frame(0, [1]).sublist(0, 2),
      ], close: false),
    );
    final call = client.call([1]);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await call.cancel();
    await expectLater(
      call,
      throwsA(
        isA<GrpcError>().having((e) => e.code, 'code', StatusCode.cancelled),
      ),
    );
    expect(seen.init.signal!.aborted, isTrue);
    expect(seen.sourceCancelled, isTrue);
    expect(seen.init.credentials, 'same-origin');
  });

  test('a failed request reports a missing status', () async {
    _stubFetch((seen, source) => null);
    await expectLater(
      client.call([1]),
      throwsA(
        isA<GrpcError>()
            .having((e) => e.code, 'code', StatusCode.unknown)
            .having(
              (e) => e.message,
              'message',
              'HTTP request completed without a status (potential CORS issue)',
            ),
      ),
    );
  });
}
