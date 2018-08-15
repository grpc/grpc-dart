// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
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
import 'dart:typed_data';

import '../../shared/streams.dart';
import '../../shared/timeout.dart';

import '../options.dart';

import 'transport.dart';

class GrpcWebTransportStream extends GrpcTransportStream {
  HttpRequest _request;
  StreamController<ByteBuffer> _incomingProcessor;
  StreamController<GrpcMessage> _incomingMessages;
  StreamController<List<int>> _outgoingMessages;

  // TODO: implement id
  @override
  int get id => null;

  // TODO: implement incomingMessages
  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  // TODO: implement outgoingMessages
  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  GrpcWebTransportStream(this._request) {
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
      .listen((data) {
        //final encoded = base64Encode(data);
        _request.send(data);
      });

    _request.onReadyStateChange.listen((data) {
      final contentType = _request.getResponseHeader('Content-Type');
      if(contentType == null) {
        return;
      }

      if(contentType.startsWith('application/grpc')) {
        if(_request.response == null) {
          return;
        }

        // Force a metadata message with headers
        final headers = new GrpcMetadata(_request.responseHeaders);
        _incomingMessages.add(headers);


        final byteSource = _request.response as ByteBuffer;
        _incomingProcessor.add(byteSource);
        _incomingProcessor.close();
      }
    });
  }

  @override
  void terminate() {
    // TODO: implement terminate
  }
}

class GrpcWebTransport extends Transport {
  final String host;
  final int port;
  final ChannelOptions options;

  HttpRequest _request;

  GrpcWebTransport(this.host, this.port, this.options);

  @override
  Future<Null> connect() {
    
  }

  @override
  Future<Null> finish() {
    // TODO: implement finish
  }

  @override
  GrpcTransportStream makeRequest(String path, Duration timeout, Map<String, String> metadata) {
    _request = HttpRequest();
    _request.open('POST', '${host}:${port}${path}');

    for(final header in metadata.keys) {
      _request.setRequestHeader(header, metadata[header]);
    }
    _request.setRequestHeader('Content-Type', 'application/grpc-web+proto');
    _request.setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1');
    _request.setRequestHeader('X-Grpc-Web', '1');
    _request.responseType = 'arraybuffer';
    
    return GrpcWebTransportStream(_request);
  }

  @override
  Future<Null> terminate() {
    // TODO: implement terminate
  }

}