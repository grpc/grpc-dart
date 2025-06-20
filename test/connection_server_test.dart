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
@TestOn('vm')
library;

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'src/server_utils.dart';

void main() {
  const dummyValue = 17;

  late ConnectionServerHarness harness;

  setUp(() {
    harness = ConnectionServerHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('Unary calls work on the server', () async {
    const expectedRequest = 5;
    const expectedResponse = 7;
    Future<int> methodHandler(ServiceCall call, Future<int> request) async {
      expect(await request, expectedRequest);
      return expectedResponse;
    }

    harness
      ..service.unaryHandler = methodHandler
      ..runTest('/Test/Unary', [expectedRequest], [expectedResponse]);
    await harness.fromServer.done;
  });

  test('Client-streaming calls work on the server', () async {
    const expectedRequests = [5, 3, 17];
    const expectedResponse = 12;
    Future<int> methodHandler(ServiceCall call, Stream<int> request) async {
      expect(await request.toList(), expectedRequests);
      return expectedResponse;
    }

    harness
      ..service.clientStreamingHandler = methodHandler
      ..runTest('/Test/ClientStreaming', expectedRequests, [expectedResponse]);
    await harness.fromServer.done;
  });

  test('Server-streaming calls work on the server', () async {
    const expectedRequest = 5;
    const expectedResponses = [7, 9, 1];

    Stream<int> methodHandler(ServiceCall call, Future<int> request) async* {
      expect(await request, expectedRequest);
      for (final value in expectedResponses) {
        yield value;
      }
    }

    harness
      ..service.serverStreamingHandler = methodHandler
      ..runTest('/Test/ServerStreaming', [expectedRequest], expectedResponses);
    await harness.fromServer.done;
  });

  test('Bidirectional calls work on the server', () async {
    const expectedRequests = [3, 1, 7];
    final expectedResponses = expectedRequests.map((v) => v + 5).toList();

    Stream<int> methodHandler(ServiceCall call, Stream<int> request) async* {
      yield* request.map((value) => value + 5);
    }

    harness
      ..service.bidirectionalHandler = methodHandler
      ..runTest('/Test/Bidirectional', expectedRequests, expectedResponses);
    await harness.fromServer.done;
  });

  test('Server returns error on missing call header', () async {
    harness
      ..expectErrorResponse(StatusCode.unimplemented, 'Expected header frame')
      ..sendData(dummyValue);
    await harness.fromServer.done;
  });

  test('Server returns error on invalid path', () async {
    harness
      ..expectErrorResponse(StatusCode.unimplemented, 'Invalid path')
      ..sendRequestHeader('InvalidPath');
    await harness.fromServer.done;
  });

  test('Server returns error on unimplemented path', () async {
    harness
      ..expectErrorResponse(
        StatusCode.unimplemented,
        'Path /Test/NotFound not found',
      )
      ..sendRequestHeader('/Test/NotFound');
    await harness.fromServer.done;
  });

  /// Returns a service method handler that verifies that awaiting the request
  /// throws a specific error.
  Future<int> Function(ServiceCall call, Future<int> request) expectError(
    expectedError,
  ) {
    return expectAsync2((ServiceCall call, Future<int> request) async {
      try {
        final result = await request;
        registerException('Did not throw');
        return result;
      } catch (caughtError) {
        try {
          expect(caughtError, expectedError);
        } catch (failure, stack) {
          registerException(failure, stack);
        }
        rethrow;
      }
    }, count: 1);
  }

  /// Returns a service method handler that verifies that awaiting the request
  /// stream throws a specific error.
  Stream<int> Function(ServiceCall call, Stream<int> request)
  expectErrorStreaming(expectedError) {
    return (ServiceCall call, Stream<int> request) async* {
      try {
        await for (var entry in request) {
          yield entry;
        }
        registerException('Did not throw');
      } catch (caughtError) {
        try {
          expect(caughtError, expectedError);
        } catch (failure, stack) {
          registerException(failure, stack);
        }
        rethrow;
      }
    };
  }

  test('Server returns error on missing request for unary call', () async {
    harness
      ..service.unaryHandler = expectError(
        GrpcError.unimplemented('No request received'),
      )
      ..expectErrorResponse(StatusCode.unimplemented, 'No request received')
      ..sendRequestHeader('/Test/Unary')
      ..toServer.close();
    await harness.fromServer.done;
  });

  test(
    'Server returns error if multiple headers are received for unary call',
    () async {
      harness
        ..service.unaryHandler = expectError(
          GrpcError.unimplemented('Expected request'),
        )
        ..expectErrorResponse(StatusCode.unimplemented, 'Expected request')
        ..sendRequestHeader('/Test/Unary')
        ..toServer.add(HeadersStreamMessage([]))
        ..toServer.close();
      await harness.fromServer.done;
    },
  );

  test('Server returns error on too many requests for unary call', () async {
    harness
      ..service.unaryHandler = expectError(
        GrpcError.unimplemented('Too many requests'),
      )
      ..expectErrorResponse(StatusCode.unimplemented, 'Too many requests')
      ..sendRequestHeader('/Test/Unary')
      ..sendData(dummyValue)
      ..sendData(dummyValue)
      ..toServer.close();
    await harness.fromServer.done;
  });

  test('Server returns request deserialization errors', () async {
    harness
      ..service.bidirectionalHandler = expectErrorStreaming(
        GrpcError.internal('Error deserializing request: Failed'),
      )
      ..expectErrorResponse(
        StatusCode.internal,
        'Error deserializing request: Failed',
      )
      ..sendRequestHeader('/Test/RequestError')
      ..sendData(dummyValue)
      ..toServer.close();
    await harness.fromServer.done;
  });

  test('Server returns response serialization errors', () async {
    harness
      ..service.bidirectionalHandler = expectErrorStreaming(
        GrpcError.internal('Error sending response: Failed'),
      )
      ..expectErrorResponse(
        StatusCode.internal,
        'Error sending response: Failed',
      )
      ..sendRequestHeader('/Test/ResponseError')
      ..sendData(dummyValue)
      ..sendData(dummyValue)
      ..toServer.close();
    await harness.fromServer.done;
  });

  test('Header can only be sent once', () async {
    Future<int> methodHandler(ServiceCall call, Future<int> request) async {
      call.sendHeaders();
      call.sendHeaders();
      return await request;
    }

    harness
      ..service.unaryHandler = methodHandler
      ..expectTrailingErrorResponse(StatusCode.internal, 'Headers already sent')
      ..sendRequestHeader('/Test/Unary');
    await harness.fromServer.done;
  });

  test('Server receives cancel', () async {
    final success = Completer<bool>();

    Future<int> methodHandler(ServiceCall call, Future<int> request) async {
      try {
        final result = await request;
        registerException('Did not throw');
        return result;
      } catch (caughtError) {
        try {
          expect(caughtError, GrpcError.cancelled('Cancelled'));
          expect(call.isCanceled, isTrue);
          success.complete(true);
        } catch (failure, stack) {
          registerException(failure, stack);
        }
      } finally {
        if (!success.isCompleted) {
          success.complete(false);
        }
      }
      return dummyValue;
    }

    harness
      ..service.unaryHandler = methodHandler
      ..fromServer.stream.listen(
        expectAsync1((_) {}, count: 0),
        onError: expectAsync1((dynamic error) {
          expect(error, 'TERMINATED');
        }, count: 1),
        onDone: expectAsync0(() {}, count: 1),
      )
      ..sendRequestHeader('/Test/Unary')
      ..toServer.addError('CANCEL');

    expect(await success.future, isTrue);
    await harness.toServer.close();
    await harness.fromServer.done;
  });

  test(
    'Server returns error if request stream is closed before sending anything',
    () async {
      harness
        ..expectErrorResponse(
          StatusCode.unavailable,
          'Request stream closed unexpectedly',
        )
        ..toServer.close();
      await harness.fromServer.done;
    },
  );

  group('Server with interceptor', () {
    group('processes calls if interceptor allows request', () {
      const expectedRequest = 5;
      const expectedResponse = 7;
      Future<int> methodHandler(ServiceCall call, Future<int> request) async {
        expect(await request, expectedRequest);
        return expectedResponse;
      }

      GrpcError? interceptor(call, method) {
        if (method.name == 'Unary') {
          return null;
        }
        return GrpcError.unauthenticated('Request is unauthenticated');
      }

      Future<void> doTest(Interceptor handler) async {
        harness
          ..interceptor.handler = handler
          ..service.unaryHandler = methodHandler
          ..runTest('/Test/Unary', [expectedRequest], [expectedResponse]);

        await harness.fromServer.done;
      }

      test('with sync interceptor', () => doTest(interceptor));
      test(
        'with async interceptor',
        () => doTest((call, method) async => interceptor(call, method)),
      );
    });

    group('returns error if interceptor blocks request', () {
      GrpcError? interceptor(call, method) {
        if (method.name == 'Unary') {
          return GrpcError.unauthenticated('Request is unauthenticated');
        }
        return null;
      }

      Future<void> doTest(Interceptor handler) async {
        harness
          ..interceptor.handler = handler
          ..expectErrorResponse(
            StatusCode.unauthenticated,
            'Request is unauthenticated',
          )
          ..sendRequestHeader('/Test/Unary');

        await harness.fromServer.done;
      }

      test('with sync interceptor', () => doTest(interceptor));
      test(
        'with async interceptor',
        () => doTest((call, method) async => interceptor(call, method)),
      );
    });

    group('returns internal error if interceptor throws exception', () {
      FutureOr<GrpcError?> interceptor(call, method) {
        throw Exception('Reason is unknown');
      }

      Future<void> doTest(Interceptor handler) async {
        harness
          ..interceptor.handler = handler
          ..expectErrorResponse(
            StatusCode.internal,
            'Exception: Reason is unknown',
          )
          ..sendRequestHeader('/Test/Unary');

        await harness.fromServer.done;
      }

      test('with sync interceptor', () => doTest(interceptor));
      test(
        'with async interceptor',
        () => doTest((call, method) async => interceptor(call, method)),
      );
    });

    test("don't fail if interceptor await 2 times", () async {
      FutureOr<GrpcError?> interceptor(call, method) async {
        await Future.value();
        await Future.value();
        throw Exception('Reason is unknown');
      }

      harness
        ..interceptor.handler = interceptor
        ..expectErrorResponse(
          StatusCode.internal,
          'Exception: Reason is unknown',
        )
        ..sendRequestHeader('/Test/Unary')
        ..sendData(1);

      await harness.fromServer.done;
    });
  });
}
