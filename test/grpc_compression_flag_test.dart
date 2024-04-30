// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')

import 'package:grpc/src/shared/codec.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:test/test.dart';

void main() {
  group('GRPC Compression Flag', () {
    test('compression flag 0 with null codec', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec? codec = null;
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 0 with grpc-encoding identity', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec codec = IdentityCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 0);
    });
    test('compression flag 1 with grpc-encoding gzip', () {
      final rawPayload = <int>[1, 2, 3, 4];
      final Codec codec = GzipCodec();
      final data = frame(rawPayload, codec);
      expect(data[0], 1);
    });
  });
}
