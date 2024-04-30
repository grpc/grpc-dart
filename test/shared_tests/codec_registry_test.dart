// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
