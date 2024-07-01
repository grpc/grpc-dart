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
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';
import 'web_streams.dart';

const _contentTypeKey = 'Content-Type';

class HTTPTransportStream implements GrpcTransportStream {
  final ErrorHandler _onError;
  final Function(HTTPTransportStream stream) _onDone;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  HTTPTransportStream(client, request,
      {required ErrorHandler onError, required onDone})
      : _onError = onError,
        _onDone = onDone {
    () async {
      _outgoingMessages.stream
          .map(frame)
          .listen((data) => request.sink.add(data), onDone: () {
        request.sink.close();
      }, cancelOnError: true);

      final response = await client.send(request);

      _incomingMessages.add(GrpcMetadata(response.headers));

      response.stream.listen((event) async {
        if (_incomingProcessor.isClosed) {
          return;
        }
        _incomingProcessor.add(Uint8List.fromList(event).buffer);
      }, onDone: () {
        _onRequestDone(response);
        _close();
      }, onError: (error, stackTrace) {
        if (_incomingProcessor.isClosed) {
          return;
        }
        _onError(GrpcError.unavailable('HTTPConnection connection-error'),
            stackTrace);
        terminate();
      });

      _incomingProcessor.stream
          .transform(GrpcWebDecoder())
          .transform(grpcDecompressor())
          .listen(_incomingMessages.add,
              onError: _onError, onDone: _incomingMessages.close);
    }();
  }

  bool _validateResponseState(http.StreamedResponse response) {
    try {
      validateHttpStatusAndContentType(response.statusCode, response.headers);
      return true;
    } catch (e, st) {
      _onError(e, st);
      return false;
    }
  }

  void _onRequestDone(http.StreamedResponse response) {
    _validateResponseState(response);
  }

  void _close() {
    _incomingProcessor.close();
    _outgoingMessages.close();
    _onDone(this);
  }

  @override
  Future<void> terminate() async {
    _close();
  }
}

class HTTPClientConnection extends ClientConnection {
  final Uri uri;

  final _requests = <HTTPTransportStream>{};

  HTTPClientConnection(this.uri);

  @override
  String get authority => uri.authority;
  @override
  String get scheme => uri.scheme;

  // @visibleForTesting
  http.Client createHttpClient() => http.Client();

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

    final request = http.StreamedRequest('POST', requestUri);

    for (final header in metadata.keys) {
      request.headers[header] = metadata[header]!;
    }

    final client = createHttpClient();

    final transportStream = HTTPTransportStream(client, request,
        onError: onError, onDone: _removeStream);
    _requests.add(transportStream);
    return transportStream;
  }

  void _removeStream(HTTPTransportStream stream) {
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
