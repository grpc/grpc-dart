// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

const isTlsException = const TypeMatcher<TlsException>();

void main() {
  group('Certificates', () {
    test('report password errors correctly', () async {
      final certificates =
          await new File('test/data/certstore.p12').readAsBytes();

      final missingPassword =
          new ChannelCredentials.secure(certificates: certificates);
      expect(() => missingPassword.securityContext, throwsA(isTlsException));

      final wrongPassword = new ChannelCredentials.secure(
          certificates: certificates, password: 'wrong');
      expect(() => wrongPassword.securityContext, throwsA(isTlsException));

      final correctPassword = new ChannelCredentials.secure(
          certificates: certificates, password: 'correct');
      expect(correctPassword.securityContext, isNotNull);
    });
  });
}
