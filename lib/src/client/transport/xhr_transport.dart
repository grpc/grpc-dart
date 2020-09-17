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

import '../../client/call.dart';
import '../../shared/message.dart';
import '../../shared/status.dart';
import '../connection.dart';
import 'transport.dart';
import 'web_streams.dart';

class XhrTransportStream implements GrpcTransportStream {
  final HttpRequest _request;
  final ErrorHandler _onError;
  final Function(XhrTransportStream stream) _onDone;
  int _requestBytesRead = 0;
  final StreamController<ByteBuffer> _incomingProcessor = StreamController();
  final StreamController<GrpcMessage> _incomingMessages = StreamController();
  final StreamController<List<int>> _outgoingMessages = StreamController();

  @override
  Stream<GrpcMessage> get incomingMessages => _incomingMessages.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  XhrTransportStream(this._request, {onError, onDone})
      : _onError = onError,
        _onDone = onDone {
    _outgoingMessages.stream
        .map(frame)
        .listen((data) => _request.send(data), cancelOnError: true);

    _request.onReadyStateChange.listen((data) {
      if (_incomingMessages.isClosed) {
        return;
      }
      switch (_request.readyState) {
        case HttpRequest.HEADERS_RECEIVED:
          _onHeadersReceived();
          break;
        case HttpRequest.DONE:
          if (_request.status != 200) {
            _onError(GrpcError.unavailable(
                'XhrConnection status ${_request.status}'));
          } else {
            _close();
          }
          break;
      }
    });

    _request.onError.listen((ProgressEvent event) {
      if (_incomingMessages.isClosed) {
        return;
      }
      _onError(GrpcError.unavailable('XhrConnection connection-error'));
      terminate();
    });

    _request.onProgress.listen((_) {
      if (_incomingMessages.isClosed) {
        return;
      }
      // Use response over responseText as most browsers don't support
      // using responseText during an onProgress event.
      final responseString = _request.response as String;
      final bytes = Uint8List.fromList(
              responseString.substring(_requestBytesRead).codeUnits)
          .buffer;
      _requestBytesRead = responseString.length;
      _incomingProcessor.add(bytes);
    });

    _incomingProcessor.stream
        .transform(GrpcWebDecoder())
        .transform(grpcDecompressor())
        .listen(_incomingMessages.add,
            onError: _onError, onDone: _incomingMessages.close);
  }

  _onHeadersReceived() {
    final contentType = _request.getResponseHeader('Content-Type');
    if (_request.status != 200) {
      _onError(
          GrpcError.unavailable('XhrConnection status ${_request.status}'));
      return;
    }
    if (contentType == null) {
      _onError(GrpcError.unavailable('XhrConnection missing Content-Type'));
      return;
    }
    if (!contentType.startsWith('application/grpc')) {
      _onError(
          GrpcError.unavailable('XhrConnection bad Content-Type $contentType'));
      return;
    }
    if (_request.response == null) {
      _onError(GrpcError.unavailable('XhrConnection request null response'));
      return;
    }

    // Force a metadata message with headers.
    final headers = GrpcMetadata(_request.responseHeaders);
    _incomingMessages.add(headers);
  }

  _close() {
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

class XhrClientConnection extends ClientConnection {
  final Uri uri;

  final Set<XhrTransportStream> _requests = Set<XhrTransportStream>();

  XhrClientConnection(this.uri);

  String get authority => uri.authority;
  String get scheme => uri.scheme;

  void _initializeRequest(HttpRequest request, Map<String, String> metadata) {
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

  @visibleForTesting
  HttpRequest createHttpRequest() => HttpRequest();

  @override
  GrpcTransportStream makeRequest(String path, Duration timeout,
      Map<String, String> metadata, ErrorHandler onError) {
    final HttpRequest request = createHttpRequest();
    request.open('POST', uri.resolve(path).toString());

    _initializeRequest(request, metadata);

    final XhrTransportStream transportStream =
        XhrTransportStream(request, onError: onError, onDone: _removeStream);
    _requests.add(transportStream);
    return transportStream;
  }

  void _removeStream(XhrTransportStream stream) {
    _requests.remove(stream);
  }

  @override
  Future<void> terminate() async {
    for (XhrTransportStream request in _requests) {
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
