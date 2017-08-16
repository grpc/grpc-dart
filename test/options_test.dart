// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

const isIncorrectPasswordError = const _IncorrectPasswordError();

class _IncorrectPasswordError extends TypeMatcher {
  const _IncorrectPasswordError() : super("TlsException");
  bool matches(item, Map matchState) =>
      item is TlsException &&
      item.osError.message.contains('INCORRECT_PASSWORD');
}

void main() {
  group('Certificates', () {
    test('report password errors correctly', () async {
      final certificate =
          await new File('test/data/certstore.p12').readAsBytes();

      final missingPassword =
          new ChannelOptions.secure(certificate: certificate);
      expect(() => missingPassword.securityContext,
          throwsA(isIncorrectPasswordError));

      final wrongPassword = new ChannelOptions.secure(
          certificate: certificate, password: 'wrong');
      expect(() => wrongPassword.securityContext,
          throwsA(isIncorrectPasswordError));

      final correctPassword = new ChannelOptions.secure(
          certificate: certificate, password: 'correct');
      expect(correctPassword.securityContext, isNotNull);

      final channel = new ClientChannel('localhost', options: missingPassword);
      expect(channel.connect(), throwsA(isIncorrectPasswordError));
    });
  });
}
