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
  final StreamController<List<int>> _outgoingMessages = StreamController();
  final ErrorHandler _onError;
  late final StreamSubscription<StreamMessage> _outgoingSubscription;

  @override
  StreamSink<List<int>> get outgoingMessages => _outgoingMessages.sink;

  Http2TransportStream(
    this._transportStream,
    this._onError,
    CodecRegistry? codecRegistry,
    Codec? compression,
  ) : incomingMessages = _transportStream.incomingMessages
          .transform(GrpcHttpDecoder(forResponse: true))
          .transform(grpcDecompressor(codecRegistry: codecRegistry)) {
    _outgoingSubscription = _outgoingMessages.stream
        .map((payload) => frame(payload, compression))
        .map<StreamMessage>((bytes) => DataStreamMessage(bytes))
        .handleError(_onError)
        .listen(
          _onOutgoingData,
          onError: _onOutgoingError,
          onDone: _transportStream.outgoingMessages.close,
          cancelOnError: true,
        );
    _transportStream.onTerminated = (_) {
      unawaited(_outgoingSubscription.cancel());
    };
  }

  void _onOutgoingData(StreamMessage message) {
    try {
      _transportStream.outgoingMessages.add(message);
    } on StateError {
      unawaited(_outgoingSubscription.cancel());
    }
  }

  void _onOutgoingError(Object error, StackTrace stackTrace) {
    try {
      _transportStream.outgoingMessages.addError(error, stackTrace);
    } on StateError {
      unawaited(_outgoingSubscription.cancel());
    }
  }

  @override
  Future<void> terminate() async {
    await _outgoingSubscription.cancel();
    await _outgoingMessages.close();
    _transportStream.terminate();
  }
}
