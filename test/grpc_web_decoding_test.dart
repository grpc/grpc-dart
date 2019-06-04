import 'dart:async';
import 'dart:typed_data';

import 'package:grpc/src/client/transport/web_streams.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:test/test.dart';

main() {
  test("decoding an empty repeated", () async {
    final GrpcData data = await GrpcWebDecoder()
        .bind(Stream.fromIterable([
          Uint8List.fromList([0, 0, 0, 0, 0]).buffer
        ]))
        .first as GrpcData;
    expect(data.data, []);
  });
}
