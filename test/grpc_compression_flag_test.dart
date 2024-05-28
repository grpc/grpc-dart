// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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

@TestOn('vm')
library;

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
