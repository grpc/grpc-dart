import 'codec.dart';

class CodecRegistry {
  CodecRegistry() {
    final allCodecs = [const Identity(), const Gzip()];
    allCodecs.map((codec) => codecs[codec.getMessageEncoding()] = codec);
  }

  final Map<String, Codec> codecs = {};

  Codec lookupCodec(String codecName) {
    return codecs[codecName];
  }

  register(Codec codec) {
    final encoding = codec.getMessageEncoding();
    assert(!encoding.contains(","),
        "Comma is currently not allowed in message encoding");
    codecs[encoding] = codec;
  }
}
