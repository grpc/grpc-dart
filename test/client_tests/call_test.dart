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

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/call.dart';
import 'package:grpc/src/client/transport/http2_transport.dart';
import 'package:grpc/src/shared/profiler.dart';
import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/client_utils.dart';
import '../src/utils.dart';

void main() {
  const dummyValue = 0;
  const cancelDurationMillis = 300;
  final unaryMethod = ClientMethod<int, int>(
    '/Test/Unary',
    mockEncode,
    mockDecode,
  );
  final streamingMethod = ClientMethod<int, int>(
    '/Test/Bidirectional',
    mockEncode,
    mockDecode,
  );

  late ClientHarness harness;

  setUp(() {
    harness = ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('WebCallOptions mergeWith CallOptions returns WebCallOptions', () {
    final options1 = WebCallOptions(
      bypassCorsPreflight: true,
      withCredentials: true,
    );
    final metadata = {'test': '42'};
    final options2 = CallOptions(metadata: metadata);
    final mergedOptions1 = options1.mergedWith(options2) as WebCallOptions;
    final mergedOptions2 = options2.mergedWith(options1) as WebCallOptions;

    expect(mergedOptions1.metadata, metadata);
    expect(mergedOptions1.bypassCorsPreflight, true);
    expect(mergedOptions1.withCredentials, true);

    expect(mergedOptions2.metadata, metadata);
    expect(mergedOptions2.bypassCorsPreflight, true);
    expect(mergedOptions2.withCredentials, true);
  });

  test('Cancelling a call correctly complete headers future', () async {
    final clientCall = harness.client.unary(dummyValue);

    Future.delayed(Duration(milliseconds: cancelDurationMillis))
        .then((_) => clientCall.cancel());

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
  });

  test('Cancelling a call correctly complete trailers futures', () async {
    final clientCall = harness.client.unary(dummyValue);

    Future.delayed(Duration(milliseconds: cancelDurationMillis)).then((_) {
      clientCall.cancel();
    });

    expect(await clientCall.trailers, isEmpty);

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
  });

  test(
    'Abnormal closure of HTTP/2 outgoing stream does not throw StateError',
    () async {
      final requests = StreamController<int>();
      final sentMessages = <StreamMessage>[];
      final fromClientSubscription = harness.fromClient.stream.listen(
        sentMessages.add,
      );
      final call = harness.channel.createCall(
        streamingMethod,
        requests.stream,
        CallOptions(),
      );
      final subscription = call.response.listen((_) {}, onError: (_) {});

      requests.add(1);
      await pumpEventQueue();
      expect(sentMessages, hasLength(1));

      // Simulate abnormal HTTP/2 stream closure closing outgoingMessages
      // without invoking onTerminated.
      await harness.fromClient.close();

      requests.add(2);
      requests.add(3);
      await requests.close();
      await pumpEventQueue();

      expect(sentMessages, hasLength(1));
      await subscription.cancel();
      await fromClientSubscription.cancel();
    },
  );

  test(
    'Http2TransportStream handles abnormal sink closure on data, error, close',
    () async {
      final fromClientSubscription = harness.fromClient.stream.listen((_) {});
      final transportStream = Http2TransportStream(
        harness.stream,
        (error, stackTrace) => Error.throwWithStackTrace(error, stackTrace),
        null,
        null,
      );
      await harness.fromClient.close();

      transportStream.outgoingMessages.add([1, 2, 3]);
      await transportStream.outgoingMessages.close();
      await pumpEventQueue();
      await transportStream.terminate();

      final errorTransportStream = Http2TransportStream(
        harness.stream,
        (error, stackTrace) => Error.throwWithStackTrace(error, stackTrace),
        null,
        null,
      );
      errorTransportStream.outgoingMessages.addError(
        StateError('request error'),
      );
      await pumpEventQueue();
      await errorTransportStream.terminate();
      await fromClientSubscription.cancel();
    },
  );

  test(
    'HTTP/2 stream onTerminated cancels outgoing subscription cleanly',
    () async {
      final requests = StreamController<int>();
      final sentMessages = <StreamMessage>[];
      final fromClientSubscription = harness.fromClient.stream.listen(
        sentMessages.add,
      );
      final call = harness.channel.createCall(
        streamingMethod,
        requests.stream,
        CallOptions(),
      );
      final subscription = call.response.listen((_) {}, onError: (_) {});

      requests.add(1);
      await pumpEventQueue();
      expect(sentMessages, hasLength(1));

      final onTerminated =
          verify(harness.stream.onTerminated = captureAny).captured.single
              as void Function(int?);
      onTerminated(8);

      requests.add(2);
      await requests.close();
      await pumpEventQueue();

      expect(sentMessages, hasLength(1));
      await subscription.cancel();
      await fromClientSubscription.cancel();
    },
  );

  test('Completed ClientCall cancels request subscription without marking cancelled', () async {
    isTimelineLoggingEnabled = true;
    addTearDown(() => isTimelineLoggingEnabled = false);

    final requests = StreamController<int>();
    final call = harness.channel.createCall(
      streamingMethod,
      requests.stream,
      CallOptions(),
    );
    final responseFuture = ResponseFuture(call);

    await pumpEventQueue();
    expect(requests.hasListener, isTrue);

    harness.sendResponseHeader();
    harness.sendResponseValue(42);
    harness.sendResponseTrailer();

    expect(await responseFuture, 42);
    await pumpEventQueue();
    expect(requests.hasListener, isFalse);
    expect(harness.fromClient.isClosed, isTrue);
    expect(call.isCancelled, isFalse);
    verifyNever(harness.stream.terminate());
    await requests.close();
  });

  test(
    'Errored ClientCall is not marked as cancelled or throwing StateError',
    () async {
      isTimelineLoggingEnabled = true;
      addTearDown(() => isTimelineLoggingEnabled = false);

      final call = harness.channel.createCall(
        unaryMethod,
        Stream.value(dummyValue),
        CallOptions(),
      );
      final responseFuture = ResponseFuture(call);

      await pumpEventQueue();
      harness.sendResponseHeader();
      harness.toClient.addError(GrpcError.internal('internal failure'));
      await harness.toClient.close();

      await expectLater(
        responseFuture,
        throwsA(
          isA<GrpcError>().having((e) => e.code, 'code', StatusCode.internal),
        ),
      );
      await pumpEventQueue();
      expect(await call.headers, isNotEmpty);
      expect(await call.trailers, isEmpty);
      expect(call.isCancelled, isFalse);
    },
  );

  test(
    'Early response error before headers completes headers and trailers',
    () async {
      final call = harness.channel.createCall(
        unaryMethod,
        Stream.value(dummyValue),
        CallOptions(),
      );
      final responseFuture = ResponseFuture(call);

      await pumpEventQueue();
      await harness.toClient.close();

      await expectLater(
        responseFuture,
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unavailable,
          ),
        ),
      );
      expect(await call.headers, isEmpty);
      expect(await call.trailers, isEmpty);
      expect(call.isCancelled, isFalse);
    },
  );

  test(
    'Request stream error completes headers and trailers without cancelling',
    () async {
      final call = harness.channel.createCall(
        streamingMethod,
        Stream<int>.error(StateError('request failure')),
        CallOptions(),
      );
      final responseFuture = ResponseFuture(call);

      await expectLater(
        responseFuture,
        throwsA(
          isA<GrpcError>().having((e) => e.code, 'code', StatusCode.unknown),
        ),
      );
      expect(await call.headers, isEmpty);
      expect(await call.trailers, isEmpty);
      expect(call.isCancelled, isFalse);
    },
  );

  test(
    'Cancelling response subscription terminates call without StateError',
    () async {
      isTimelineLoggingEnabled = true;
      addTearDown(() => isTimelineLoggingEnabled = false);

      final requests = StreamController<int>();
      final errors = <Object>[];
      final call = harness.channel.createCall(
        streamingMethod,
        requests.stream,
        CallOptions(),
      );
      final subscription = call.response.listen((_) {}, onError: errors.add);

      requests.add(1);
      await pumpEventQueue();

      await subscription.cancel();

      requests.add(2);
      await requests.close();
      await pumpEventQueue();

      expect(call.isCancelled, isTrue);
      expect(errors, isEmpty);
      expect(await call.headers, isEmpty);
      expect(await call.trailers, isEmpty);
      verify(harness.stream.terminate()).called(1);

      // Explicit cancel() on an already-closed call is a safe no-op.
      await call.cancel();
    },
  );

  test('Cancelling response subscription before metadata resolves skips makeRequest', () async {
    isTimelineLoggingEnabled = true;
    addTearDown(() => isTimelineLoggingEnabled = false);

    final metadataCompleter = Completer<void>();
    final call = harness.channel.createCall(
      unaryMethod,
      Stream.value(dummyValue),
      CallOptions(providers: [(_, _) => metadataCompleter.future]),
    );
    final subscription = call.response.listen((_) {}, onError: (_) {});

    await subscription.cancel();
    metadataCompleter.complete();
    await pumpEventQueue();

    expect(call.isCancelled, isTrue);
    expect(await call.headers, isEmpty);
    expect(await call.trailers, isEmpty);
    verifyNever(
      harness.transport.makeRequest(any, endStream: anyNamed('endStream')),
    );
  });
}
