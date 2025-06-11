// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
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

import 'package:meta/meta.dart';
import 'package:web/web.dart';

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';
import 'web_streams.dart';

const _contentTypeKey = 'Content-Type';

class XhrTransportStream implements GrpcTransportStream {
  final IXMLHttpRequest _request;
  final ErrorHandler _onError;
  final Function(XhrTransportStream stream) _onDone;
  bool _headersReceived = false;
  int _requestBytesRead = 0;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  XhrTransportStream(
    this._request, {
    required ErrorHandler onError,
    required onDone,
  }) : _onError = onError,
       _onDone = onDone {
    _outgoingMessages.stream
        .map(frame)
        .listen(
          (data) => _request.send(Uint8List.fromList(data).toJS),
          cancelOnError: true,
          onError: _onError,
        );

    _request.onReadyStateChange.listen((_) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      switch (_request.readyState) {
        case XMLHttpRequest.HEADERS_RECEIVED:
          _onHeadersReceived();
          break;
        case XMLHttpRequest.DONE:
          _onRequestDone();
          _close();
          break;
      }
    });

    _request.onError.listen((ProgressEvent event) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      _onError(
        GrpcError.unavailable('XhrConnection connection-error'),
        StackTrace.current,
      );
      terminate();
    });

    _request.onProgress.listen((_) {
      if (_incomingProcessor.isClosed) {
        return;
      }
      final responseText = _request.responseText;
      final bytes = Uint8List.fromList(
        responseText.substring(_requestBytesRead).codeUnits,
      ).buffer;
      _requestBytesRead = responseText.length;
      _incomingProcessor.add(bytes);
    });

    _incomingProcessor.stream
        .transform(GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(
          _incomingMessages.add,
          onError: _onError,
          onDone: _incomingMessages.close,
        );
  }

  bool _validateResponseState() {
    try {
      validateHttpStatusAndContentType(
        _request.status,
        _request.responseHeaders,
        rawResponse: _request.responseText,
      );
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
    if (_request.status != 200) {
      _onError(
        GrpcError.unavailable(
          'Request failed with status: ${_request.status}',
          null,
          _request.responseText,
        ),
        StackTrace.current,
      );
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

// XMLHttpRequest is an extension type and can't be extended or implemented.
// This interface is used to allow for mocking XMLHttpRequest in tests of
// XhrClientConnection.
@visibleForTesting
abstract interface class IXMLHttpRequest {
  Stream<Event> get onReadyStateChange;
  Stream<ProgressEvent> get onProgress;
  Stream<ProgressEvent> get onError;
  int get readyState;
  JSAny? get response;
  String get responseText;
  Map<String, String> get responseHeaders;
  int get status;

  set responseType(String responseType);
  set withCredentials(bool withCredentials);

  void abort();
  void open(
    String method,
    String url, [
    // external default is true
    bool async = true,
    String? username,
    String? password,
  ]);
  void overrideMimeType(String mimeType);
  void send([JSAny? body]);
  void setRequestHeader(String header, String value);

  // This method should only be used in production code.
  XMLHttpRequest toXMLHttpRequest();
}

// IXMLHttpRequest that delegates to a real XMLHttpRequest.
class XMLHttpRequestImpl implements IXMLHttpRequest {
  final XMLHttpRequest _xhr = XMLHttpRequest();

  XMLHttpRequestImpl();

  @override
  Stream<Event> get onReadyStateChange => _xhr.onReadyStateChange;
  @override
  Stream<ProgressEvent> get onProgress => _xhr.onProgress;
  @override
  Stream<ProgressEvent> get onError => _xhr.onError;
  @override
  int get readyState => _xhr.readyState;
  @override
  Map<String, String> get responseHeaders => _xhr.responseHeaders;
  @override
  JSAny? get response => _xhr.response;
  @override
  String get responseText => _xhr.responseText;
  @override
  int get status => _xhr.status;

  @override
  set responseType(String responseType) {
    _xhr.responseType = responseType;
  }

  @override
  set withCredentials(bool withCredentials) {
    _xhr.withCredentials = withCredentials;
  }

  @override
  void abort() {
    _xhr.abort();
  }

  @override
  void open(
    String method,
    String url, [
    bool async = true,
    String? username,
    String? password,
  ]) {
    _xhr.open(method, url, async, username, password);
  }

  @override
  void overrideMimeType(String mimeType) {
    _xhr.overrideMimeType(mimeType);
  }

  @override
  void setRequestHeader(String header, String value) {
    _xhr.setRequestHeader(header, value);
  }

  @override
  void send([JSAny? body]) {
    _xhr.send(body);
  }

  @override
  XMLHttpRequest toXMLHttpRequest() {
    return _xhr;
  }
}

class XhrClientConnection implements ClientConnection {
  final Uri uri;

  final _requests = <XhrTransportStream>{};

  XhrClientConnection(this.uri);

  @override
  String get authority => uri.authority;

  @override
  String get scheme => uri.scheme;

  void _initializeRequest(
    IXMLHttpRequest request,
    Map<String, String> metadata,
  ) {
    metadata.forEach(request.setRequestHeader);
    // Overriding the mimetype allows us to stream and parse the data
    request.overrideMimeType('text/plain; charset=x-user-defined');
    request.responseType = 'text';
  }

  @visibleForTesting
  IXMLHttpRequest createHttpRequest() => XMLHttpRequestImpl();

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onError, {
    CallOptions? callOptions,
  }) {
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

    final request = createHttpRequest();
    request.open('POST', requestUri.toString());
    if (callOptions is WebCallOptions && callOptions.withCredentials == true) {
      request.withCredentials = true;
    }
    // Must set headers after calling open().
    _initializeRequest(request, metadata);

    final transportStream = _createXhrTransportStream(
      request,
      onError,
      _removeStream,
    );
    _requests.add(transportStream);
    return transportStream;
  }

  XhrTransportStream _createXhrTransportStream(
    IXMLHttpRequest request,
    ErrorHandler onError,
    void Function(XhrTransportStream stream) onDone,
  ) {
    return XhrTransportStream(request, onError: onError, onDone: onDone);
  }

  void _removeStream(XhrTransportStream stream) {
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

  @override
  set onStateChanged(void Function(ConnectionState) cb) {
    // Do nothing.
  }
}

MapEntry<String, String>? _getContentTypeHeader(Map<String, String> metadata) {
  for (var entry in metadata.entries) {
    if (entry.key.toLowerCase() == _contentTypeKey.toLowerCase()) {
      return entry;
    }
  }
  return null;
}
