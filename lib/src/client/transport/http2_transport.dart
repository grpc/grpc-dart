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
  final StreamController<List<int>> _outgoingMessages = StreamController(
    sync: true,
  );
  late final StreamSubscription<List<int>> _outgoingSubscription;
  final ErrorHandler _onError;

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
    final isIdentity =
        compression == null || compression.encodingName == 'identity';
    _outgoingSubscription = _outgoingMessages.stream.listen(
      (payload) {
        try {
          if (isIdentity &&
              payload is Uint8List &&
              payload.length > zeroCopyFrameThreshold) {
            _transportStream.outgoingMessages.add(
              DataStreamMessage(frameHeader(payload.length)),
            );
            _transportStream.outgoingMessages.add(DataStreamMessage(payload));
          } else {
            _transportStream.outgoingMessages.add(
              DataStreamMessage(frame(payload, compression)),
            );
          }
        } catch (e, s) {
          _onError(e, s);
        }
      },
      onError: _onError,
      onDone: _transportStream.outgoingMessages.close,
      cancelOnError: true,
    );
  }

  @override
  Future<void> terminate() async {
    await _outgoingSubscription.cancel();
    await _outgoingMessages.close();
    _transportStream.terminate();
  }
}
