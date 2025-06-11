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
import 'dart:async';
import 'dart:io';
import 'package:test/test.dart';

/// Test functionality for Unix domain socket.
void testUds(String name, FutureOr<void> Function(InternetAddress) testCase) {
  if (Platform.isWindows) {
    return;
  }

  test(name, () async {
    final tempDir = await Directory.systemTemp.createTemp();
    final address = InternetAddress(
      '${tempDir.path}/socket',
      type: InternetAddressType.unix,
    );
    addTearDown(() => tempDir.delete(recursive: true));
    await testCase(address);
  });
}

/// Test functionality for both TCP and Unix domain sockets.
void testTcpAndUds(
  String name,
  FutureOr<void> Function(InternetAddress) testCase, {
  String host = 'localhost',
}) {
  test(name, () async {
    final address = await InternetAddress.lookup(host);
    await testCase(address.first);
  });

  testUds('$name (over uds)', testCase);
}
