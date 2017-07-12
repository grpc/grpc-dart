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
  ClientHarness harness;

  setUp(() {
    harness = new ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('Unary calls work end-to-end', () async {
    void _handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(data.data.length, 17);

      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage(
            GrpcHttpEncoder.frame(new List.filled(19, 0))))
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runTest(
      clientCall: harness.client.unary(17),
      expectedResult: 19,
      expectedPath: '/Test/Unary',
      serverHandlers: [_handleRequest],
    );
  });

  test('Client-streaming calls work end-to-end', () async {
    void _handleFirstRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(data.data.length, 17);
    }

    void _handleSecondRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(data.data.length, 3);

      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage(
            GrpcHttpEncoder.frame(new List.filled(12, 0))))
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runTest(
      clientCall:
          harness.client.clientStreaming(new Stream.fromIterable([17, 3])),
      expectedResult: 12,
      expectedPath: '/Test/ClientStreaming',
      serverHandlers: [_handleFirstRequest, _handleSecondRequest],
    );
  });

  test('Server-streaming calls work end-to-end', () async {
    void handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(data.data.length, 4);

      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(
            new DataStreamMessage(GrpcHttpEncoder.frame(new List.filled(3, 0))))
        ..add(new DataStreamMessage(
            GrpcHttpEncoder.frame(new List.filled(17, 0))))
        ..add(
            new DataStreamMessage(GrpcHttpEncoder.frame(new List.filled(9, 0))))
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runTest(
      clientCall: harness.client.serverStreaming(4).toList(),
      expectedResult: [3, 17, 9],
      expectedPath: '/Test/ServerStreaming',
      serverHandlers: [handleRequest],
    );
  });

  test('Bidirectional calls work end-to-end', () async {
    void handleRequest(StreamMessage message) {
      expect(message, new isInstanceOf<DataStreamMessage>());
      expect(message.endStream, false);
      final data = new GrpcHttpDecoder().convert(message) as GrpcData;
      expect(data.data.length, 4);

      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(
            new DataStreamMessage(GrpcHttpEncoder.frame(new List.filled(3, 0))))
        ..add(new DataStreamMessage(
            GrpcHttpEncoder.frame(new List.filled(17, 0))))
        ..add(
            new DataStreamMessage(GrpcHttpEncoder.frame(new List.filled(9, 0))))
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runTest(
      clientCall: harness.client.serverStreaming(4).toList(),
      expectedResult: [3, 17, 9],
      expectedPath: '/Test/ServerStreaming',
      serverHandlers: [handleRequest],
    );
  });

  test('Unary call with no response throws error', () async {
    void handleRequest(_) {
      harness.toClient
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException: new GrpcError.unimplemented('No responses received'),
      serverHandlers: [handleRequest],
    );
  });

  test('Unary call with more than one response throws error', () async {
    void handleRequest(_) {
      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage(GrpcHttpEncoder.frame([])))
        ..add(new DataStreamMessage(GrpcHttpEncoder.frame([])))
        ..add(new HeadersStreamMessage([], endStream: true))
        ..close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
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
      clientCall: harness.client.unary(4),
      expectedException: new GrpcError.unavailable('Did not receive anything'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if trailers are missing', () async {
    void handleRequest(_) {
      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage(GrpcHttpEncoder.frame([])))
        ..close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException: new GrpcError.unavailable('Missing trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if data is received before headers', () async {
    void handleRequest(_) {
      harness.toClient.add(new DataStreamMessage(GrpcHttpEncoder.frame([])));
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException:
          new GrpcError.unimplemented('Received data before headers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if data is received after trailers', () async {
    void handleRequest(_) {
      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage(GrpcHttpEncoder.frame([])));
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException:
          new GrpcError.unimplemented('Received data after trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if multiple trailers are received', () async {
    void handleRequest(_) {
      harness.toClient
        ..add(new HeadersStreamMessage([]))
        ..add(new HeadersStreamMessage([]))
        ..add(new HeadersStreamMessage([]));
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException:
          new GrpcError.unimplemented('Received multiple trailers'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws if non-zero status is received', () async {
    void handleRequest(_) {
      harness.toClient.add(new HeadersStreamMessage([
        new Header.ascii('grpc-status', '17'),
        new Header.ascii('grpc-message', 'Custom message')
      ], endStream: true));
      harness.toClient.close();
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
      expectedException: new GrpcError.custom(17, 'Custom message'),
      serverHandlers: [handleRequest],
    );
  });

  test('Call throws on response stream errors', () async {
    void handleRequest(_) {
      harness.toClient.addError('Test error');
    }

    await harness.runFailureTest(
      clientCall: harness.client.unary(4),
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
      clientCall: harness.client.unary(4),
      expectedException: expectedException,
      serverHandlers: [handleRequest],
    );
  });

  test('Connection errors are reported', () async {
    reset(harness.channel);
    when(harness.channel.connect()).thenThrow('Connection error');
    final expectedError =
        new GrpcError.unavailable('Error connecting: Connection error');
    harness.expectThrows(harness.client.unary(4), expectedError);
    harness.expectThrows(
        harness.client.serverStreaming(4).toList(), expectedError);
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
