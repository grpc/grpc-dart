// Copyright (c) 2022, the gRPC project authors. Please see the AUTHORS file
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
import 'dart:convert';
import 'dart:html';
import 'dart:js_util' as js_util;
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:meta/meta.dart';

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';
import 'web_streams.dart';

const _contentTypeKey = 'Content-Type';

/// Implementation of Fetch API simulating @HttpRequest for minimal changes
class FetchHttpRequest {
  // Request parameters
  var method = 'GET';
  var uri = '';
  var referrerPolicy = 'origin';
  var mode = 'cors';
  var credentials = 'omit';
  var cache = 'default';
  var redirect = 'follow';
  var integrity = '';
  var keepAlive = true;
  var headers = <String, String>{};
  var readyState = HttpRequest.UNSENT;
  set withCredentials(bool value) => credentials = value ? 'include' : 'omit';
  set responseType(String unused) {}

  // Streams and controllers
  final onReadyStateChangeController = StreamController<int>.broadcast();
  Stream<int> get onReadyStateChange => onReadyStateChangeController.stream;
  final onProgressController = StreamController<Uint8List>.broadcast();
  Stream<Uint8List> get onProgress => onProgressController.stream;
  final onErrorController = StreamController<int>.broadcast();
  Stream<int> get onError => onErrorController.stream;

  // Response information
  CancelableOperation<dynamic>? _cancelable;
  dynamic _response;
  dynamic get response => _response;
  int get status =>
      response != null ? js_util.getProperty(response, 'status') : 0;
  Map<String, String> get responseHeaders => response != null
      ? toDartMap(js_util.getProperty(response, 'headers'))
      : <String, String>{};
  String get responseText =>
      response != null ? js_util.getProperty(response, 'statusText') : '';
  dynamic get body =>
      response != null ? js_util.getProperty(response, 'body') : null;

  static Map<String, String> toDartMap(Headers obj) =>
      Map.fromIterable(getObjectKeys(obj),
          value: (key) => js_util.callMethod(obj, 'get', [key]).toString());

  static List<String> getObjectKeys(Headers obj) =>
      List<String>.from(js_util.callMethod(obj, 'keys', []));

  Future send([List<int>? data]) async {
    final wgs = WorkerGlobalScope.instance;
    _setReadyState(HttpRequest.LOADING);
    final headersStr =
        headers.isNotEmpty ? '"headers": ${json.encode(headers)},' : '';
    final bodyStr = data != null ? '"body": Uint8Array.from($data),' : '';
    final initStr = '''{
      $headersStr
      $bodyStr
      "method": "$method",
      "referrerPolicy": "$referrerPolicy",
      "mode": "$mode",
      "credentials": "$credentials",
      "cache": "$cache",
      "redirect": "$redirect",
      "integrity": "$integrity",
      "keepalive": $keepAlive
    }''';

    final promise = js_util.promiseToFuture(
        js_util.callMethod(wgs, 'eval', ['fetch("$uri", $initStr)']));
    final operation = _cancelable = CancelableOperation.fromFuture(promise);

    _response = await operation.value;
    _setReadyState(HttpRequest.HEADERS_RECEIVED);
    if (status < 200 || status >= 300) {
      onErrorController.add(status);
    }

    final reader = body?.getReader();
    if (reader == null) {
      onErrorController.add(0);
      return;
    }

    while (true) {
      final result = await js_util.promiseToFuture(reader.read());
      final value = js_util.getProperty(result, 'value');
      if (value != null) {
        onProgressController.add(value as Uint8List);
      }
      if (js_util.getProperty(result, 'done')) {
        _setReadyState(HttpRequest.DONE);
        break;
      }
    }
  }

  void _setReadyState(int state) {
    readyState = state;
    onReadyStateChangeController.add(state);
    if (state == HttpRequest.DONE) {}
  }

  void open(String method, String uri) {
    this.method = method;
    this.uri = uri;
    _setReadyState(HttpRequest.OPENED);
  }

  void abort() async {
    await _cancelable?.cancel();
    close();
  }

  void close() {
    onReadyStateChangeController.close();
    onProgressController.close();
    onErrorController.close();
  }

  void setRequestHeader(String name, String value) {
    headers[name] = value;
  }

  void overrideMimeType(String mimeType) {}
}

