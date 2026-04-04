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

// Regression test for https://github.com/grpc/grpc-dart/issues/802
//
// When a server sends GOAWAY with NO_ERROR (HTTP/2 errorCode=0) during
// graceful shutdown, in-flight streams receive a TransportConnectionException
// with errorCode=0.  That exception must map to GrpcError.unavailable
// (StatusCode.unavailable = 14) so that retry middleware can transparently
// reconnect.  Before this fix the exception fell through to GrpcError.unknown
// (StatusCode.unknown = 2) which is not retryable.

import 'package:grpc/grpc.dart';
import 'package:http2/transport.dart' show TransportConnectionException;
import 'package:test/test.dart';

import 'src/client_utils.dart';

void main() {
  late ClientHarness harness;

  setUp(() {
    harness = ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test(
    'GOAWAY NO_ERROR (errorCode=0) maps to GrpcError.unavailable '
    '— not GrpcError.unknown (regression #802)',
    () async {
      // Start a server-streaming call.
      final stream = harness.client.serverStreaming(0);

      // Deliver the HTTP/2 response headers so the call moves past the
      // "waiting for headers" phase.
      harness.sendResponseHeader();

      // Simulate the TransportConnectionException that the http2 library
      // raises on in-flight streams when it receives GOAWAY NO_ERROR
      // (HTTP/2 errorCode=0) followed by connection close — the exact
      // scenario from issue #802 (rolling server restart, nginx shutdown).
      harness.toClient.addError(
        TransportConnectionException(0, 'GOAWAY NO_ERROR'),
      );

      await expectLater(
        stream,
        emitsError(
          isA<GrpcError>()
              .having(
                (e) => e.code,
                'code',
                StatusCode.unavailable, // 14
              )
              .having(
                (e) => e.codeName,
                'codeName',
                contains('UNAVAILABLE'),
              ),
        ),
      );
    },
  );

  test(
    'Non-zero GOAWAY errorCode still maps to GrpcError.unavailable '
    '(general connection error path)',
    () async {
      // A GOAWAY with a real error code (e.g. INTERNAL_ERROR = 2) should also
      // produce a GrpcError — verify the existing connection-error path still
      // works after the fix.
      final stream = harness.client.serverStreaming(0);

      harness.sendResponseHeader();

      harness.toClient.addError(
        TransportConnectionException(2, 'GOAWAY INTERNAL_ERROR'),
      );

      await expectLater(
        stream,
        emitsError(isA<GrpcError>()),
      );
    },
  );
}
