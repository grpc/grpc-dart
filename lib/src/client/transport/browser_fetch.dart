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

import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart';

import 'fetch_transport.dart';

/// A [FetchRequest] made with the browser's `fetch`, reading the response
/// body through its stream reader.
class BrowserFetchRequest implements FetchRequest {
  final String _url;
  final Headers _headers = Headers();
  final bool _withCredentials;
  final AbortController _abort = AbortController();

  /// Throws, as `XMLHttpRequest.setRequestHeader` does, on a header name or
  /// value the browser rejects.
  BrowserFetchRequest(
    Uri uri,
    Map<String, String> headers, {
    required bool withCredentials,
  }) : _url = uri.toString(),
       _withCredentials = withCredentials {
    headers.forEach((name, value) => _headers.append(name, value));
  }

  @override
  Future<FetchResponse> send(Uint8List body) async {
    final response = await window
        .fetch(
          _url.toJS,
          RequestInit(
            method: 'POST',
            headers: _headers,
            body: body.toJS,
            // The cookie behavior of XMLHttpRequest.withCredentials.
            credentials: _withCredentials ? 'include' : 'same-origin',
            signal: _abort.signal,
          ),
        )
        .toDart;
    return _BrowserFetchResponse(response);
  }

  @override
  void abort() => _abort.abort();
}

class _BrowserFetchResponse implements FetchResponse {
  final Response _response;

  _BrowserFetchResponse(this._response);

  @override
  int get status => _response.status;

  @override
  Map<String, String> get headers {
    final headers = <String, String>{};
    _response.headers.forEach(
      ((JSString value, JSString name) {
        headers[name.toDart] = value.toDart;
      }).toJS,
    );
    return headers;
  }

  @override
  Stream<Uint8List> get body {
    final body = _response.body;
    if (body == null) {
      return const Stream.empty();
    }
    final reader = body.getReader() as ReadableStreamDefaultReader;
    var cancelled = false;
    late final StreamController<Uint8List> controller;

    Future<void> pump() async {
      try {
        while (true) {
          final result = await reader.read().toDart;
          if (cancelled) {
            return;
          }
          if (result.done) {
            break;
          }
          // One copy into Dart-owned bytes. Under dart2wasm a JS-backed list
          // would cross the JS boundary on every later read of it.
          controller.add(
            Uint8List.fromList((result.value as JSUint8Array).toDart),
          );
        }
      } catch (e, st) {
        if (!cancelled) {
          controller.addError(e, st);
        }
      }
      if (!cancelled) {
        await controller.close();
      }
    }

    controller = StreamController<Uint8List>(
      onListen: pump,
      onCancel: () {
        cancelled = true;
        // Rejects when the request was aborted first; nothing to report.
        reader.cancel().toDart.ignore();
      },
    );
    return controller.stream;
  }
}

extension on Headers {
  // PROVENANCE: DOCUMENTED https://fetch.spec.whatwg.org/#headers-class
  // (pair iterable: forEach calls back with value, then name; iteration
  // yields lower-case names with repeated values combined by ", ")
  // (checked 2026-10-29).
  external void forEach(JSFunction callback);
}
