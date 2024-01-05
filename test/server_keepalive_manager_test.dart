import 'package:fake_async/fake_async.dart';
import 'package:grpc/src/server/server_keepalive.dart';
import 'package:test/test.dart';

void main() {
  late int maxBadPings;

  var goAway = false;

  ServerKeepAlive initServer([ServerKeepAliveOptions? options]) =>
      ServerKeepAlive(
        options: options ??
            ServerKeepAliveOptions(
              maxBadPings: maxBadPings,
              minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
            ),
        tooManyBadPings: () async => goAway = true,
      );

  setUp(() {
    maxBadPings = 10;
    goAway = false;
  });

  final timeAfterPing = Duration(milliseconds: 10);

  test('Sending too many pings without data kills connection', () async {
    FakeAsync().run((async) {
      final server = initServer();
      // Send good ping
      server.onPingReceived(0);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        server.onPingReceived(0);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      server.onPingReceived(0);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });
  test(
      'Sending too many pings without data doesn`t kill connection if the server doesn`t care',
      () async {
    FakeAsync().run((async) {
      final server = initServer(ServerKeepAliveOptions(
        maxBadPings: null,
        minIntervalBetweenPingsWithoutData: Duration(milliseconds: 5),
      ));
      // Send good ping
      server.onPingReceived(0);
      async.elapse(timeAfterPing);

      // Send a lot of bad pings, that's still ok.
      for (var i = 0; i < 50; i++) {
        server.onPingReceived(0);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);
    });
  });

  test('Sending many pings with data doesn`t kill connection', () async {
    FakeAsync().run((async) {
      final server = initServer();

      // Send good ping
      server.onPingReceived(0);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        server.onPingReceived(0);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Sending data resets the bad ping count
      server.onDataReceived();
      async.elapse(timeAfterPing);

      // Send good ping
      server.onPingReceived(0);
      async.elapse(timeAfterPing);

      // Send [maxBadPings] bad pings, that's still ok
      for (var i = 0; i < maxBadPings; i++) {
        server.onPingReceived(0);
      }
      async.elapse(timeAfterPing);
      expect(goAway, false);

      // Send another bad ping; that's one too many!
      server.onPingReceived(0);
      async.elapse(timeAfterPing);
      expect(goAway, true);
    });
  });
}
