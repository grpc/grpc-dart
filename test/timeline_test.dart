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
@Skip(
  'Run only as `dart run --enable-vm-service --timeline-streams=Dart test/timeline_test.dart`',
)
library;

import 'dart:async';
import 'dart:developer' as dev;

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/channel.dart' hide ClientChannel;
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:test/test.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

const String path = '/test.TestService/stream';

class TestClient extends Client {
  static final _$stream = ClientMethod<int, int>(
    path,
    (int value) => [value],
    (List<int> value) => value[0],
  );

  TestClient(super.channel);
  ResponseStream<int> stream(int request, {CallOptions? options}) {
    return $createStreamingCall(
      _$stream,
      Stream.fromIterable([request]),
      options: options,
    );
  }
}

class TestService extends Service {
  @override
  String get $name => 'test.TestService';

  TestService() {
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

  Stream<int> stream(ServiceCall call, Future request) async* {
    yield 1;
    yield 2;
    yield 3;
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

Future<VmService> testee() async {
  isTimelineLoggingEnabled = true;
  final info = await dev.Service.getInfo();
  final uri = info.serverWebSocketUri!;
  final vmService = await vmServiceConnectUri(uri.toString());
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
  await testClient.stream(1).toList();
  await server.shutdown();
  return vmService;
}

void checkStartEvent(List<Map> events) {
  final e = events.where((e) => e['ph'] == 'b').toList();
  expect(e.length, 2);

  expect(e[0]['name'], 'gRPC Request: $path');
  expect(e[0]['args']['method'], equals(path));

  expect(e[1]['name'], 'gRPC Response');
}

void checkSendEvent(List<Map> events) {
  final e = events.firstWhere((e) => e['name'] == 'Request sent');
  expect(e['args']['metadata'], isNotNull);
}

void checkWriteEvent(List<Map> events) {
  final e = events.firstWhere((e) => e['name'] == 'Data sent');
  expect(e['args']['data'], isNotNull);
  expect(e['args']['data'], equals('1'));
}

void checkReceiveEvent(List<Map> events) {
  events = events.where((e) => e['name'] == 'Data received').toList();
  expect(events.length, equals(3));
  var sum = 0;
  for (final e in events) {
    // 3 elements are 1, 2 and 3.
    sum |= 1 << int.parse(e['args']['data']);
  }
  expect(sum, equals(14));
}

void checkReceiveMetaDataEvent(List<Map> events) {
  events = events.where((e) => e['name'] == 'Metadata received').toList();
  expect(events.length, equals(2));
  for (final e in events) {
    if (e['args']['headers'] != null) {
      final header = e['args']['headers'];
      expect(header, contains('status: 200'));
      expect(header, contains('content-type: application/grpc'));
    } else {
      expect(e['args']['trailers'], contains('grpc-status: 0'));
    }
  }
}

void checkFinishEvent(List<Map> events) {
  final e = events.where((e) => e['ph'] == 'e').toList();
  expect(e.length, 2);
}

void main(List<String> args) {
  test('Test gRPC timeline logging', () async {
    final vmService = await testee();
    final timeline = await vmService.getVMTimeline();
    final events = timeline.traceEvents!
        .map((e) => e.json!)
        .where((e) => e['args']['filterKey'] == 'grpc/client')
        .toList();
    checkStartEvent(events);
    checkSendEvent(events);
    checkWriteEvent(events);
    checkReceiveEvent(events);
    checkReceiveMetaDataEvent(events);
    checkFinishEvent(events);
    await vmService.dispose();
  });
}
