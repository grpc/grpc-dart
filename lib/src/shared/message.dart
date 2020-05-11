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
  GrpcData(this.data, {this.isCompressed}) : assert(data != null);

  @override
  String toString() => 'gRPC Data (${data.length} bytes)';
}

class GrpcMessageSink extends Sink<GrpcMessage> {
  GrpcMessage message;

  @override
  void add(GrpcMessage data) {
    if (message != null) {
      throw StateError('Too many messages received!');
    }
    message = data;
  }

  @override
  void close() {
    if (message == null) {
      throw StateError('No messages received!');
    }
  }
}

List<int> frame(List<int> payload) {
  final payloadLength = payload.length;
  final bytes = Uint8List(payloadLength + 5);
  final header = bytes.buffer.asByteData(0, 5);
  header.setUint8(0, 0); // TODO(dart-lang/grpc-dart#6): Handle compression
  header.setUint32(1, payloadLength);
  bytes.setRange(5, bytes.length, payload);
  return bytes;
}

StreamTransformer<GrpcMessage, GrpcMessage> grpcDecompressor() =>
    StreamTransformer<GrpcMessage, GrpcMessage>.fromHandlers(
        handleData: (GrpcMessage value, EventSink<GrpcMessage> sink) {
      if (value is GrpcData) {
        if (value.isCompressed) {
          // TODO(dart-lang/grpc-dart#6): Actually handle decompression.
          sink.add(GrpcData(value.data, isCompressed: false));
          return;
        }
      }
      sink.add(value);
    });
