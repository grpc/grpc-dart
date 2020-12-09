import 'package:grpc/src/shared/codec.dart';
import 'package:grpc/src/shared/codec_registry.dart';
import 'package:test/test.dart';

void main() {
  test('CodecRegistry register adds new encodings', () {
    final registry = CodecRegistry();
    expect(registry.encodings(), 'identity');

    registry.register(const Gzip());
    expect(registry.encodings(), 'identity,gzip');
  });

  test('CodecRegistry lookup', () {
    final registry = CodecRegistry();
    expect(registry.lookupCodec('identity'), const Identity());
  });
}
