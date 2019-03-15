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
  GrpcData(this.data, {this.isCompressed});

  @override
  String toString() => 'gRPC Data (${data.length} bytes)';
}

class GrpcMessageSink extends Sink<GrpcMessage> {
  GrpcMessage message;

  @override
  void add(GrpcMessage data) {
    if (message != null) {
      throw 'Too many messages received!';
    }
    message = data;
  }

  @override
  void close() {
    if (message == null) {
      throw 'No messages received!';
    }
  }
}

List<int> frame(List<int> payload) {
  final payloadLength = payload.length;
  final bytes = new Uint8List(payloadLength + 5);
  final header = bytes.buffer.asByteData(0, 5);
  header.setUint8(0, 0); // TODO(dart-lang/grpc-dart#6): Handle compression
  header.setUint32(1, payloadLength);
  bytes.setRange(5, bytes.length, payload);
  return bytes;
}

StreamTransformer<GrpcMessage, GrpcMessage> grpcDecompressor() =>
    new StreamTransformer<GrpcMessage, GrpcMessage>.fromHandlers(
        handleData: (GrpcMessage value, EventSink<GrpcMessage> sink) {
          if (value is GrpcData) {
            if (value.isCompressed) {
              // TODO(dart-lang/grpc-dart#6): Actually handle decompression.
              sink.add(new GrpcData(value.data, isCompressed: false));
              return;
            }
          }
          sink.add(value);
        });
