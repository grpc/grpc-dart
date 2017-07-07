// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:grpc/src/client.dart';

void main() {
  test('Timeouts are converted correctly', () {
    expect(ClientCall.toTimeoutString(new Duration(microseconds: -1)), '1n');
    expect(ClientCall.toTimeoutString(new Duration(microseconds: 0)), '0u');
    expect(ClientCall.toTimeoutString(new Duration(microseconds: 107)), '107u');
    expect(ClientCall.toTimeoutString(new Duration(hours: 2, microseconds: 17)),
        '7200S');
    expect(ClientCall.toTimeoutString(new Duration(milliseconds: 1420665)),
        '1420S');
    expect(
        ClientCall.toTimeoutString(new Duration(seconds: 2, microseconds: 3)),
        '2000m');
    expect(
        ClientCall.toTimeoutString(new Duration(seconds: 2, milliseconds: 3)),
        '2003m');
  });
}
