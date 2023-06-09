import 'package:fake_async/fake_async.dart';
import 'package:grpc/src/shared/keepalive.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/client_utils.mocks.dart';

void main() {
  late KeepAliveManager keepAliveManager;
  late MockClientTransportConnection transport;
  late KeepAlivePinger pinger;

  var transportOpen = true;

  void initKeepAliveManager([KeepAliveOptions? opt]) {
    final options = opt ??
        KeepAliveOptions.client(
          keepaliveTimeMs: 1000,
          keepaliveTimeoutMs: 2000,
          keepalivePermitWithoutCalls: false,
        );
    transport = MockClientTransportConnection();
    when(transport.ping()).thenAnswer((_) async => transportOpen = true);
    when(transport.terminate()).thenAnswer((_) async => transportOpen = false);

    pinger = KeepAlivePinger(transport);
    keepAliveManager = KeepAliveManager(transport, options, pinger);
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
      verify(transport.ping()).called(1);
      // Ping succeeds. Reschedule another ping.

      async.elapse(Duration(milliseconds: 100));
      keepAliveManager.onDataReceived();
      // Shutdown task has been cancelled.
      // Next ping should be exactly 1000 milliseconds later.
      async.elapse(Duration(milliseconds: 1000));
      verify(transport.ping()).called(1);
    });
  });

  test('keepAlivePingDelayedByIncomingData', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();

      // We receive some data. We may need to delay the ping.
      async.elapse(Duration(milliseconds: 990));
      keepAliveManager.onDataReceived();
      async.elapse(Duration(milliseconds: 20));

      // We didn't send the ping.
      verifyNever(transport.ping());
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
      expect(keepAliveManager.shutdownFuture?.isActive, false);
    });
  });
  test('keepAlivePingTimesOut', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();

      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      async.elapse(Duration(milliseconds: 1001));
      verify(transport.ping()).called(1);

      // We do not receive the ping response. Shutdown runnable runs.
      async.elapse(Duration(milliseconds: 2000));
      verify(pinger.onPingTimeout()).called(1);

      // We receive the ping response too late.
      keepAliveManager.onDataReceived();
      // No more ping should be scheduled.
      expect(keepAliveManager.pingFuture, isNull);
    });
  });
  test('transportGoesIdle', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();
      expect(keepAliveManager.pingFuture, isNotNull);

      // Transport becomes idle. Nothing should happen when ping runnable runs.
      keepAliveManager.onTransportIdle();
      async.elapse(Duration(milliseconds: 1000));
      // Ping was not sent.
      verifyNever(transport.ping());
      // No new ping got scheduled.
      expect(keepAliveManager.pingFuture, isNull);

      // But when transport goes back to active
      keepAliveManager.onTransportActive();
      // Ping is now sent.
      async.elapse(Duration(seconds: 1));
      verify(transport.ping()).called(1);
    });
  });
  test('transportGoesIdle_doesntCauseIdleWhenEnabled', () {
    FakeAsync().run((async) {
      keepAliveManager.onTransportTermination();
      initKeepAliveManager(KeepAliveOptions.client(
        keepaliveTimeMs: 1000,
        keepaliveTimeoutMs: 2000,
        keepalivePermitWithoutCalls: true,
      ));
      keepAliveManager.onTransportStarted();

      // Keepalive scheduling should have started immediately.
      expect(keepAliveManager.pingFuture, isNotNull);

      keepAliveManager.onTransportActive();

      // Transport becomes idle. Should not impact the sending of the ping.
      keepAliveManager.onTransportIdle();
      async.elapse(Duration(milliseconds: 1000));
      // Ping was sent.
      verify(transport.ping()).called(1);
      // Shutdown is scheduled.
      expect(keepAliveManager.shutdownFuture, isNotNull);
      // Shutdown is triggered.
      async.elapse(Duration(milliseconds: 2000));
      verify(pinger.onPingTimeout()).called(1);
    });
  });
  test('transportGoesIdleAfterPingSent', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();

      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      async.elapse(Duration(milliseconds: 1000));
      verify(transport.ping()).called(1);
      expect(keepAliveManager.shutdownFuture, isNotNull);

      // Transport becomes idle. No more ping should be scheduled after we receive a ping response.
      keepAliveManager.onTransportIdle();
      async.elapse(Duration(milliseconds: 100));
      keepAliveManager.onDataReceived();
      expect(keepAliveManager.shutdownFuture?.isActive, false);
      expect(keepAliveManager.pingFuture, isNull);
      // Transport becomes active again. Another ping is scheduled.
      keepAliveManager.onTransportActive();
      expect(keepAliveManager.pingFuture, isNotNull);
    });
  });
  test('transportGoesIdleBeforePingSent', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();
      final pingFuture = keepAliveManager.pingFuture;
      expect(pingFuture, isNotNull);

      // Data is received, and we go to ping delayed
      keepAliveManager.onDataReceived();

      // Transport becomes idle while the 1st ping is still scheduled
      keepAliveManager.onTransportIdle();

      // Transport becomes active again, we don't need to reschedule another ping
      keepAliveManager.onTransportActive();
      expect(keepAliveManager.pingFuture, pingFuture);
    });
  });
  test('transportShutsdownAfterPingScheduled', () {
    FakeAsync().run((async) {
      // Ping will be scheduled.
      keepAliveManager.onTransportActive();
      expect(keepAliveManager.pingFuture, isNotNull);
      // Transport is shutting down.
      keepAliveManager.onTransportTermination();
      // Ping future should have been cancelled.
      expect(keepAliveManager.pingFuture, isNull);
    });
  });
  test('transportShutsdownAfterPingSent', () {
    FakeAsync().run((async) {
      keepAliveManager.onTransportActive();
      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      async.elapse(Duration(milliseconds: 1000));
      verify(transport.ping()).called(1);
      expect(keepAliveManager.shutdownFuture, isNotNull);

      // Transport is shutting down.
      keepAliveManager.onTransportTermination();
      // Shutdown task has been cancelled.
      expect(keepAliveManager.shutdownFuture?.isActive, false);
    });
  });
  test('pingSentThenIdleThenActiveThenAck', () {
    FakeAsync().run((async) {
      keepAliveManager.onTransportActive();
      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      async.elapse(Duration(milliseconds: 1000));
      verify(transport.ping()).called(1);

      // shutdown scheduled
      expect(keepAliveManager.shutdownFuture, isNotNull);

      keepAliveManager.onTransportIdle();

      keepAliveManager.onTransportActive();

      keepAliveManager.onDataReceived();

      // another ping scheduled
      expect(keepAliveManager.pingFuture, isNotNull);
      async.elapse(Duration(milliseconds: 1000));
      verify(transport.ping()).called(1);
    });
  });
}
