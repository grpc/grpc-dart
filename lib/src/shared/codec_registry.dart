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

import 'codec.dart';

/// Encloses classes related to the compression and decompression of messages.
class CodecRegistry {
  CodecRegistry({List<Codec> codecs = const [IdentityCodec()]})
    : _codecs = {for (var codec in codecs) codec.encodingName: codec},
      _supportedEncodings = codecs
          .map((c) {
            if (c.encodingName.contains(',')) {
              throw ArgumentError.value(
                c.encodingName,
                'codecs',
                'contains entries with names containing ","',
              );
            }
            return c.encodingName;
          })
          .join(',') {
    if (_codecs.length != codecs.length) {
      throw ArgumentError.value(
        codecs,
        'codecs',
        'contains multiple entries with the same name',
      );
    }
  }

  factory CodecRegistry.empty() => CodecRegistry(codecs: []);

  /// Key refers to the `encodingName` param from the [Codec].
  final Map<String, Codec> _codecs;

  final String _supportedEncodings;

  Codec? lookup(String codecName) {
    return _codecs[codecName];
  }

  String get supportedEncodings => _supportedEncodings;
}
