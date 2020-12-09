import 'package:grpc/src/shared/codec.dart';
import 'package:grpc/src/shared/codec_registry.dart';
import 'package:test/test.dart';

void main() {
  test('CodecRegistry register adds new encodings', () {
    final registry = CodecRegistry();
    expect(registry.supportedEncodings, 'identity');
  });

  test('CodecRegistry lookup', () {
    final registry = CodecRegistry();
    expect(registry.lookup('identity'), const IdentityCodec());
  });
}