class FetchTransportStream implements GrpcTransportStream {
  final FetchHttpRequest _request;
  final ErrorHandler _onError;
  final Function(FetchTransportStream stream) _onDone;
  bool _headersReceived = false;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  FetchTransportStream(this._request,
      {required ErrorHandler onError, required onDone})
      : _onError = onError,
        _onDone = onDone {
    _outgoingMessages.stream
        .map(frame)
        .listen((data) => _request.send(data), cancelOnError: true);

    _request.onReadyStateChange.listen((data) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      switch (_request.readyState) {
        case HttpRequest.HEADERS_RECEIVED:
          _onHeadersReceived();
          break;
        case HttpRequest.DONE:
          _onRequestDone();
          _close();
          break;
      }
    });

    _request.onError.listen((_) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      _onError(GrpcError.unavailable('FetchTransportStream connection-error'),
          StackTrace.current);
      terminate();
    });

    _request.onProgress.listen((bytes) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      _incomingProcessor.add(bytes.buffer);
    });

    _incomingProcessor.stream
        .transform(GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(_incomingMessages.add,
            onError: _onError, onDone: _incomingMessages.close);
  }

  bool _validateResponseState() {
    try {
      validateHttpStatusAndContentType(
          _request.status, _request.responseHeaders,
          rawResponse: _request.responseText);
      return true;
    } catch (e, st) {
      _onError(e, st);
      return false;
    }
  }

  void _onHeadersReceived() {
    _headersReceived = true;
    if (!_validateResponseState()) {
      return;
    }
    _incomingMessages.add(GrpcMetadata(_request.responseHeaders));
  }

  void _onRequestDone() {
    if (!_headersReceived && !_validateResponseState()) {
      return;
    }
    if (_request.response == null) {
      _onError(
          GrpcError.unavailable('FetchTransportStream request null response',
              null, _request.responseText),
          StackTrace.current);
      return;
    }
  }

  void _close() {
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

class FetchClientConnection extends ClientConnection {
  final Uri uri;

  final _requests = <FetchTransportStream>{};

  FetchClientConnection(this.uri);

  @override
  String get authority => uri.authority;
  @override
  String get scheme => uri.scheme;

  void _initializeRequest(
      FetchHttpRequest request, Map<String, String> metadata) {
    for (final header in metadata.keys) {
      request.setRequestHeader(header, metadata[header]!);
    }
    // Overriding the mimetype allows us to stream and parse the data
    request.overrideMimeType('text/plain; charset=x-user-defined');
    request.responseType = 'text';
  }

  @visibleForTesting
  FetchHttpRequest createRequest() => FetchHttpRequest();

  @override
  GrpcTransportStream makeRequest(String path, Duration? timeout,
      Map<String, String> metadata, ErrorHandler onError,
      {CallOptions? callOptions}) {
    // gRPC-web headers.
    if (_getContentTypeHeader(metadata) == null) {
      metadata['Content-Type'] = 'application/grpc-web+proto';
      metadata['X-User-Agent'] = 'grpc-web-dart/0.1';
      metadata['X-Grpc-Web'] = '1';
    }

    var requestUri = uri.resolve(path);
    if (callOptions is WebCallOptions &&
        callOptions.bypassCorsPreflight == true) {
      requestUri = cors.moveHttpHeadersToQueryParam(metadata, requestUri);
    }

    final request = createRequest();
    request.open('POST', requestUri.toString());
    if (callOptions is WebCallOptions && callOptions.withCredentials == true) {
      request.withCredentials = true;
    }
    // Must set headers after calling open().
    _initializeRequest(request, metadata);

    final transportStream =
        FetchTransportStream(request, onError: onError, onDone: _removeStream);
    _requests.add(transportStream);
    return transportStream;
  }

  void _removeStream(FetchTransportStream stream) {
    _requests.remove(stream);
  }

  @override
  Future<void> terminate() async {
    for (var request in List.of(_requests)) {
      request.terminate();
    }
  }

  @override
  void dispatchCall(ClientCall call) {
    call.onConnectionReady(this);
  }

  @override
  Future<void> shutdown() async {}
}

MapEntry<String, String>? _getContentTypeHeader(Map<String, String> metadata) {
  for (var entry in metadata.entries) {
    if (entry.key.toLowerCase() == _contentTypeKey.toLowerCase()) {
      return entry;
    }
  }
  return null;
}
