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
import 'dart:developer';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/channel.dart' hide ClientChannel;
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/profiler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const String path = '/test.TestService/stream';

class TestClient extends Client {
  static final _$stream = ClientMethod<int, int>(
      path, (int value) => [value], (List<int> value) => value[0]);

  TestClient(super.channel);
  ResponseStream<int> stream(int request, {CallOptions? options}) {
    return $createStreamingCall(_$stream, Stream.fromIterable([request]),
        options: options);
  }
}

class TestService extends Service {
  @override
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
    onConnectionStateChanged.listen((state) => states.add(state));
  }
  @override
  ClientConnection createConnection() => clientConnection;
}

class FakeTimelineTask extends Fake implements TimelineTask {
  static final List<FakeTimelineTask> tasks = [];
  static final List<Map> events = [];
  static int _idCount = 0;

  final String? filterKey;
  final TimelineTask? parent;
  final int id = _idCount++;
  int _startFinishCount = 0;

  factory FakeTimelineTask({TimelineTask? parent, String? filterKey}) {
    final task = FakeTimelineTask._(parent: parent, filterKey: filterKey);
    tasks.add(task);
    return task;
  }

  FakeTimelineTask._({this.parent, this.filterKey});

  bool get isComplete => _startFinishCount == 0;

  @override
  void start(String name, {Map? arguments}) {
    events.add({
      'id': id,
      'ph': 'b',
      'name': name,
      'args': {
        if (filterKey != null) 'filterKey': filterKey,
        if (parent != null) 'parentId': (parent as FakeTimelineTask).id,
        if (arguments != null) ...arguments,
      }
    });
    ++_startFinishCount;
  }

  @override
  void instant(String name, {Map? arguments}) {
    events.add({
      'id': id,
      'ph': 'i',
      'name': name,
      'args': {
        if (filterKey != null) 'filterKey': filterKey,
        if (arguments != null) ...arguments,
      }
    });
  }

  @override
  void finish({Map? arguments}) {
    events.add({
      'id': id,
      'ph': 'e',
      'args': {
        if (filterKey != null) 'filterKey': filterKey,
        if (arguments != null) ...arguments,
      }
    });
    --_startFinishCount;
    expect(_startFinishCount >= 0, true);
  }
}

TimelineTask fakeTimelineTaskFactory(
        {String? filterKey, TimelineTask? parent}) =>
    FakeTimelineTask(filterKey: filterKey, parent: parent);

Future<void> testee() async {
  final server = Server([TestService()]);
  await server.serve(address: 'localhost', port: 0);
  isTimelineLoggingEnabled = true;
  timelineTaskFactory = fakeTimelineTaskFactory;
  final channel = FixedConnectionClientChannel(Http2ClientConnection(
    'localhost',
    server.port!,
    ChannelOptions(credentials: ChannelCredentials.insecure()),
  ));
  final testClient = TestClient(channel);
  await testClient.stream(1).toList();
  await server.shutdown();
}

void checkStartEvent(List<Map> events) {
  final e = events.where((e) => e['ph'] == 'b').toList();
  expect(e.length, 2);

  expect(e[0]['name'], 'gRPC Request: $path');
  expect(e[0]['id'], 0);
  expect(e[0]['args']['method'], isNotNull);
  expect(e[0]['args']['method'], equals(path));

  expect(e[1]['name'], 'gRPC Response');
  expect(e[1]['id'], 1);
  expect(e[1]['args']['parentId'], 0);
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
    expect(e['id'], 1);
    // 3 elements are 1, 2 and 3.
    sum |= 1 << int.parse(e['args']['data']);
  }
  expect(sum, equals(14));
}

void checkReceiveMetaDataEvent(List<Map> events) {
  events = events.where((e) => e['name'] == 'Metadata received').toList();
  expect(events.length, equals(2));
  for (final e in events) {
    expect(e['id'], 1);
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

void main([args = const <String>[]]) {
  test('Test gRPC timeline logging', () async {
    await testee();
    for (final task in FakeTimelineTask.tasks) {
      expect(task.isComplete, true);
    }
    final events = FakeTimelineTask.events
        .where((e) => e['args']['filterKey'] == 'grpc/client')
        .toList();
    checkStartEvent(events);
    checkSendEvent(events);
    checkWriteEvent(events);
    checkReceiveEvent(events);
    checkReceiveMetaDataEvent(events);
    checkFinishEvent(events);
  });
}
