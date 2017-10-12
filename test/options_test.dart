// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

const isTlsException = const isInstanceOf<TlsException>();

void main() {
  group('Certificates', () {
    test('report password errors correctly', () async {
      final certificate =
          await new File('test/data/certstore.p12').readAsBytes();

      final missingPassword =
          new ChannelOptions.secure(certificate: certificate);
      expect(() => missingPassword.securityContext, throwsA(isTlsException));

      final wrongPassword = new ChannelOptions.secure(
          certificate: certificate, password: 'wrong');
      expect(() => wrongPassword.securityContext, throwsA(isTlsException));

      final correctPassword = new ChannelOptions.secure(
          certificate: certificate, password: 'correct');
      expect(correctPassword.securityContext, isNotNull);
    });
  });
}
