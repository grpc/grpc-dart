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

@TestOn('vm')
library;

import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/channel.dart' hide ClientChannel;
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:test/test.dart';

import 'common.dart';

class TestClient extends Client {
  static final _$stream = ClientMethod<int, int>(
    '/test.TestService/stream',
    (int value) => [value],
    (List<int> value) => value[0],
  );

  TestClient(super.channel);

  ResponseStream<int> stream(int request, {CallOptions? options}) {
    return $createStreamingCall(
      _$stream,
      Stream.value(request),
      options: options,
    );
  }
}

class TestService extends Service {
  final String? expectedAuthority;

  @override
  String get $name => 'test.TestService';

  TestService({this.expectedAuthority}) {
    $addMethod(
      ServiceMethod<int, int>(
        'stream',
        stream,
        false,
        true,
        (List<int> value) => value[0],
        (int value) => [value],
      ),
    );
  }

  static const requestFiniteStream = 1;
  static const requestInfiniteStream = 2;

  Stream<int> stream(ServiceCall call, Future request) async* {
    checkMetadata(call.clientMetadata);

    final isInfinite = 2 == await request;
    for (var i = 1; i <= 3 || isInfinite; i++) {
      yield i;
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  void checkMetadata(Map<String, String>? metadata) {
    if (expectedAuthority != null) {
      expect(metadata![':authority'], equals(expectedAuthority));
    }
  }
}

class TestServiceWithOnMetadataException extends TestService {
  @override
  void $onMetadata(ServiceCall context) {
    throw Exception('business exception');
  }
}

class TestServiceWithGrpcError extends TestService {
  @override
  Stream<int> stream(ServiceCall call, Future request) async* {
    throw GrpcError.custom(
      StatusCode.internal,
      'This error should contain trailers',
      null,
      null,
      {'key1': 'value1', 'key2': 'value2'},
    );
  }
}

class FixedConnectionClientChannel extends ClientChannelBase {
  final Http2ClientConnection clientConnection;
  List<ConnectionState> states = <ConnectionState>[];

  FixedConnectionClientChannel(this.clientConnection) {
    onConnectionStateChanged.listen((state) => states.add(state));
  }

  @override
  ClientConnection createConnection() => clientConnection;
}

Future<void> main() async {
  testTcpAndUds('round trip insecure connection', (address) async {
    // round trip test of insecure connection.
    final server = Server.create(services: [TestService()]);
    await server.serve(address: address, port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    );
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestFiniteStream).toList(), [
      1,
      2,
      3,
    ]);
    server.shutdown();
  });

  testUds('UDS provides valid default authority', (address) async {
    // round trip test of insecure connection.
    final server = Server.create(
      services: [TestService(expectedAuthority: 'localhost')],
    );
    await server.serve(address: address, port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    );
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestFiniteStream).toList(), [
      1,
      2,
      3,
    ]);
    server.shutdown();
  });

  testTcpAndUds('round trip with outgoing and incoming compression', (
    address,
  ) async {
    final server = Server.create(
      services: [TestService()],
      codecRegistry: CodecRegistry(codecs: const [GzipCodec()]),
    );
    await server.serve(address: address, port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(codecs: const [GzipCodec()]),
        ),
      ),
    );
    final testClient = TestClient(channel);
    expect(
      await testClient
          .stream(
            TestService.requestFiniteStream,
            options: CallOptions(compression: const GzipCodec()),
          )
          .toList(),
      [1, 2, 3],
    );
    await server.shutdown();
  });

  testTcpAndUds('round trip secure connection', (address) async {
    // round trip test of secure connection.
    final server = Server.create(services: [TestService()]);
    await server.serve(
      address: address,
      port: 0,
      security: ServerTlsCredentials(
        certificate: File('test/data/localhost.crt').readAsBytesSync(),
        privateKey: File('test/data/localhost.key').readAsBytesSync(),
      ),
    );

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        address,
        server.port!,
        ChannelOptions(
          credentials: ChannelCredentials.secure(
            certificates: File('test/data/localhost.crt').readAsBytesSync(),
            authority: 'localhost',
          ),
        ),
      ),
    );
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestFiniteStream).toList(), [
      1,
      2,
      3,
    ]);
    server.shutdown();
  });

  test('exception in onMetadataException', () async {
    final server = Server.create(
      services: [TestServiceWithOnMetadataException()],
    );
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        'localhost',
        server.port!,
        ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    );
    final testClient = TestClient(channel);
    await expectLater(
      testClient.stream(TestService.requestFiniteStream).toList(),
      throwsA(isA<GrpcError>()),
    );
    await server.shutdown();
  });

  test('cancellation of streaming subscription propagates properly', () async {
    final server = Server.create(services: [TestService()]);
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        'localhost',
        server.port!,
        ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    );
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestInfiniteStream).first, 1);
    await channel.shutdown();
    await server.shutdown();
  });

  test('trailers on server GrpcError', () async {
    final server = Server.create(services: [TestServiceWithGrpcError()]);
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(
      Http2ClientConnection(
        'localhost',
        server.port!,
        ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    );
    final testClient = TestClient(channel);
    await expectLater(
      testClient.stream(TestService.requestFiniteStream).toList(),
      throwsA(
        predicate<GrpcError>((e) {
          final trailers = e.trailers;
          if (trailers == null || trailers.length != 2) return false;
          final entries = trailers.entries.toList();
          final isOk =
              entries[0].key == 'key1' &&
              entries[0].value == 'value1' &&
              entries[1].key == 'key2' &&
              entries[1].value == 'value2';
          return isOk;
        }),
      ),
    );
    await server.shutdown();
  });
}
