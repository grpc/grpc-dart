// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:grpc/src/server/server_keepalive.dart';
import 'package:test/test.dart';

void main() {
  late StreamController pingStream;
  late StreamController dataStream;
  late int maxBadPings;

  var goAway = false;

  void initServer([ServerKeepAliveOptions? options]) => ServerKeepAlive(
        options: options ??
            ServerKeepAliveOptions(
              maxBadPings: maxBadPings,
              minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
            ),
        pingNotifier: pingStream.stream,
        dataNotifier: dataStream.stream,
        tooManyBadPings: () async => goAway = true,
      ).handle();

  setUp(() {
    pingStream = StreamController();
    dataStream = StreamController();
    maxBadPings = 10;
    goAway = false;
  });

  tearDown(() {
    pingStream.close();
    dataStream.close();
  });

  final timeAfterPing = Duration(milliseconds: 10);

  test('Sending too many pings without data kills connection', () async {
    FakeAsync().run((async) {
      initServer();
      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });
  test(
      'Sending too many pings without data doesn`t kill connection if the server doesn`t care',
      () async {
    FakeAsync().run((async) {
      initServer(ServerKeepAliveOptions(
        maxBadPings: null,
        minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
      ));
      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send a lot of bad pings, that's still ok.
      for (var i = 0; i < 50; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);
    });
  });

  test('Sending many pings with data doesn`t kill connection', () async {
    FakeAsync().run((async) {
      initServer();

      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Sending data resets the bad ping count
      dataStream.add(null);
      async.elapse(timeAfterPing);

      // Send good ping
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        pingStream.sink.add(null);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      pingStream.sink.add(null);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });
}
