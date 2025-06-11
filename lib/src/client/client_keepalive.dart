// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:meta/meta.dart';

/// KeepAlive support for gRPC, see
/// https://github.com/grpc/grpc/blob/master/doc/keepalive.md.

/// Options to configure a gRPC client for sending keepalive signals.
class ClientKeepAliveOptions {
  /// How often a ping should be sent to keep the connection alive.
  ///
  /// `GRPC_ARG_KEEPALIVE_TIME_MS` in the docs.
  final Duration? pingInterval;

  /// How long the connection should wait before shutting down after no response
  /// to a ping.
  ///
  /// `GRPC_ARG_KEEPALIVE_TIMEOUT_MS` in the docs.
  final Duration timeout;

  /// If a connection with no active calls should be kept alive by sending
  /// pings.
  ///
  /// `GRPC_ARG_KEEPALIVE_PERMIT_WITHOUT_CALLS` in the docs.
  final bool permitWithoutCalls;

  const ClientKeepAliveOptions({
    this.pingInterval,
    this.timeout = const Duration(seconds: 20),
    this.permitWithoutCalls = false,
  });

  bool get shouldSendPings => pingInterval != null;
}

sealed class KeepAliveState {
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager);

  void disconnect();
}

/// Transport has no active rpcs. We don't need to do any keepalives.
final class Idle extends KeepAliveState {
  final Timer? pingTimer;
  final Stopwatch timeSinceFrame;

  Idle([this.pingTimer, Stopwatch? stopwatch])
    : timeSinceFrame = stopwatch ?? clock.stopwatch()
        ..start();

  @override
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager) {
    switch (event) {
      case KeepAliveEvent.onTransportActive:
        // When the transport goes active, we do not reset the nextKeepaliveTime.
        // This allows us to quickly check whether the connection is still
        // working.
        final timer =
            pingTimer ??
            Timer(
              manager._pingInterval - timeSinceFrame.elapsed,
              manager.sendPing,
            );
        return PingScheduled(timer, timeSinceFrame);
      default:
        return null;
    }
  }

  @override
  void disconnect() => pingTimer?.cancel();
}

/// We have scheduled a ping to be sent in the future. We may decide to delay
/// it if we receive some data.
final class PingScheduled extends KeepAliveState {
  final Timer pingTimer;
  final Stopwatch timeSinceFrame;

  PingScheduled(this.pingTimer, [Stopwatch? stopwatch])
    : timeSinceFrame = stopwatch ?? clock.stopwatch()
        ..start();

  @override
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager) {
    switch (event) {
      case KeepAliveEvent.onFrameReceived:
        // We do not cancel the ping future here. This avoids constantly scheduling
        // and cancellation in a busy transport. Instead, we update the status here
        // and reschedule later. So we actually keep one sendPing task always in
        // flight when there're active rpcs.
        return PingDelayed(pingTimer);
      case KeepAliveEvent.onTransportIdle:
        return Idle(pingTimer, timeSinceFrame);
      case KeepAliveEvent.sendPing:
        // Schedule a shutdown. It fires if we don't receive the ping response
        // within the timeout.
        manager.ping();
        final shutdown = Timer(manager._options.timeout, manager._shutdown);
        return ShutdownScheduled(shutdown, false);
      default:
        return null;
    }
  }

  @override
  void disconnect() => pingTimer.cancel();
}

/// We need to delay the scheduled keepalive ping.
final class PingDelayed extends KeepAliveState {
  final Timer pingTimer;
  final Stopwatch timeSinceFrame;

  PingDelayed(this.pingTimer) : timeSinceFrame = clock.stopwatch()..start();

  @override
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager) {
    switch (event) {
      case KeepAliveEvent.onTransportIdle:
        return Idle(pingTimer, timeSinceFrame);
      case KeepAliveEvent.sendPing:
        final pingTimer = Timer(
          manager._pingInterval - timeSinceFrame.elapsed,
          manager.sendPing,
        );
        return PingScheduled(pingTimer, timeSinceFrame);
      default:
        return null;
    }
  }

  @override
  void disconnect() => pingTimer.cancel();
}

/// The ping has been sent out. Waiting for a ping response.
final class ShutdownScheduled extends KeepAliveState {
  final bool isIdle;
  final Timer shutdownTimer;

  ShutdownScheduled(this.shutdownTimer, this.isIdle);

  @override
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager) {
    switch (event) {
      case KeepAliveEvent.onFrameReceived:
        // Ping acked or effectively ping acked. Cancel shutdown, and then if not
        // idle, schedule a new keep-alive ping.
        shutdownTimer.cancel();
        // schedule a new ping
        return isIdle
            ? Idle()
            : PingScheduled(Timer(manager._pingInterval, manager.sendPing));
      case KeepAliveEvent.onTransportIdle:
        return ShutdownScheduled(shutdownTimer, true);
      case KeepAliveEvent.onTransportActive:
        return ShutdownScheduled(shutdownTimer, false);
      default:
        return null;
    }
  }

  @override
  void disconnect() => shutdownTimer.cancel();
}

final class Disconnected extends KeepAliveState {
  @override
  void disconnect() {}

  @override
  KeepAliveState? onEvent(KeepAliveEvent event, ClientKeepAlive manager) =>
      null;
}

enum KeepAliveEvent {
  onTransportActive,
  onFrameReceived,
  onTransportIdle,
  sendPing,
}

/// A keep alive "manager", deciding when to send pings or shutdown based on the
/// [ClientKeepAliveOptions].
class ClientKeepAlive {
  @visibleForTesting
  KeepAliveState state = Idle();

  final void Function() onPingTimeout;
  final void Function() ping;

  final ClientKeepAliveOptions _options;
  Duration get _pingInterval => _options.pingInterval!;

  ClientKeepAlive({
    required ClientKeepAliveOptions options,
    required this.ping,
    required this.onPingTimeout,
  }) : _options = options;

  void onTransportStarted() {
    if (_options.permitWithoutCalls) {
      onTransportActive();
    }
  }

  /// If we receive any kind of frame from the server, that means the connection
  /// is still open, so we reset the ping timer.
  void onFrameReceived() => _setState(KeepAliveEvent.onFrameReceived);

  void sendPing() => _setState(KeepAliveEvent.sendPing);

  /// When the transport becomes active, we start sending pings every
  /// [_pingInterval].
  void onTransportActive() => _setState(KeepAliveEvent.onTransportActive);

  /// If the transport has become idle and [_options.permitWithoutCalls] is
  /// set, nothing changes, we still send pings and shutdown on no response.
  ///
  /// Otherwise, we stop sending pings.
  void onTransportIdle() {
    if (!_options.permitWithoutCalls) {
      _setState(KeepAliveEvent.onTransportIdle);
    }
  }

  void onTransportTermination() => _disconnect();

  void _shutdown() {
    onPingTimeout();
    _disconnect();
  }

  void _disconnect() {
    state.disconnect();
    state = Disconnected();
  }

  void _setState(KeepAliveEvent event) {
    if (_options.shouldSendPings) {
      final newState = state.onEvent(event, this);
      if (newState != null) state = newState;
    }
  }
}
