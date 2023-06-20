import 'dart:async';

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

  test('Sending too many pings without data kills connection', () async {
    initServer();
    // Send good ping
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));

    // Send [maxBadPings] bad pings, that's still ok
    for (var i = 0; i < maxBadPings; i++) {
      pingStream.sink.add(null);
    }
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, false);

    // Send another bad ping; that's one too many!
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, true);
  });
  test(
      'Sending too many pings without data doesn`t kill connection if the server doesn`t care',
      () async {
    initServer(ServerKeepAliveOptions(
      maxBadPings: null,
      minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
    ));
    // Send good ping
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));

    // Send a lot of bad pings, that's still ok.
    for (var i = 0; i < 50; i++) {
      pingStream.sink.add(null);
    }
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, false);
  });

  test('Sending many pings with data doesn`t kill connection', () async {
    initServer();

    // Send good ping
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));

    // Send [maxBadPings] bad pings, that's still ok
    for (var i = 0; i < maxBadPings; i++) {
      pingStream.sink.add(null);
    }
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, false);

    // Sending data resets the bad ping count
    dataStream.add(null);
    await Future.delayed(Duration(milliseconds: 10));

    // Send good ping
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));

    // Send [maxBadPings] bad pings, that's still ok
    for (var i = 0; i < maxBadPings; i++) {
      pingStream.sink.add(null);
    }
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, false);

    // Send another bad ping; that's one too many!
    pingStream.sink.add(null);
    await Future.delayed(Duration(milliseconds: 10));
    expect(goAway, true);
  });
}
