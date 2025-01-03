// Copyright (c) 2020, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:archive/archive.dart';

abstract class Codec {
  /// Returns the message encoding that this compressor uses.
  ///
  /// This can be values such as "gzip", "deflate", "snappy", etc.
  String get encodingName;

  /// Wraps an existing output stream with a compressed output.
  List<int> compress(List<int> data);

  /// Wraps an existing output stream with a uncompressed input data.
  List<int> decompress(List<int> data);
}

/// The "identity", or "none" codec.
///
/// This codec is special in that it can be used to explicitly disable Call
/// compression on a Channel that by default compresses.
class IdentityCodec implements Codec {
  const IdentityCodec();

  @override
  final encodingName = 'identity';

  @override
  List<int> compress(List<int> data) {
    return data;
  }

  @override
  List<int> decompress(List<int> data) {
    return data;
  }
}

/// A gzip compressor and decompressor.
class GzipCodec implements Codec {
  const GzipCodec();

  @override
  final encodingName = 'gzip';

  @override
  List<int> compress(List<int> data) {
    return GZipEncoder().encode(data)!;
  }

  @override
  List<int> decompress(List<int> data) {
    return GZipDecoder().decodeBytes(data);
  }
}
