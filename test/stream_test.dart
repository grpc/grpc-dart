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
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:grpc/src/shared/streams.dart';
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

    test(
      'returns zero-copy Uint8List views when complete frames arrive in one chunk',
      () async {
        final wireChunk = Uint8List.fromList([
          // Frame 1: uncompressed, length 4, payload [10, 20, 30, 40]
          0, 0, 0, 0, 4, 10, 20, 30, 40,
          // Frame 2: compressed, length 2, payload [99, 100]
          1, 0, 0, 0, 2, 99, 100,
        ]);
        final result = output.toList();
        input
          ..add(HeadersStreamMessage([]))
          ..add(DataStreamMessage(wireChunk))
          ..close();

        final converted = await result;
        expect(converted, hasLength(3));

        final frame1 = converted[1] as GrpcData;
        expect(frame1.isCompressed, isFalse);
        expect(frame1.data, [10, 20, 30, 40]);
        expect(frame1.data, isA<Uint8List>());
        final view1 = frame1.data as Uint8List;
        expect(view1.offsetInBytes, 5);

        final frame2 = converted[2] as GrpcData;
        expect(frame2.isCompressed, isTrue);
        expect(frame2.data, [99, 100]);
        expect(frame2.data, isA<Uint8List>());
        final view2 = frame2.data as Uint8List;
        expect(view2.offsetInBytes, 14);

        // Mutating the underlying wire buffer reflects directly in the views,
        // confirming no intermediate payload copy occurred.
        wireChunk[5] = 77;
        wireChunk[14] = 88;
        expect(view1[0], 77);
        expect(view2[0], 88);
      },
    );

    test(
      'handles non-Uint8List chunks, 1-byte split headers, and trailing coalesced frames',
      () async {
        final result = output.toList();
        input
          ..add(HeadersStreamMessage([]))
          // Non-Uint8List List<int> containing a complete frame
          ..add(
            DataStreamMessage(List<int>.unmodifiable([0, 0, 0, 0, 2, 7, 8])),
          )
          // 5-byte header split 1 byte at a time (compressed=true, length=3)
          ..add(DataStreamMessage(Uint8List.fromList([1])))
          ..add(DataStreamMessage(Uint8List.fromList([0])))
          ..add(DataStreamMessage(Uint8List.fromList([0])))
          ..add(DataStreamMessage(Uint8List.fromList([0])))
          ..add(DataStreamMessage(Uint8List.fromList([3])))
          // First byte of payload, then remaining 2 bytes + a complete frame in the same chunk
          ..add(DataStreamMessage(Uint8List.fromList([11])))
          ..add(
            DataStreamMessage(
              Uint8List.fromList([12, 13, 0, 0, 0, 0, 3, 21, 22, 23]),
            ),
          )
          ..close();

        final converted = await result;
        expect(converted, hasLength(4));

        final f1 = converted[1] as GrpcData;
        expect(f1.isCompressed, isFalse);
        expect(f1.data, [7, 8]);

        final f2 = converted[2] as GrpcData;
        expect(f2.isCompressed, isTrue);
        expect(f2.data, [11, 12, 13]);

        final f3 = converted[3] as GrpcData;
        expect(f3.isCompressed, isFalse);
        expect(f3.data, [21, 22, 23]);
      },
    );
  });

  // GzipCodec is not supported on the web.
  group('GrpcDecompressingHttpDecoder', () {
    final registry = CodecRegistry(codecs: const [GzipCodec()]);

    Future<List<GrpcMessage>> decode(List<StreamMessage> messages) =>
        Stream.fromIterable(messages)
            .transform(GrpcDecompressingHttpDecoder(codecRegistry: registry))
            .toList();

    test(
      'decompresses messages with the codec named by grpc-encoding',
      () async {
        final messages = await decode([
          HeadersStreamMessage([Header.ascii('grpc-encoding', 'gzip')]),
          DataStreamMessage(frame([1, 2, 3], const GzipCodec())),
          DataStreamMessage(frame([4, 5])),
        ]);
        expect(messages, hasLength(3));
        final first = messages[1] as GrpcData;
        expect(first.isCompressed, isFalse);
        expect(first.data, [1, 2, 3]);
        final second = messages[2] as GrpcData;
        expect(second.isCompressed, isFalse);
        expect(second.data, [4, 5]);
      },
    );

    test('fails compressed messages without a known codec', () async {
      expect(
        decode([
          HeadersStreamMessage([Header.ascii('grpc-encoding', 'unknown')]),
          DataStreamMessage(frame([1, 2, 3], const GzipCodec())),
        ]),
        throwsA(
          isA<GrpcError>().having(
            (e) => e.code,
            'code',
            StatusCode.unimplemented,
          ),
        ),
      );
    });
  }, testOn: 'vm');
}
