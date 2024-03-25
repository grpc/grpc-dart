import 'package:grpc/src/shared/codec.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:test/test.dart';

void main() {
  group('GRPC Compression Flag', () {
    test('compression flag 0 with null codec', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec? codec;
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 0 with grpc-encoding identity', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec codec = IdentityCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 1 with grpc-encoding gzip', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec codec = GzipCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 1);
    });
  });
}
