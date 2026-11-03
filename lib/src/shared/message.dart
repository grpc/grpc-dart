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

/// Length of the gRPC message prefix: a 1-byte compressed flag followed by the
/// 4-byte big-endian payload length.
const int _frameHeaderLength = 5;

/// Payload length above which uncompressed outgoing messages are sent as a
/// separate 5-byte prefix followed by the serialized payload itself, instead of
/// being copied into a new `length + 5` buffer.
///
/// Smaller payloads fit in one default-sized HTTP/2 DATA frame (16 KiB) together
/// with their prefix, so they are still sent as a single DATA frame.
const int zeroCopyFrameThreshold = 16384 - _frameHeaderLength;

/// Whether [codec] leaves payloads uncompressed.
bool isIdentityCodec(Codec? codec) =>
    codec == null || codec.encodingName == 'identity';

void _writeFrameHeader(
  Uint8List target,
  int payloadLength, {
  required bool compressed,
}) {
  ByteData.sublistView(target, 0, _frameHeaderLength)
    ..setUint8(0, compressed ? 1 : 0)
    ..setUint32(1, payloadLength);
}

/// The 5-byte prefix of an uncompressed message with [payloadLength] bytes.
Uint8List frameHeader(int payloadLength) {
  final header = Uint8List(_frameHeaderLength);
  _writeFrameHeader(header, payloadLength, compressed: false);
  return header;
}

List<int> frame(List<int> rawPayload, [Codec? codec]) {
  final compressor = isIdentityCodec(codec) ? null : codec;
  final payload = compressor == null
      ? rawPayload
      : compressor.compress(rawPayload);
  final bytes = Uint8List(payload.length + _frameHeaderLength);
  _writeFrameHeader(bytes, payload.length, compressed: compressor != null);
  bytes.setRange(_frameHeaderLength, bytes.length, payload);
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
