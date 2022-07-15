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
import 'package:js/js.dart';
import 'package:meta/meta.dart';

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';
import 'web_streams.dart';

const _contentTypeKey = 'Content-Type';

@JS()
class AbortSignal {
  external factory AbortSignal();
  external bool get aborted;
}

@JS()
class AbortController {
  external factory AbortController();
  external void abort([dynamic reason]);
  external AbortSignal get signal;
}

@anonymous
// ignore: missing_js_lib_annotation
@JS()
class RequestInit {
  external factory RequestInit(
      {required String method,
      Object? headers,
      List<int>? body,
      AbortSignal? signal,
      required String referrerPolicy,
      required String mode,
      required String credentials,
      required String cache,
      required String redirect,
      required String integrity,
      required bool keepalive});

  external String get method;
  external set method(String newValue);

  external Object? get headers;
  external set headers(Object? newValue);

  external Uint8List? get body;
  external set body(Uint8List? newValue);

  external AbortSignal? get signal;
  external set signal(AbortSignal? newValue);

  external String get referrerPolicy;
  external set referrerPolicy(String newValue);

  external String get mode;
  external set mode(String newValue);

  external String get credentials;
  external set credentials(String newValue);

  external String get cache;
  external set cache(String newValue);

  external String get redirect;
  external set redirect(String newValue);

  external String get integrity;
  external set integrity(String newValue);

  external bool get keepalive;
  external set keepalive(bool newValue);
}

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
  AbortController? _abortController;
  CancelableOperation<dynamic>? _cancelableSend;
  dynamic _response;
  Uint8List? _lastResponse;
  String? get response => responseText;
  int get status =>
      _response != null ? js_util.getProperty(_response, 'status') : 0;
  Map<String, String> get responseHeaders => _response != null
      ? toDartMap(js_util.getProperty(_response, 'headers'))
      : <String, String>{};
  String? get responseText => _lastResponse != null
      ? utf8.decode(_lastResponse!, allowMalformed: true)
      : null;
  dynamic get body =>
      _response != null ? js_util.getProperty(_response, 'body') : null;

  static Map<String, String> toDartMap(Headers obj) =>
      Map.fromIterable(getObjectKeys(obj),
          value: (key) => js_util.callMethod(obj, 'get', [key]).toString());

  static List<String> getObjectKeys(Headers obj) {
    final keys = js_util.callMethod(obj, 'keys', []);
    // This used to work prior to flutter 3.0 now we type check to see if supported
    if (keys is Iterable) {
      return List<String>.from(keys);
    }

    // Otherwise we have to fall back and manually iterate through the javascript iterator
    final res = List<String>.empty(growable: true);
    while (true) {
      final next = js_util.callMethod(keys, 'next', []);
      if (js_util.getProperty(next, 'done')) {
        break;
      }
      res.add(js_util.getProperty(next, 'value').toString());
    }
    return res;
  }

  Future send([List<int>? data]) async {
    final doSend = _doSend(data);
    _cancelableSend = CancelableOperation.fromFuture(doSend);
    await doSend;
  }

  Future _doSend([List<int>? data]) async {
    final wgs = WorkerGlobalScope.instance;
    _setReadyState(HttpRequest.LOADING);

    _abortController = AbortController();
    final init = RequestInit(
        cache: cache,
        credentials: credentials,
        integrity: integrity,
        keepalive: keepAlive,
        method: method,
        mode: mode,
        redirect: redirect,
        referrerPolicy: referrerPolicy,
        signal: _abortController?.signal,
        body: data,
        headers: js_util.jsify(headers));

    _response = await js_util
        .promiseToFuture(js_util.callMethod(wgs, 'fetch', [uri, init]))
        .onError((error, stackTrace) => null,
            test: (error) => _abortController?.signal.aborted ?? false);
    if (_response == null || (_cancelableSend?.isCanceled ?? false)) {
      return;
    }

    _setReadyState(HttpRequest.HEADERS_RECEIVED);
    if (status < 200 || status >= 300) {
      onErrorController.add(status);
    }

    final stream = body;
    final reader =
        stream != null ? js_util.callMethod(stream, 'getReader', []) : null;
    if (reader == null) {
      onErrorController.add(0);
      return;
    }

    while (true) {
      final result = await js_util
          .promiseToFuture(js_util.callMethod(reader, 'read', []))
          .onError((error, stackTrace) => null,
              test: (error) => _abortController?.signal.aborted ?? false);
      if (result == null || (_cancelableSend?.isCanceled ?? false)) {
        return;
      }
      final value = js_util.getProperty(result, 'value');
      if (value != null) {
        _lastResponse = value;
        onProgressController.add(value as Uint8List);
      }
      if (js_util.getProperty(result, 'done')) {
        _lastResponse ??= Uint8List(0);
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
    _abortController?.abort();
    await _cancelableSend?.cancel();
    close();
  }

  void close() {
    onReadyStateChangeController.close();
    onProgressController.close();
    onErrorController.close();
    _response = null;
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
