// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'package:grpc/src/streams.dart';

void main() {
  group('GrpcHttpDecoder', () {
    StreamController<StreamMessage> input;
    Stream<GrpcMessage> output;

    setUp(() {
      input = new StreamController();
      output = input.stream.transform(new GrpcHttpDecoder());
    });

    test('throws error if data is received before headers', () async {
      input.add(new DataStreamMessage([0]));
      input.close();
      try {
        await output.toList();
        fail('Did not throw exception');
      } on GrpcError catch (e) {
        expect(e.code, 103);
        expect(e.message, 'Received data before header metadata');
      }
    });

    test('converts chunked data correctly', () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([0, 0]))
        ..add(new DataStreamMessage([0, 0, 10, 48, 49]))
        ..add(new DataStreamMessage([50, 51, 52, 53]))
        ..add(new DataStreamMessage([54, 55, 56, 57, 0, 0, 0]))
        ..add(new DataStreamMessage(
            [0, 4, 97, 98, 99, 100, 0, 0, 0, 0, 1, 65, 0, 0, 0, 0]))
        ..add(new DataStreamMessage([4, 48, 49, 50, 51, 1, 0, 0, 1, 0]))
        ..add(new DataStreamMessage(new List.filled(256, 90)));
      input.close();
      final converted = await result;
      expect(converted.length, 6);

      void verify(GrpcData message, List<int> expected) {
        expect(message.data, expected);
      }

      expect(converted[0], new isInstanceOf<GrpcMetadata>());
      verify(converted[1], [48, 49, 50, 51, 52, 53, 54, 55, 56, 57]);
      verify(converted[2], [97, 98, 99, 100]);
      verify(converted[3], [65]);
      verify(converted[4], [48, 49, 50, 51]);
      verify(converted[5], new List.filled(256, 90));
    });

    test('throws error if data is received after trailers', () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([]));
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, 102);
        expect(e.message, 'Received data after trailer metadata');
      }
    });

    test('throws error if input is closed while receiving data header',
        () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([0, 0, 0]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, 105);
        expect(e.message, 'Closed in non-idle state');
      }
    });

    test('throws error if input is closed while receiving data', () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([0, 0, 0, 0, 2, 1]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, 105);
        expect(e.message, 'Closed in non-idle state');
      }
    });

    test('throws error if receiving metadata while reading data header',
        () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([0, 0, 0, 0]))
        ..add(new HeadersStreamMessage([]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, 101);
        expect(e.message, 'Received header while reading header at offset 4');
      }
    });

    test('throws error if receiving metadata while reading data', () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([0, 0, 0, 0, 2, 1]))
        ..add(new HeadersStreamMessage([]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, 101);
        expect(e.message,
            'Received header while reading data (2 bytes) at offset 1');
      }
    });

    test('discards empty data frames, but not empty gRPC frames', () async {
      final result = output.toList();
      input
        ..add(new HeadersStreamMessage([]))
        ..add(new DataStreamMessage([]))
        ..add(new DataStreamMessage([0, 0, 0, 0, 2, 0, 1]))
        ..add(new DataStreamMessage([0, 0, 0, 0, 0]))
        ..close();
      final converted = await result;
      expect(converted.length, 3);
      expect(converted[0], new isInstanceOf<GrpcMetadata>());
      expect(converted[1], new isInstanceOf<GrpcData>());
      var data = converted[1] as GrpcData;
      expect(data.data.length, 2);
      expect(converted[2], new isInstanceOf<GrpcData>());
      data = converted[2] as GrpcData;
      expect(data.data.length, 0);
    });
  });
}
