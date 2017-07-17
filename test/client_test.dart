// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:grpc/src/status.dart';
import 'package:grpc/src/streams.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'src/client_utils.dart';

void main() {
  const dummyValue = 0;

  ClientHarness harness;

  setUp(() {
    harness = new ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('Unary calls work end-to-end', () async {
    const requestValue = 17;
    const responseValue = 19;

    void _handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
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
      serverHandlers: [_handleRequest],
    );
  });

  test('Client-streaming calls work end-to-end', () async {
    const requests = const [17, 3];
    const response = 12;

    var index = 0;

    void handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(mockDecode(data.data), requests[index++]);
    }

    void handleDone() {
      harness
        ..sendResponseHeader()
        ..sendResponseValue(response)
        ..sendResponseTrailer();
    }

    await harness.runTest(
      clientCall:
          harness.client.clientStreaming(new Stream.fromIterable(requests)),
      expectedResult: response,
      expectedPath: '/Test/ClientStreaming',
      serverHandlers: [handleRequest, handleRequest],
      doneHandler: handleDone,
    );
  });

  test('Server-streaming calls work end-to-end', () async {
    const request = 4;
    const responses = const [3, 17, 9];

    void handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(mockDecode(data.data), request);

      harness.sendResponseHeader();
      responses.forEach(harness.sendResponseValue);
      harness.sendResponseTrailer();
    }

    await harness.runTest(
      clientCall: harness.client.serverStreaming(request).toList(),
      expectedResult: responses,
      expectedPath: '/Test/ServerStreaming',
      serverHandlers: [handleRequest],
    );
  });

  test('Bidirectional calls work end-to-end', () async {
    const requests = const [1, 15, 7];
    const responses = const [3, 17, 9];

    var index = 0;

    void handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
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
      clientCall: harness.client
          .bidirectional(new Stream.fromIterable(requests))
          .toList(),
      expectedResult: responses,
      expectedPath: '/Test/Bidirectional',
      serverHandlers: [handleRequest, handleRequest, handleRequest],
      doneHandler: handleDone,
    );
  });

  test('Unary call with no response throws error', () async {
    void handleRequest(_) {
      harness.sendResponseTrailer();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException: new GrpcError.unimplemented('No responses received'),
      serverHandlers: [handleRequest],
    );
  });

  test('Unary call with more than one response throws error', () async {
    void handleRequest(_) {
      harness
        ..sendResponseHeader()
        ..sendResponseValue(dummyValue)
        ..sendResponseValue(dummyValue)
        ..sendResponseTrailer();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException:
          new GrpcError.unimplemented('More than one response received'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if nothing is received', () async {
    void handleRequest(_) {
      harness.toClient.close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException: new GrpcError.unavailable('Did not receive anything'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if trailers are missing', () async {
    void handleRequest(_) {
      harness
        ..sendResponseHeader()
        ..sendResponseValue(dummyValue)
        ..toClient.close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException: new GrpcError.unavailable('Missing trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if data is received before headers', () async {
    void handleRequest(_) {
      harness.sendResponseValue(dummyValue);
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException:
          new GrpcError.unimplemented('Received data before headers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if data is received after trailers', () async {
    void handleRequest(_) {
      harness
        ..sendResponseHeader()
        ..sendResponseTrailer(closeStream: false)
        ..sendResponseValue(dummyValue);
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException:
          new GrpcError.unimplemented('Received data after trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if multiple trailers are received', () async {
    void handleRequest(_) {
      harness
        ..sendResponseHeader()
        ..sendResponseTrailer(closeStream: false)
        ..sendResponseTrailer();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException:
          new GrpcError.unimplemented('Received multiple trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if non-zero status is received', () async {
    const customStatusCode = 17;
    const customStatusMessage = 'Custom message';

    void handleRequest(_) {
      harness.toClient.add(new HeadersStreamMessage([
        new Header.ascii('grpc-status', '$customStatusCode'),
        new Header.ascii('grpc-message', customStatusMessage)
      ], endStream: true));
      harness.toClient.close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException:
          new GrpcError.custom(customStatusCode, customStatusMessage),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws on response stream errors', () async {
    void handleRequest(_) {
      harness.toClient.addError('Test error');
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException: new GrpcError.unknown('Test error'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call forwards known response stream errors', () async {
    final expectedException = new GrpcError.dataLoss('Oops!');

    void handleRequest(_) {
      harness.toClient.addError(expectedException);
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(dummyValue),
      expectedException: expectedException,
      serverHandlers: [handleRequest],
    );
  });

  test('Connection errors are reported', () async {
    reset(harness.channel);
    when(harness.channel.connect()).thenThrow('Connection error');
    final expectedError =
        new GrpcError.unavailable('Error connecting: Connection error');
    harness.expectThrows(harness.client.unary(dummyValue), expectedError);
    harness.expectThrows(
        harness.client.serverStreaming(dummyValue).toList(), expectedError);
  });

  test('Known request errors are reported', () async {
    final expectedException = new GrpcError.deadlineExceeded('Too late!');

    Stream<int> requests() async* {
      throw expectedException;
    }

    await harness.runFailureTest(
      clientCall: harness.client.clientStreaming(requests()),
      expectedException: expectedException,
      expectDone: false,
    );
  });

  test('Custom request errors are reported', () async {
    Stream<int> requests() async* {
      throw 'Error';
    }

    final expectedException = new GrpcError.unknown('Error');
    await harness.runFailureTest(
      clientCall: harness.client.clientStreaming(requests()),
      expectedException: expectedException,
      expectDone: false,
    );
  });
}
