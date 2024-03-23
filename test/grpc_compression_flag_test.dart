import 'package:grpc/src/shared/message.dart';
import 'package:grpc/src/shared/codec.dart';

import 'package:test/test.dart';

void main() {
  group('GRPC Compression Flag', () {
    test('compression flag 0 with null codec', () {
      List<int> rawPayload = [1, 2, 3, 4];
      Codec? codec = null;
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 0 with grpc-encoding identity', () {
      List<int> rawPayload = [1, 2, 3, 4];
      Codec? codec = IdentityCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 1 with grpc-encoding gzip', () {
      List<int> rawPayload = [1, 2, 3, 4];
      Codec? codec = GzipCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 1);
    });
  });
}
