import 'package:archive/archive.dart';

abstract class Codec {
  /// Returns the message encoding that this compressor uses.
  ///
  /// This can be values such as "gzip", "deflate", "snappy", etc.
  String getMessageEncoding();

  /// Wraps an existing output stream with a compressed output.
  List<int> compress(List<int> os);

  /// Wraps an existing output stream with a uncompressed input data.
  List<int> decompress(List<int> os);
}

/// The "identity", or "none" codec.
///
/// This codec is special in that it can be used to explicitly disable Call
/// compression on a Channel that by default compresses.
class Identity implements Codec {
  const Identity();

  @override
  List<int> decompress(List<int> inputStream) {
    return inputStream;
  }

  @override
  String getMessageEncoding() {
    return "identity";
  }

  @override
  List<int> compress(List<int> outputStream) {
    return outputStream;
  }
}

/// A gzip compressor and decompressor.
class Gzip implements Codec {
  const Gzip();

  @override
  List<int> decompress(List<int> inputStream) {
    return GZipDecoder().decodeBytes(inputStream);
  }

  @override
  String getMessageEncoding() {
    return "gzip";
  }

  @override
  List<int> compress(List<int> outputStream) {
    return GZipEncoder().encode(outputStream);
  }
}
