// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
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
import 'package:http2/transport.dart';
import 'package:test/test.dart';

void main() {
  group('GrpcHttpDecoder', () {
    late StreamController<StreamMessage> input;
    late Stream<GrpcMessage> output;

    setUp(() {
      input = StreamController();
      output = input.stream.transform(GrpcHttpDecoder(forResponse: false));
    });

    test('converts chunked data correctly', () async {
      final result = output.toList();
      input
        ..add(HeadersStreamMessage([]))
        ..add(DataStreamMessage([0, 0]))
        ..add(DataStreamMessage([0, 0, 10, 48, 49]))
        ..add(DataStreamMessage([50, 51, 52, 53]))
        ..add(DataStreamMessage([54, 55, 56, 57, 0, 0, 0]))
        ..add(
          DataStreamMessage([
            0,
            4,
            97,
            98,
            99,
            100,
            0,
            0,
            0,
            0,
            1,
            65,
            0,
            0,
            0,
            0,
          ]),
        )
        ..add(DataStreamMessage([4, 48, 49, 50, 51, 1, 0, 0, 1, 0]))
        ..add(DataStreamMessage(List.filled(256, 90)));
      input.close();
      final converted = await result;
      expect(converted.length, 6);

      void verify(GrpcData message, List<int> expected) {
        expect(message.data, expected);
      }

      expect(converted[0], TypeMatcher<GrpcMetadata>());
      verify(converted[1] as GrpcData, [
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,
      ]);
      verify(converted[2] as GrpcData, [97, 98, 99, 100]);
      verify(converted[3] as GrpcData, [65]);
      verify(converted[4] as GrpcData, [48, 49, 50, 51]);
      verify(converted[5] as GrpcData, List.filled(256, 90));
    });

    test(
      'throws error if input is closed while receiving data header',
      () async {
        final result = output.toList();
        input
          ..add(HeadersStreamMessage([]))
          ..add(DataStreamMessage([0, 0, 0]))
          ..close();
        try {
          await result;
          fail('Did not throw');
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.unavailable);
          expect(e.message, 'Closed in non-idle state');
        }
      },
    );

    test('throws error if input is closed while receiving data', () async {
      final result = output.toList();
      input
        ..add(HeadersStreamMessage([]))
        ..add(DataStreamMessage([0, 0, 0, 0, 2, 1]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, StatusCode.unavailable);
        expect(e.message, 'Closed in non-idle state');
      }
    });

    test(
      'throws error if receiving metadata while reading data header',
      () async {
        final result = output.toList();
        input
          ..add(HeadersStreamMessage([]))
          ..add(DataStreamMessage([0, 0, 0, 0]))
          ..add(HeadersStreamMessage([]))
          ..close();
        try {
          await result;
          fail('Did not throw');
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.unimplemented);
          expect(e.message, 'Received header while reading data');
        }
      },
    );

    test('throws error if receiving metadata while reading data', () async {
      final result = output.toList();
      input
        ..add(HeadersStreamMessage([]))
        ..add(DataStreamMessage([0, 0, 0, 0, 2, 1]))
        ..add(HeadersStreamMessage([]))
        ..close();
      try {
        await result;
        fail('Did not throw');
      } on GrpcError catch (e) {
        expect(e.code, StatusCode.unimplemented);
        expect(e.message, 'Received header while reading data');
      }
    });

    test('discards empty data frames, but not empty gRPC frames', () async {
      final result = output.toList();
      input
        ..add(HeadersStreamMessage([]))
        ..add(DataStreamMessage([]))
        ..add(DataStreamMessage([0, 0, 0, 0, 2, 0, 1]))
        ..add(DataStreamMessage([0, 0, 0, 0, 0]))
        ..close();
      final converted = await result;
      expect(converted.length, 3);
      expect(converted[0], TypeMatcher<GrpcMetadata>());
      expect(converted[1], TypeMatcher<GrpcData>());
      var data = converted[1] as GrpcData;
      expect(data.data.length, 2);
      expect(converted[2], TypeMatcher<GrpcData>());
      data = converted[2] as GrpcData;
      expect(data.data.length, 0);
    });
  });
}
