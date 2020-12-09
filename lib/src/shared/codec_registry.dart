import 'codec.dart';

/// Encloses classes related to the compression and decompression of messages.
class CodecRegistry {
  CodecRegistry({List<Codec> codecs = const [const Identity()]})
      : assert(codecs != null) {
    codecs.forEach((codec) => register(codec));
  }

  factory CodecRegistry.empty() {
    return CodecRegistry(codecs: []);
  }

  /// Key refers to the `messageEncoding` string from the [Codec].
  final Map<String, Codec> _codecs = {};
  final List<String> _allSupportedCodecs = [];

  Codec lookupCodec(String codecName) {
    return _codecs[codecName];
  }

  String encodings() {
    return _allSupportedCodecs.join(',');
  }

  /// Registers a [Codec] for both decompression and message encoding
  /// negotiation.
  void register(Codec codec) {
    final encoding = codec.messageEncoding();
    assert(!encoding.contains(","),
        "Comma is currently not allowed in message encoding");
    if (!_codecs.containsKey(encoding)) {
      _allSupportedCodecs.add(encoding);
    }
    _codecs[encoding] = codec;
  }
}
