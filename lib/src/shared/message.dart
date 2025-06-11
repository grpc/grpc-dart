// Copyright (c) 2019, the gRPC project authors. Please see the AUTHORS file
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

import 'codec.dart';
import 'codec_registry.dart';
import 'status.dart';

abstract class GrpcMessage {}

class GrpcMetadata extends GrpcMessage {
  final Map<String, String> metadata;
  GrpcMetadata(this.metadata);

  @override
  String toString() => 'gRPC Metadata ($metadata)';
}

class GrpcData extends GrpcMessage {
  final List<int> data;
  final bool isCompressed;
  GrpcData(this.data, {required this.isCompressed}) {
    ArgumentError.checkNotNull(data);
  }

  @override
  String toString() => 'gRPC Data (${data.length} bytes)';
}

class GrpcMessageSink implements Sink<GrpcMessage> {
  late final GrpcMessage message;
  bool _messageReceived = false;

  @override
  void add(GrpcMessage data) {
    if (_messageReceived) {
      throw StateError('Too many messages received!');
    }
    message = data;
    _messageReceived = true;
  }

  @override
  void close() {
    if (!_messageReceived) {
      throw StateError('No messages received!');
    }
  }
}

List<int> frame(List<int> rawPayload, [Codec? codec]) {
  final compressedPayload = codec == null
      ? rawPayload
      : codec.compress(rawPayload);
  final payloadLength = compressedPayload.length;
  final bytes = Uint8List(payloadLength + 5);
  final header = bytes.buffer.asByteData(0, 5);
  header.setUint8(
    0,
    (codec == null || codec.encodingName == 'identity') ? 0 : 1,
  );
  header.setUint32(1, payloadLength);
  bytes.setRange(5, bytes.length, compressedPayload);
  return bytes;
}

StreamTransformer<GrpcMessage, GrpcMessage> grpcDecompressor({
  CodecRegistry? codecRegistry,
}) {
  Codec? codec;
  return StreamTransformer<GrpcMessage, GrpcMessage>.fromHandlers(
    handleData: (GrpcMessage value, EventSink<GrpcMessage> sink) {
      if (value is GrpcData && value.isCompressed) {
        if (codec == null) {
          sink.addError(
            GrpcError.unimplemented('Compression mechanism not supported'),
          );
          return;
        }
        sink.add(GrpcData(codec!.decompress(value.data), isCompressed: false));
        return;
      }

      if (value is GrpcMetadata &&
          value.metadata.containsKey('grpc-encoding')) {
        codec = codecRegistry?.lookup(value.metadata['grpc-encoding']!);
      }
      sink.add(value);
    },
  );
}
