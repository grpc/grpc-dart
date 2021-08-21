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
import 'dart:io';
import 'dart:typed_data';

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';
import 'web_streams.dart';

const _contentTypeKey = 'Content-Type';

/// All accepted content-type header's prefix.
const _validContentTypePrefix = ['application/grpc', 'application/json+protobuf', 'application/x-protobuf'];

class XhrTransportStream implements GrpcTransportStream {
  final Future<HttpClientRequest> _request;
  final Map<String, String> _metadata;
  final ErrorHandler _onError;
  final Function(XhrTransportStream stream) _onDone;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  XhrTransportStream(this._request, this._metadata, {onError, onDone})
      : _onError = onError,
        _onDone = onDone {
    _request.then((HttpClientRequest request) {
      for (final entry in _metadata.entries) {
        request.headers.add(entry.key, entry.value);
      }

      _outgoingMessages.stream.map(frame).listen((data) => request.add(data), cancelOnError: true, onDone: () {
        request.close().then((HttpClientResponse response) {
          if (response.statusCode == 200) {
            final contentType = response.headers.contentType.value;

            if (contentType == null) {
              _onError(GrpcError.unavailable('XhrConnection missing Content-Type'), StackTrace.current);
              return;
            }
            if (!_checkContentType(contentType)) {
              _onError(GrpcError.unavailable('XhrConnection bad Content-Type $contentType'), StackTrace.current);
              return;
            }

            final Map<String, String> httpHeaders = {};
            response.headers.forEach((name, values) {
              httpHeaders[name] = values.join(',');
            });

            final headers = GrpcMetadata(httpHeaders);
            _incomingMessages.add(headers);

            response.listen((buffer) {
              _incomingProcessor.add(Int8List.fromList(buffer).buffer);
            }, onError: () {
              _onError(GrpcError.unavailable('XhrConnection connection-error'), StackTrace.current);
              terminate();
            }, onDone: () {
              _incomingProcessor.close();
            });
          } else {
            _onError(GrpcError.unavailable('XhrConnection status ${response.statusCode}'), StackTrace.current);
            terminate();
          }
        });
      });
    });

    _incomingProcessor.stream
        .transform(GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(_incomingMessages.add, onError: _onError, onDone: _incomingMessages.close);
  }

  bool _checkContentType(String contentType) {
    return _validContentTypePrefix.any(contentType.startsWith);
  }

  _close() {
    _incomingProcessor.close();
    _outgoingMessages.close();
    _onDone(this);
  }

  @override
  Future<void> terminate() async {
    _close();
    // _request.abort();
  }
}

class XhrClientConnection extends ClientConnection {
  final Uri uri;
  final HttpClient client;

  final _requests = <XhrTransportStream>{};

  XhrClientConnection(this.uri) : client = HttpClient();

  String get authority => uri.authority;
  String get scheme => uri.scheme;

  @override
  GrpcTransportStream makeRequest(String path, Duration timeout, Map<String, String> metadata, ErrorHandler onError, {CallOptions callOptions}) {
    // gRPC-web headers.
    if (_getContentTypeHeader(metadata) == null) {
      metadata['Content-Type'] = 'application/grpc-web+proto';
      metadata['X-User-Agent'] = 'grpc-web-dart/0.1';
      metadata['X-Grpc-Web'] = '1';
    }

    var requestUri = uri.resolve(path);
    if (callOptions is WebCallOptions && callOptions.bypassCorsPreflight == true) {
      requestUri = cors.moveHttpHeadersToQueryParam(metadata, requestUri);
    }

    final Future<HttpClientRequest> request = client.postUrl(requestUri);
    final XhrTransportStream transportStream = XhrTransportStream(request, metadata, onError: onError, onDone: _removeStream);
    _requests.add(transportStream);
    return transportStream;
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
}

MapEntry<String, String> _getContentTypeHeader(Map<String, String> metadata) {
  for (var entry in metadata.entries) {
    if (entry.key.toLowerCase() == _contentTypeKey.toLowerCase()) {
      return entry;
    }
  }
  return null;
}
