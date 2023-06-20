import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:grpc/src/shared/keepalive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'keepalive_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Pinger>()])
abstract class Pinger {
  void ping();
  void onPingTimeout();
}

void main() {
  group('ClientKeepAliveManager', () {
    late ClientKeepAlive keepAliveManager;

    final pinger = MockPinger();

    var transportOpen = true;

    void initKeepAliveManager([ClientKeepAliveOptions? opt]) {
      reset(pinger);
      final options = opt ??
          ClientKeepAliveOptions(
            pingInterval: Duration(milliseconds: 1000),
            timeout: Duration(milliseconds: 2000),
            permitWithoutCalls: false,
          );

      when(pinger.ping()).thenAnswer((_) async => transportOpen = true);
      when(pinger.onPingTimeout())
          .thenAnswer((_) async => transportOpen = false);

      keepAliveManager = ClientKeepAlive(
        options: options,
        ping: pinger.ping,
        onPingTimeout: pinger.onPingTimeout,
      );
      transportOpen = true;
    }

    setUp(() => initKeepAliveManager());
    test('sendKeepAlivePings', () {
      FakeAsync().run((async) {
        async.elapse(Duration(milliseconds: 1));
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();
        async.elapse(Duration(milliseconds: 999));
        // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
        verify(pinger.ping()).called(1);
        // Ping succeeds. Reschedule another ping.

        async.elapse(Duration(milliseconds: 100));
        keepAliveManager.onFrameReceived();
        // Shutdown task has been cancelled.
        // Next ping should be exactly 1000 milliseconds later.
        async.elapse(Duration(milliseconds: 1000));
        verify(pinger.ping()).called(1);
      });
    });

    test('keepAlivePingDelayedByIncomingData', () {
      FakeAsync().run((async) {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();

        // We receive some data. We may need to delay the ping.
        async.elapse(Duration(milliseconds: 990));
        keepAliveManager.onFrameReceived();
        async.elapse(Duration(milliseconds: 20));

        // We didn't send the ping.
        verifyNever(pinger.ping());
      });
    });

    test('clienttransport.ping()_pingTimeout', () {
      FakeAsync().run((async) {
        pinger.onPingTimeout();
        expect(transportOpen, false);
        // Status status = statusCaptor.getValue();
        // assertThat(status.getCode()).isEqualTo(Status.Code.UNAVAILABLE);
        // assertThat(status.getDescription()).isEqualTo(
        //     "Keepalive failed. The connection is likely gone");
        // });
      });
    });

    test('onTransportTerminationCancelsShutdownFuture', () {
      FakeAsync().run((async) {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();
        async.elapse(Duration(milliseconds: 1000));

        keepAliveManager.onTransportTermination();

        // Shutdown task has been cancelled.
        expect(keepAliveManager.state, isA<Disconnected>());
      });
    });
    test('keepAlivePingTimesOut', () {
      FakeAsync().run((async) {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();
        expect(keepAliveManager.state, isA<PingScheduled>());

        // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
        async.elapse(Duration(milliseconds: 1001));
        verify(pinger.ping()).called(1);
        expect(keepAliveManager.state, isA<ShutdownScheduled>());

        // We do not receive the ping response. Shutdown runnable runs.
        async.elapse(Duration(milliseconds: 2000));
        verify(pinger.onPingTimeout()).called(1);
        expect(keepAliveManager.state, isA<Disconnected>());

        // We receive the ping response too late.
        keepAliveManager.onFrameReceived();
        // No more ping should be scheduled.
        expect(keepAliveManager.state, isA<Disconnected>());
      });
    });
    test('transportGoesIdle', () {
      FakeAsync().run((async) async {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();
        expect(keepAliveManager.state, isA<PingScheduled>());

        // Transport becomes idle. Nothing should happen when ping runnable runs.
        keepAliveManager.onTransportIdle();
        expect(keepAliveManager.state, isA<Idle>());
        async.elapse(Duration(milliseconds: 1000));
        // Ping was not sent.
        verifyNever(pinger.ping());
        // No new ping got scheduled.
        expect(keepAliveManager.state, isA<Idle>());

        // But when transport goes back to active
        keepAliveManager.onTransportActive();
        expect(keepAliveManager.state, isA<PingScheduled>());
        // Ping is now sent.
        async.elapse(Duration(seconds: 1));
        verify(pinger.ping()).called(1);
        expect(keepAliveManager.state, isA<ShutdownScheduled>());
      });
    });
    test('transportGoesIdle_doesntCauseIdleWhenEnabled', () {
      FakeAsync().run((async) {
        keepAliveManager.onTransportTermination();
        initKeepAliveManager(ClientKeepAliveOptions(
          pingInterval: Duration(milliseconds: 1000),
          timeout: Duration(milliseconds: 2000),
          permitWithoutCalls: true,
        ));
        keepAliveManager.onTransportStarted();

        // Keepalive scheduling should have started immediately.
        expect(keepAliveManager.state, isA<PingScheduled>());

        keepAliveManager.onTransportActive();

        // Transport becomes idle. Should not impact the sending of the ping.
        keepAliveManager.onTransportIdle();
        async.elapse(Duration(milliseconds: 1000));
        // Ping was sent.
        verify(pinger.ping()).called(1);
        // Shutdown is scheduled.
        expect(keepAliveManager.state, isA<ShutdownScheduled>());
        // Shutdown is triggered.
        async.elapse(Duration(milliseconds: 2000));
        expect(keepAliveManager.state, isA<Disconnected>());
        verify(pinger.onPingTimeout()).called(1);
      });
    });
    test('transportGoesIdleAfterPingSent', () {
      FakeAsync().run((async) {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();

        // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
        async.elapse(Duration(milliseconds: 1000));
        verify(pinger.ping()).called(1);
        expect(keepAliveManager.state, isA<ShutdownScheduled>());

        // Transport becomes idle. No more ping should be scheduled after we receive a ping response.
        keepAliveManager.onTransportIdle();
        async.elapse(Duration(milliseconds: 100));
        keepAliveManager.onFrameReceived();
        expect(keepAliveManager.state, isA<Idle>());
        // Transport becomes active again. Another ping is scheduled.
        keepAliveManager.onTransportActive();
        expect(keepAliveManager.state, isA<PingScheduled>());
      });
    });
    test('transportGoesIdleBeforePingSent', () {
      FakeAsync().run((async) {
        // Transport becomes active. We should schedule keepalive pings.
        keepAliveManager.onTransportActive();
        final pingFuture = (keepAliveManager.state as PingScheduled).pingTimer;
        expect(pingFuture, isNotNull);

        // Data is received, and we go to ping delayed
        keepAliveManager.onFrameReceived();

        // Transport becomes idle while the 1st ping is still scheduled
        keepAliveManager.onTransportIdle();

        // Transport becomes active again, we don't need to reschedule another ping
        keepAliveManager.onTransportActive();
        expect((keepAliveManager.state as PingScheduled).pingTimer, pingFuture);
      });
    });
    test('transportShutsdownAfterPingScheduled', () {
      FakeAsync().run((async) {
        // Ping will be scheduled.
        keepAliveManager.onTransportActive();
        expect(keepAliveManager.state, isA<PingScheduled>());
        // Transport is shutting down.
        keepAliveManager.onTransportTermination();
        // Ping future should have been cancelled.
        expect(keepAliveManager.state, isA<Disconnected>());
      });
    });
    test('transportShutsdownAfterPingSent', () {
      FakeAsync().run((async) {
        keepAliveManager.onTransportActive();
        // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
        async.elapse(Duration(milliseconds: 1000));
        verify(pinger.ping()).called(1);
        expect(keepAliveManager.state, isA<ShutdownScheduled>());

        // Transport is shutting down.
        keepAliveManager.onTransportTermination();
        // Shutdown task has been cancelled.
        expect(keepAliveManager.state, isA<Disconnected>());
      });
    });
    test('pingSentThenIdleThenActiveThenAck', () {
      FakeAsync().run((async) {
        keepAliveManager.onTransportActive();
        // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
        async.elapse(Duration(milliseconds: 1000));
        verify(pinger.ping()).called(1);

        // shutdown scheduled
        expect(keepAliveManager.state, isA<ShutdownScheduled>());

        keepAliveManager.onTransportIdle();

        keepAliveManager.onTransportActive();

        keepAliveManager.onFrameReceived();

        // another ping scheduled
        expect(keepAliveManager.state, isA<PingScheduled>());
        async.elapse(Duration(milliseconds: 1000));
        verify(pinger.ping()).called(1);
      });
    });
  });

  group('ServerKeepAliveManager', () {
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
  });
}
