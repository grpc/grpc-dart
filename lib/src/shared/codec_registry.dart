import 'codec.dart';

class CodecRegistry {
  CodecRegistry._() {
    final allCodecs = [const Identity(), const Gzip()];
    allCodecs.forEach((codec) => register(codec));
  }

  static final CodecRegistry _instance = CodecRegistry._();

  factory CodecRegistry() {
    return _instance;
  }

  final Map<String, Codec> codecs = {};

  Codec lookupCodec(String codecName) {
    return codecs[codecName];
  }

  void register(Codec codec) {
    final encoding = codec.messageEncoding();
    assert(!encoding.contains(","),
        "Comma is currently not allowed in message encoding");
    codecs[encoding] = codec;
  }
}
