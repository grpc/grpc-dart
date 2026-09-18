// Copyright (c) 2026, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:io';

import 'package:grpc/src/client/options.dart';
import 'package:grpc/src/version.dart';
import 'package:test/test.dart';

void main() {
  test('packageVersion matches pubspec.yaml version', () {
    final pubspecContent = File('pubspec.yaml').readAsStringSync();
    final match = RegExp(
      r'^version:\s*(\S+)',
      multiLine: true,
    ).firstMatch(pubspecContent);
    expect(match, isNotNull);
    expect(packageVersion, match!.group(1));
  });

  test('defaultUserAgent follows gRPC HTTP/2 spec format on VM', () {
    final sdkVersion = Platform.version.split(' ').first;
    expect(defaultUserAgent, 'grpc-dart/$packageVersion (dart/$sdkVersion)');
  });

  test('ChannelOptions resolves defaultUserAgent and custom userAgent', () {
    expect(defaultUserAgent, startsWith('grpc-dart/$packageVersion'));
    expect(const ChannelOptions().userAgent, defaultUserAgent);
    expect(
      const ChannelOptions(userAgent: 'custom-agent/1.0').userAgent,
      'custom-agent/1.0',
    );
  });
}
