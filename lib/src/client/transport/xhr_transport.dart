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
import 'dart:html';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import '../../shared/streams.dart';

import '../options.dart';

import 'transport.dart';

class XhrTransportStream extends GrpcTransportStream {
  HttpRequest _request;
  int _requestBytesRead = 0;
  StreamController<ByteBuffer> _incomingProcessor;
  StreamController<GrpcMessage> _incomingMessages;
  StreamController<List<int>> _outgoingMessages;

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  XhrTransportStream(this._request) {
    _incomingProcessor = new StreamController();
    _incomingMessages = new StreamController();
    _outgoingMessages = new StreamController();

    _incomingProcessor.stream
        .transform(new GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(_incomingMessages.add,
            onError: _incomingMessages.addError,
            onDone: _incomingMessages.close);

    _outgoingMessages.stream
        .map(GrpcHttpEncoder.frame)
        .listen((data) => _request.send(data));

    _request.onReadyStateChange.listen((data) {
      final contentType = _request.getResponseHeader('Content-Type');
      if (contentType == null) {
        return;
      }

      if (_request.readyState == HttpRequest.HEADERS_RECEIVED) {
        if (contentType.startsWith('application/grpc')) {
          if (_request.response == null) {
            return;
          }

          // Force a metadata message with headers
          final headers = new GrpcMetadata(_request.responseHeaders);
          _incomingMessages.add(headers);
        }
      }

      if (_request.readyState == HttpRequest.DONE) {
        _incomingProcessor.close();
        _outgoingMessages.close();
      }
    });

    _request.onProgress.listen((data) {
      // use response over responseText as most browsers don't support
      // using responseText during an onProgress event.
      final responseString = _request.response as String;
      final bytes = Uint8List.fromList(responseString.substring(_requestBytesRead).codeUnits).buffer;
      _requestBytesRead = responseString.length;
      _incomingProcessor.add(bytes);
    });
  }

  @override
  Future<void> terminate() async {
    await _incomingProcessor.close();
    await _outgoingMessages.close();
    _request.abort();
  }
}

class XhrTransport extends Transport {
  final String host;
  final int port;
  final ChannelOptions options;

  HttpRequest _request;

  XhrTransport(this.host, this.port, this.options);

  @override
  Future<void> connect() async {}

  @override
  Future<void> finish() async {
    // TODO: implement finish
  }

  @visibleForTesting
  void initializeRequest(HttpRequest request, Map<String, String> metadata) {
    for (final header in metadata.keys) {
      request.setRequestHeader(header, metadata[header]);
    }
    request.setRequestHeader('Content-Type', 'application/grpc-web+proto');
    request.setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1');
    request.setRequestHeader('X-Grpc-Web', '1');
    // Overriding the mimetype allows us to stream and parse the data
    request.overrideMimeType('text/plain; charset=x-user-defined');
    request.responseType = 'text';
  }

  @override
  GrpcTransportStream makeRequest(
      String path, Duration timeout, Map<String, String> metadata) {
    _request = HttpRequest();
    _request.open('POST', '${host}:${port}${path}');

    initializeRequest(_request, metadata);

    return XhrTransportStream(_request);
  }

  @override
  Future<void> terminate() async {
    // TODO: implement terminate
  }
}
