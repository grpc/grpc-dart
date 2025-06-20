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

import 'package:fake_async/fake_async.dart';
import 'package:grpc/src/client/client_keepalive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'client_keepalive_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Pinger>()])
abstract class Pinger {
  void ping();
  void onPingTimeout();
}

void main() {
  late ClientKeepAlive keepAliveManager;

  final pinger = MockPinger();

  var transportOpen = true;

  final shortTime = Duration(milliseconds: 150);

  final epsilon = Duration(milliseconds: 50);

  final timeout = Duration(milliseconds: 2000);

  /// Add some epsilon to make sure tests pass
  final timeoutLeeway = timeout + epsilon;

  final pingInterval = Duration(milliseconds: 1000);

  /// Add some epsilon to make sure tests pass
  final pingIntervalLeeway = pingInterval + epsilon;

  void initKeepAliveManager([ClientKeepAliveOptions? opt]) {
    reset(pinger);
    final options =
        opt ??
        ClientKeepAliveOptions(
          pingInterval: pingInterval,
          timeout: timeout,
          permitWithoutCalls: false,
        );

    when(pinger.ping()).thenAnswer((_) async => transportOpen = true);
    when(pinger.onPingTimeout()).thenAnswer((_) async => transportOpen = false);

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
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();
      async.elapse(pingIntervalLeeway);
      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      verify(pinger.ping()).called(1);
      // Ping succeeds. Reschedule another ping.

      async.elapse(shortTime);
      keepAliveManager.onFrameReceived();
      // Shutdown task has been cancelled.
      // Next ping should be exactly 1000 milliseconds later.
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);
    });
  });

  test('keepAlivePingDelayedByIncomingData', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();

      // We receive some data. We may need to delay the ping.
      async.elapse(pingInterval - shortTime);
      keepAliveManager.onFrameReceived();
      async.elapse(shortTime + epsilon);

      // We didn't send the ping.
      verifyNever(pinger.ping());
    });
  });

  test('clienttransport.ping()_pingTimeout', () {
    FakeAsync().run((async) {
      pinger.onPingTimeout();
      expect(transportOpen, false);
    });
  });

  test('onTransportTerminationCancelsShutdownFuture', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();
      async.elapse(pingIntervalLeeway);
      // Shutdown task has become active.
      expect(keepAliveManager.state, isA<ShutdownScheduled>());

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
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);
      expect(keepAliveManager.state, isA<ShutdownScheduled>());

      // We do not receive the ping response. Shutdown runnable runs.
      async.elapse(timeoutLeeway);
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
      async.elapse(pingIntervalLeeway);
      // Ping was not sent.
      verifyNever(pinger.ping());
      // No new ping got scheduled.
      expect(keepAliveManager.state, isA<Idle>());

      // But when transport goes back to active
      keepAliveManager.onTransportActive();
      expect(keepAliveManager.state, isA<PingScheduled>());
      // Ping is now sent.
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);
      expect(keepAliveManager.state, isA<ShutdownScheduled>());
    });
  });
  test('transportGoesIdle_doesntCauseIdleWhenEnabled', () {
    FakeAsync().run((async) {
      keepAliveManager.onTransportTermination();
      initKeepAliveManager(
        ClientKeepAliveOptions(
          pingInterval: pingInterval,
          timeout: timeout,
          permitWithoutCalls: true,
        ),
      );
      keepAliveManager.onTransportStarted();

      // Keepalive scheduling should have started immediately.
      expect(keepAliveManager.state, isA<PingScheduled>());

      keepAliveManager.onTransportActive();

      // Transport becomes idle. Should not impact the sending of the ping.
      keepAliveManager.onTransportIdle();
      async.elapse(pingIntervalLeeway);
      // Ping was sent.
      verify(pinger.ping()).called(1);
      // Shutdown is scheduled.
      expect(keepAliveManager.state, isA<ShutdownScheduled>());
      // Shutdown is triggered.
      async.elapse(timeoutLeeway);
      expect(keepAliveManager.state, isA<Disconnected>());
      verify(pinger.onPingTimeout()).called(1);
    });
  });
  test('transportGoesIdleAfterPingSent', () {
    FakeAsync().run((async) {
      // Transport becomes active. We should schedule keepalive pings.
      keepAliveManager.onTransportActive();

      // Forward clock to keepAliveTimeInNanos will send the ping. Shutdown task should be scheduled.
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);
      expect(keepAliveManager.state, isA<ShutdownScheduled>());

      // Transport becomes idle. No more ping should be scheduled after we receive a ping response.
      keepAliveManager.onTransportIdle();
      async.elapse(shortTime);
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
      async.elapse(pingIntervalLeeway);
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
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);

      // shutdown scheduled
      expect(keepAliveManager.state, isA<ShutdownScheduled>());

      keepAliveManager.onTransportIdle();

      keepAliveManager.onTransportActive();

      keepAliveManager.onFrameReceived();

      // another ping scheduled
      expect(keepAliveManager.state, isA<PingScheduled>());
      async.elapse(pingIntervalLeeway);
      verify(pinger.ping()).called(1);
    });
  });
}
