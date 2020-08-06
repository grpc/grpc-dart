import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/interceptor.dart';
import 'package:test/test.dart';
import 'package:http2/transport.dart';

import '../src/client_utils.dart';
import '../src/utils.dart';

class FakeInterceptor
    implements ClientUnaryInterceptor, ClientStreamingInterceptor {
  final _id;
  static int _unary = 0;
  static int _streaming = 0;

  FakeInterceptor(this._id);

  @override
  ResponseFuture interceptUnary(ClientMethod method, dynamic request,
      CallOptions options, ClientUnaryInvoker invoker) {
    _unary++;

    return invoker(method, request, _inject(options));
  }

  @override
  ResponseStream interceptStreaming(ClientMethod method, Stream requests,
      CallOptions options, ClientStreamingInvoker invoker) {
    _streaming++;

    return invoker(method, requests, _inject(options));
  }

  CallOptions _inject(CallOptions options) {
    var value = options.metadata["x-interceptor"];
    if (value == null) {
      value = toString();
    } else {
      value += ', ' + toString();
    }

    return options.mergedWith(CallOptions(metadata: {"x-interceptor": value}));
  }

  static void tearDown() {
    _unary = 0;
    _streaming = 0;
  }

  String toString() {
    return '{id: ${_id}, unary: ${_unary}, streaming: ${_streaming}}';
  }
}

main() {
  test('single unary interceptor', () async {
    final harness = ClientHarness()
      ..unaryInterceptors = [FakeInterceptor(1)]
      ..setUp();

    const requestValue = 17;
    const responseValue = 19;

    void handleRequest(StreamMessage message) {
      final data = validateDataMessage(message);
      expect(mockDecode(data.data), requestValue);

      harness
        ..sendResponseHeader()
        ..sendResponseValue(responseValue)
        ..sendResponseTrailer();
    }

    await harness.runTest(
      clientCall: harness.client.unary(requestValue),
      expectedResult: responseValue,
      expectedPath: '/Test/Unary',
      expectedCustomHeaders: {
        "x-interceptor": "{id: 1, unary: 1, streaming: 0}"
      },
      serverHandlers: [handleRequest],
    );

    harness.tearDown();
    FakeInterceptor.tearDown();
  });

  test('multiple unary interceptors', () async {
    final harness = ClientHarness()
      ..unaryInterceptors = [FakeInterceptor(1), FakeInterceptor(2)]
      ..setUp();

    const requestValue = 17;
    const responseValue = 19;

    void handleRequest(StreamMessage message) {
      final data = validateDataMessage(message);
      expect(mockDecode(data.data), requestValue);

      harness
        ..sendResponseHeader()
        ..sendResponseValue(responseValue)
        ..sendResponseTrailer();
    }

    await harness.runTest(
      clientCall: harness.client.unary(requestValue),
      expectedResult: responseValue,
      expectedPath: '/Test/Unary',
      expectedCustomHeaders: {
        "x-interceptor":
            "{id: 1, unary: 1, streaming: 0}, {id: 2, unary: 2, streaming: 0}"
      },
      serverHandlers: [handleRequest],
    );

    harness.tearDown();
    FakeInterceptor.tearDown();
  });

  test('single streaming interceptor', () async {
    final harness = ClientHarness()
      ..streamingInterceptors = [FakeInterceptor(1)]
      ..setUp();

    const requests = [1, 15, 7];
    const responses = [3, 17, 9];

    var index = 0;

    void handleRequest(StreamMessage message) {
      final data = validateDataMessage(message);
      expect(mockDecode(data.data), requests[index]);

      if (index == 0) {
        harness.sendResponseHeader();
      }
      harness.sendResponseValue(responses[index]);
      index++;
    }

    void handleDone() {
      harness.sendResponseTrailer();
    }

    await harness.runTest(
      clientCall:
          harness.client.bidirectional(Stream.fromIterable(requests)).toList(),
      expectedResult: responses,
      expectedPath: '/Test/Bidirectional',
      expectedCustomHeaders: {
        "x-interceptor": "{id: 1, unary: 0, streaming: 1}"
      },
      serverHandlers: [handleRequest, handleRequest, handleRequest],
      doneHandler: handleDone,
    );

    harness.tearDown();
    FakeInterceptor.tearDown();
  });

  test('multiple streaming interceptors', () async {
    final harness = ClientHarness()
      ..streamingInterceptors = [FakeInterceptor(1), FakeInterceptor(2)]
      ..setUp();

    const requests = [1, 15, 7];
    const responses = [3, 17, 9];

    var index = 0;

    void handleRequest(StreamMessage message) {
      final data = validateDataMessage(message);
      expect(mockDecode(data.data), requests[index]);

      if (index == 0) {
        harness.sendResponseHeader();
      }
      harness.sendResponseValue(responses[index]);
      index++;
    }

    void handleDone() {
      harness.sendResponseTrailer();
    }

    await harness.runTest(
      clientCall:
          harness.client.bidirectional(Stream.fromIterable(requests)).toList(),
      expectedResult: responses,
      expectedPath: '/Test/Bidirectional',
      expectedCustomHeaders: {
        "x-interceptor":
            "{id: 1, unary: 0, streaming: 1}, {id: 2, unary: 0, streaming: 2}"
      },
      serverHandlers: [handleRequest, handleRequest, handleRequest],
      doneHandler: handleDone,
    );

    harness.tearDown();
    FakeInterceptor.tearDown();
  });
}
