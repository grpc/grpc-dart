import 'package:archive/archive.dart';

class Codec {
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

  @Override
  public List<int> decompress(List<int> inputStream) {
  return inputStream;
  }

  @Override
  public String getMessageEncoding() {
    return "identity";
  }

  @Override
  public List<int> compress(List<int> outputStream) {
    return outputStream;
  }
}

/// A gzip compressor and decompressor.
class Gzip implements Codec {
  const Gzip();

  @Override
  public List<int> decompress(List<int> inputStream) {
    return GZipEncoder().encode(inputStream);
  }

  @Override
  public String getMessageEncoding() {
    return "gzip";
  }

  @Override
  public List<int> compress(List<int> outputStream) {
    return GZipDecoder().decodeBytes(outputStream);
  }
}
