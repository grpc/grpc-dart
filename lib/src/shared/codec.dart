import 'package:archive/archive.dart';

abstract class Codec {
  /// Returns the message encoding that this compressor uses.
  ///
  /// This can be values such as "gzip", "deflate", "snappy", etc.
  String messageEncoding();

  /// Wraps an existing output stream with a compressed output.
  List<int> compress(List<int> outputStream);

  /// Wraps an existing output stream with a uncompressed input data.
  List<int> decompress(List<int> inputStream);
}

/// The "identity", or "none" codec.
///
/// This codec is special in that it can be used to explicitly disable Call
/// compression on a Channel that by default compresses.
class Identity implements Codec {
  const Identity();

  @override
  String messageEncoding() {
    return "identity";
  }

  @override
  List<int> compress(List<int> outputStream) {
    return outputStream;
  }

  @override
  List<int> decompress(List<int> inputStream) {
    return inputStream;
  }
}

/// A gzip compressor and decompressor.
class Gzip implements Codec {
  const Gzip();

  @override
  String messageEncoding() {
    return "gzip";
  }

  @override
  List<int> compress(List<int> outputStream) {
    return GZipEncoder().encode(outputStream);
  }

  @override
  List<int> decompress(List<int> inputStream) {
    return GZipDecoder().decodeBytes(inputStream);
  }
}
