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
import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as api;
import 'package:grpc/src/client/channel.dart' hide ClientChannel;
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:test/test.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

import 'test_util.dart';

const String path = '/test.TestService/stream';

class TestClient extends Client {
  static final _$stream = ClientMethod<int, int>(
      path, (int value) => [value], (List<int> value) => value[0]);

  TestClient(api.ClientChannel channel) : super(channel);
  ResponseStream<int> stream(int request, {CallOptions options}) {
    final call =
        $createCall(_$stream, Stream.fromIterable([request]), options: options);
    return ResponseStream(call);
  }
}

class TestService extends Service {
  String get $name => 'test.TestService';

  TestService() {
    $addMethod(ServiceMethod<int, int>('stream', stream, false, true,
        (List<int> value) => value[0], (int value) => [value]));
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
    clientConnection.onStateChanged = (c) => states.add(c.state);
  }
  @override
  ClientConnection createConnection() => clientConnection;
}

testee() async {
  final Server server = Server([TestService()]);
  await server.serve(address: 'localhost', port: 0);

  enableTimelineLogging();
  final channel = FixedConnectionClientChannel(Http2ClientConnection(
    'localhost',
    server.port,
    ChannelOptions(credentials: ChannelCredentials.insecure()),
  ));
  final testClient = TestClient(channel);
  await testClient.stream(1).toList();
  await server.shutdown();
}

void checkStartEvent(List<Map> events) {
  final e = events.firstWhere((e) => e['ph'] == 'b');
  expect(e['args']['method'], isNotNull);
  expect(e['args']['method'], equals(path));
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
  int sum = 0;
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
  final e = events.firstWhere((e) => e['ph'] == 'e');
  expect(e, isNotNull);
}

var tests = <IsolateTest>[
  (VmService service, IsolateRef i) async {
    final timeline = await service.getVMTimeline();
    final events = timeline.traceEvents
        .where((e) => e.json['args']['filterKey'] == 'grpc/client')
        .map((e) => e.json)
        .toList();
    checkStartEvent(events);
    checkSendEvent(events);
    checkWriteEvent(events);
    checkReceiveEvent(events);
    checkReceiveMetaDataEvent(events);
    checkFinishEvent(events);
  },
];

main([args = const <String>[]]) async => runIsolateTests(args, tests,
    testeeBefore: testee, extraArgs: ['--timeline_streams=Dart']);
