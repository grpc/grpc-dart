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
    this.timeout = const Duration(milliseconds: 20000),
    this.permitWithoutCalls = false,
  });

  bool get shouldSendPings => pingInterval != null;
}

sealed class KeepAliveState {
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
  void disconnect() {
    pingTimer?.cancel();
  }
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
  void disconnect() => pingTimer.cancel();
}

/// We need to delay the scheduled keepalive ping.
final class PingDelayed extends KeepAliveState {
  final Timer pingTimer;
  final Stopwatch timeSinceFrame;

  PingDelayed(this.pingTimer) : timeSinceFrame = clock.stopwatch()..start();

  @override
  void disconnect() => pingTimer.cancel();
}

/// The ping has been sent out. Waiting for a ping response.
final class ShutdownScheduled extends KeepAliveState {
  final bool isIdle;
  final Timer shutdownTimer;

  ShutdownScheduled(this.shutdownTimer, this.isIdle);

  @override
  void disconnect() => shutdownTimer.cancel();
}

final class Disconnected extends KeepAliveState {
  @override
  void disconnect() {}
}

enum _KeepAliveEvent {
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
  Duration get _pingInterval => _options.pingInterval ?? Duration(days: 365);
  final Map<Type, KeepAliveState? Function(KeepAliveState, _KeepAliveEvent)>
      _stateTransform = {};

  ClientKeepAlive({
    required ClientKeepAliveOptions options,
    required this.ping,
    required this.onPingTimeout,
  }) : _options = options {
    _addEventHandler<Idle>((current, event) {
      switch (event) {
        case _KeepAliveEvent.onTransportActive:
          // When the transport goes active, we do not reset the nextKeepaliveTime.
          // This allows us to quickly check whether the connection is still
          // working.
          final pingTimer = current.pingTimer ??
              Timer(_pingInterval - current.timeSinceFrame.elapsed, sendPing);
          return PingScheduled(pingTimer, current.timeSinceFrame);
        default:
          return null;
      }
    });

    _addEventHandler<PingScheduled>((current, event) {
      switch (event) {
        case _KeepAliveEvent.onFrameReceived:
          // We do not cancel the ping future here. This avoids constantly scheduling
          // and cancellation in a busy transport. Instead, we update the status here
          // and reschedule later. So we actually keep one sendPing task always in
          // flight when there're active rpcs.
          return PingDelayed(current.pingTimer);
        case _KeepAliveEvent.onTransportIdle:
          return Idle(current.pingTimer, current.timeSinceFrame);
        case _KeepAliveEvent.sendPing:
          // Schedule a shutdown. It fires if we don't receive the ping response
          // within the timeout.
          ping();
          return ShutdownScheduled(Timer(_options.timeout, _shutdown), false);
        default:
          return null;
      }
    });

    _addEventHandler<PingDelayed>((current, event) {
      switch (event) {
        case _KeepAliveEvent.onTransportIdle:
          return Idle(current.pingTimer, current.timeSinceFrame);
        case _KeepAliveEvent.sendPing:
          final pingTimer =
              Timer(_pingInterval - current.timeSinceFrame.elapsed, sendPing);
          return PingScheduled(pingTimer, current.timeSinceFrame);
        default:
          return null;
      }
    });

    _addEventHandler<ShutdownScheduled>((current, event) {
      switch (event) {
        case _KeepAliveEvent.onFrameReceived:
          // Ping acked or effectively ping acked. Cancel shutdown, and then if not
          // idle, schedule a new keep-alive ping.
          current.shutdownTimer.cancel();
          // schedule a new ping
          return current.isIdle
              ? Idle()
              : PingScheduled(Timer(_pingInterval, sendPing));
        case _KeepAliveEvent.onTransportIdle:
          return ShutdownScheduled(current.shutdownTimer, true);
        case _KeepAliveEvent.onTransportActive:
          return ShutdownScheduled(current.shutdownTimer, false);
        default:
          return null;
      }
    });
  }

  void onTransportStarted() {
    if (_options.permitWithoutCalls) {
      onTransportActive();
    }
  }

  /// If we receive any kind of frame from the server, that means the connection
  /// is still open, so we reset the ping timer.
  void onFrameReceived() => _setState(_KeepAliveEvent.onFrameReceived);

  void _shutdown() {
    onPingTimeout();
    _disconnect();
  }

  void sendPing() => _setState(_KeepAliveEvent.sendPing);

  /// When the transport becomes active, we start sending pings every
  /// [_pingInterval].
  void onTransportActive() => _setState(_KeepAliveEvent.onTransportActive);

  /// If the transport has become idle and [_options.permitWithoutCalls] is
  /// set, nothing changes, we still send pings and shutdown on no response.
  ///
  /// Otherwise, we stop sending pings.
  void onTransportIdle() {
    if (!_options.permitWithoutCalls) {
      _setState(_KeepAliveEvent.onTransportIdle);
    }
  }

  void onTransportTermination() => _disconnect();

  void _setState(_KeepAliveEvent event) {
    final newState = _stateTransform[state.runtimeType]?.call(state, event);
    if (newState != null) state = newState;
  }

  void _disconnect() {
    state.disconnect();
    state = Disconnected();
  }

  void _addEventHandler<T extends KeepAliveState>(
    KeepAliveState? Function(T current, _KeepAliveEvent event) onEvent,
  ) =>
      _stateTransform[T] = (current, event) => onEvent(current as T, event);
}
