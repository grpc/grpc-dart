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

import 'package:http2/transport.dart';

import '../../shared/codec.dart';
import '../../shared/codec_registry.dart';
import '../../shared/message.dart';
import '../../shared/streams.dart';
import 'transport.dart';

class Http2TransportStream extends GrpcTransportStream {
  final TransportStream _transportStream;
  @override
  final Stream<GrpcMessage> incomingMessages;
  final _OutgoingMessageSink _outgoingMessages;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages;

  Http2TransportStream(
    this._transportStream,
    ErrorHandler onError,
    CodecRegistry? codecRegistry,
    Codec? compression,
  ) : incomingMessages = _transportStream.incomingMessages.transform(
        GrpcDecompressingHttpDecoder(
          forResponse: true,
          codecRegistry: codecRegistry,
        ),
      ),
      _outgoingMessages = _OutgoingMessageSink(
        _transportStream.outgoingMessages,
        compression,
        onError,
      );

  @override
  Future<void> terminate() async {
    _outgoingMessages._isClosed = true;
    _transportStream.terminate();
  }
}

/// Frames outgoing messages and adds them to the HTTP/2 stream right away.
class _OutgoingMessageSink implements StreamSink<List<int>>, LastMessageSink {
  final StreamSink<StreamMessage> _sink;
  final Codec? _compression;
  final ErrorHandler _onError;

  /// Whether messages are dropped because this sink was closed, got an error,
  /// or the stream was terminated.
  bool _isClosed = false;

  _OutgoingMessageSink(this._sink, this._compression, this._onError);

  @override
  void add(List<int> message, {bool endStream = false}) {
    if (_isClosed) return;
    try {
      addGrpcMessage(_sink, message, _compression, endStream: endStream);
    } catch (e, s) {
      _onError(e, s);
    }
  }

  @override
  void addLast(List<int> message) {
    add(message, endStream: true);
    close();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    if (_isClosed) return;
    _isClosed = true;
    _onError(error, stackTrace ?? StackTrace.current);
  }

  @override
  Future<void> addStream(Stream<List<int>> stream) =>
      stream.handleError(addError).forEach(add);

  @override
  Future<void> close() {
    if (_isClosed) return done;
    _isClosed = true;
    return _sink.close();
  }

  @override
  Future<void> get done => _sink.done;
}
