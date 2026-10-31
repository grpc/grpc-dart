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
import 'dart:typed_data';

import '../../shared/message.dart';
import '../../shared/status.dart';
import 'transport.dart';
import 'web_connection.dart';
import 'web_streams.dart';

// gRPC-web over a streamed binary response body. Each body chunk is handed to
// the frame decoder once, as it arrives, so no call re-reads earlier bytes.
//
// For each failure the call reports the GrpcError that the XMLHttpRequest
// transport reports for it. This file has no browser imports, so it runs on
// the VM in tests; browser_fetch.dart supplies the browser request.

/// One HTTP POST whose response body arrives as a stream of byte chunks.
abstract interface class FetchRequest {
  /// Sends the request with [body]. Completes when the response headers
  /// arrive, or with an error when the request fails before any response
  /// (network or CORS failure).
  Future<FetchResponse> send(Uint8List body);

  /// Cancels the request and its response body. Safe at any time, repeatedly.
  void abort();
}

/// The response to a [FetchRequest].
abstract interface class FetchResponse {
  int get status;

  /// Header names in lower case; a repeated header's values joined by ", ".
  Map<String, String> get headers;

  /// The body as Dart-owned bytes, in arrival order. A stream error means the
  /// body failed after the headers arrived. Cancelling the subscription
  /// releases the body.
  Stream<Uint8List> get body;
}

/// Creates the request for [uri] carrying [headers].
typedef FetchRequestFactory =
    FetchRequest Function(
      Uri uri,
      Map<String, String> headers, {
      required bool withCredentials,
    });

class FetchTransportStream implements GrpcTransportStream {
  final FetchRequest _request;
  final ErrorHandler _onError;
  final void Function(FetchTransportStream stream) _onDone;
  bool _sent = false;
  StreamSubscription<Uint8List>? _body;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  FetchTransportStream(
    this._request, {
    required ErrorHandler onError,
    required void Function(FetchTransportStream stream) onDone,
  }) : _onError = onError,
       _onDone = onDone {
    _outgoingMessages.stream
        .map(frame)
        .listen(_send, cancelOnError: true, onError: _onError);

    _incomingProcessor.stream
        .transform(GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(
          _incomingMessages.add,
          onError: _onError,
          onDone: _incomingMessages.close,
        );
  }

  bool get _isClosed => _incomingProcessor.isClosed;

  void _send(List<int> framed) {
    if (_isClosed) {
      return;
    }
    if (_sent) {
      // gRPC-web carries one request message per HTTP request.
      _onError(
        GrpcError.unimplemented('gRPC-web does not support client streaming'),
        StackTrace.current,
      );
      terminate();
      return;
    }
    _sent = true;
    _request
        .send(Uint8List.fromList(framed))
        .then(_onResponse, onError: _onRequestFailed);
  }

  /// Reports a bad [status] or content type through the error handler, before
  /// any body is read, with an empty raw response.
  bool _validateResponseState(int status, Map<String, String> headers) {
    try {
      validateHttpStatusAndContentType(status, headers, rawResponse: '');
      return true;
    } catch (e, st) {
      _onError(e, st);
      return false;
    }
  }

  void _onRequestFailed(Object error, StackTrace stackTrace) {
    if (_isClosed) {
      return;
    }
    // No response at all: an XMLHttpRequest reports status 0 here.
    _validateResponseState(0, const {});
    _close();
  }

  void _onResponse(FetchResponse response) {
    if (_isClosed) {
      return;
    }
    if (!_validateResponseState(response.status, response.headers)) {
      terminate();
      return;
    }
    _incomingMessages.add(GrpcMetadata(response.headers));
    _body = response.body.listen(
      _onChunk,
      onError: _onBodyFailed,
      onDone: _close,
      cancelOnError: true,
    );
  }

  void _onChunk(Uint8List chunk) {
    if (_isClosed) {
      return;
    }
    // The frame decoder reads whole buffers.
    final whole =
        chunk.offsetInBytes == 0 &&
        chunk.lengthInBytes == chunk.buffer.lengthInBytes;
    _incomingProcessor.add(
      whole ? chunk.buffer : Uint8List.fromList(chunk).buffer,
    );
  }

  void _onBodyFailed(Object error, StackTrace stackTrace) {
    if (_isClosed) {
      return;
    }
    // An XMLHttpRequest whose body fails ends with status 0 and no text.
    _onError(
      GrpcError.unavailable('Request failed with status: 0', null, ''),
      stackTrace,
    );
    _close();
  }

  void _close() {
    if (_isClosed) {
      return;
    }
    _body?.cancel();
    _incomingProcessor.close();
    _outgoingMessages.close();
    _onDone(this);
  }

  @override
  Future<void> terminate() async {
    _close();
    _request.abort();
  }
}

class FetchClientConnection extends WebClientConnection<FetchTransportStream> {
  final FetchRequestFactory _createRequest;

  FetchClientConnection(super.uri, this._createRequest);

  @override
  FetchTransportStream createStream(
    Uri requestUri,
    Map<String, String> headers,
    ErrorHandler onError, {
    required bool withCredentials,
    required void Function(FetchTransportStream stream) onDone,
  }) {
    final request = _createRequest(
      requestUri,
      headers,
      withCredentials: withCredentials,
    );
    return FetchTransportStream(request, onError: onError, onDone: onDone);
  }
}
