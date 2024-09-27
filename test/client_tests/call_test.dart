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

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/call.dart';
import 'package:test/test.dart';

import '../src/client_utils.dart';

void main() {
  const dummyValue = 0;
  const cancelDurationMillis = 300;

  late ClientHarness harness;

  setUp(() {
    harness = ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('WebCallOptions mergeWith CallOptions returns WebCallOptions', () {
    final options =
        WebCallOptions(bypassCorsPreflight: true, withCredentials: true);
    final metadata = {'test': '42'};
    final mergedOptions =
        options.mergedWith(CallOptions(metadata: metadata)) as WebCallOptions;

    expect(mergedOptions.metadata, metadata);
    expect(mergedOptions.bypassCorsPreflight, true);
    expect(mergedOptions.withCredentials, true);
  });

  test(
    'Cancelling a call correctly complete headers future',
    () async {
      final clientCall = harness.client.unary(dummyValue);

      Future.delayed(
        Duration(milliseconds: cancelDurationMillis),
      ).then((_) => clientCall.cancel());

      expect(await clientCall.headers, isEmpty);

      await expectLater(
        clientCall,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.codeName,
            'Test codename',
            contains('CANCELLED'),
          ),
        ),
      );
    },
  );

  test(
    'Cancelling a call correctly complete trailers futures',
    () async {
      final clientCall = harness.client.unary(dummyValue);

      Future.delayed(
        Duration(milliseconds: cancelDurationMillis),
      ).then((_) {
        clientCall.cancel();
      });

      expect(
        await clientCall.trailers,
        isEmpty,
      );

      await expectLater(
        clientCall,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.codeName,
            'Test codename',
            contains('CANCELLED'),
          ),
        ),
      );
    },
  );
}
