// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'package:grpc/src/client/transport/web_streams.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:test/test.dart';

void main() {
  test('decoding an empty repeated', () async {
    final data = await GrpcWebDecoder()
        .bind(Stream.fromIterable([
          Uint8List.fromList([0, 0, 0, 0, 0]).buffer
        ]))
        .first as GrpcData;
    expect(data.data, []);
  });
}
