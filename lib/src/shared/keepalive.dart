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

sealed class ClientKeepAliveState {
  void disconnect();
}

/// Transport has no active rpcs. We don't need to do any keepalives.
final class Idle extends ClientKeepAliveState {
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
final class PingScheduled extends ClientKeepAliveState {
  final Timer pingTimer;
  final Stopwatch timeSinceFrame;

  PingScheduled(this.pingTimer, [Stopwatch? stopwatch])
      : timeSinceFrame = stopwatch ?? clock.stopwatch()
          ..start();

  @override
  void disconnect() => pingTimer.cancel();
}

/// We need to delay the scheduled keepalive ping.
final class PingDelayed extends ClientKeepAliveState {
  final Timer pingTimer;
  final Stopwatch timeSinceFrame;

  PingDelayed(this.pingTimer) : timeSinceFrame = clock.stopwatch()..start();

  @override
  void disconnect() => pingTimer.cancel();
}

/// The ping has been sent out. Waiting for a ping response.
final class ShutdownScheduled extends ClientKeepAliveState {
  final bool isIdle;
  final Timer shutdownTimer;

  ShutdownScheduled(this.shutdownTimer, this.isIdle);

  @override
  void disconnect() => shutdownTimer.cancel();
}

final class Disconnected extends ClientKeepAliveState {
  @override
  void disconnect() {}
}

enum ClientKeepAliveEvent {
  onTransportActive,
  onFrameReceived,
  onTransportIdle,
  sendPing,
}

/// A keep alive "manager", deciding when to send pings or shutdown based on the
/// [ClientKeepAliveOptions].
class ClientKeepAlive {
  @visibleForTesting
  ClientKeepAliveState state = Idle();

  final ClientKeepAliveOptions _options;

  Duration get _pingInterval => _options.pingInterval ?? Duration(days: 365);

  final void Function() onPingTimeout;
  final void Function() ping;

  final Map<
          Type,
          ClientKeepAliveState? Function(
              ClientKeepAliveState current, ClientKeepAliveEvent event)>
      _stateTransform = {};

  ClientKeepAlive({
    required ClientKeepAliveOptions options,
    required this.ping,
    required this.onPingTimeout,
  }) : _options = options {
    _addEventHandler<Idle>((current, event) {
      switch (event) {
        case ClientKeepAliveEvent.onTransportActive:
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
        case ClientKeepAliveEvent.onFrameReceived:
          // We do not cancel the ping future here. This avoids constantly scheduling
          // and cancellation in a busy transport. Instead, we update the status here
          // and reschedule later. So we actually keep one sendPing task always in
          // flight when there're active rpcs.
          return PingDelayed(current.pingTimer);
        case ClientKeepAliveEvent.onTransportIdle:
          return Idle(current.pingTimer, current.timeSinceFrame);
        case ClientKeepAliveEvent.sendPing:
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
        case ClientKeepAliveEvent.onTransportIdle:
          return Idle(current.pingTimer, current.timeSinceFrame);
        case ClientKeepAliveEvent.sendPing:
          final pingTimer =
              Timer(_pingInterval - current.timeSinceFrame.elapsed, sendPing);
          return PingScheduled(pingTimer, current.timeSinceFrame);
        default:
          return null;
      }
    });

    _addEventHandler<ShutdownScheduled>((current, event) {
      switch (event) {
        case ClientKeepAliveEvent.onFrameReceived:
          // Ping acked or effectively ping acked. Cancel shutdown, and then if not
          // idle, schedule a new keep-alive ping.
          current.shutdownTimer.cancel();
          // schedule a new ping
          return current.isIdle
              ? Idle()
              : PingScheduled(Timer(_pingInterval, sendPing));
        case ClientKeepAliveEvent.onTransportIdle:
          return ShutdownScheduled(current.shutdownTimer, true);
        case ClientKeepAliveEvent.onTransportActive:
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
  void onFrameReceived() => _setState(ClientKeepAliveEvent.onFrameReceived);

  void _shutdown() {
    onPingTimeout();
    _disconnect();
  }

  void sendPing() => _setState(ClientKeepAliveEvent.sendPing);

  /// When the transport becomes active, we start sending pings every
  /// [_pingInterval].
  void onTransportActive() => _setState(ClientKeepAliveEvent.onTransportActive);

  /// If the transport has become idle and [_options.permitWithoutCalls] is
  /// set, nothing changes, we still send pings and shutdown on no response.
  ///
  /// Otherwise, we stop sending pings.
  void onTransportIdle() {
    if (!_options.permitWithoutCalls) {
      _setState(ClientKeepAliveEvent.onTransportIdle);
    }
  }

  void onTransportTermination() => _disconnect();

  void _setState(ClientKeepAliveEvent event) {
    final newState = _stateTransform[state.runtimeType]?.call(state, event);
    if (newState != null) state = newState;
  }

  void _disconnect() {
    state.disconnect();
    state = Disconnected();
  }

  void _addEventHandler<T extends ClientKeepAliveState>(
    ClientKeepAliveState? Function(T current, ClientKeepAliveEvent event)
        onEvent,
  ) =>
      _stateTransform[T] = (current, event) => onEvent(current as T, event);
}

/// Options to configure a gRPC server for receiving keepalive signals.
class ServerKeepAliveOptions {
  /// The maximum number of bad pings that the server will tolerate before
  /// sending an HTTP2 GOAWAY frame and closing the transport.
  ///
  /// `GRPC_ARG_HTTP2_MAX_PING_STRIKES` in the docs.
  final int? maxBadPings;

  /// The minimum time that is expected between receiving successive pings.
  ///
  /// `GRPC_ARG_HTTP2_MIN_RECV_PING_INTERVAL_WITHOUT_DATA_MS` in the docs.
  final Duration minIntervalBetweenPingsWithoutData;

  const ServerKeepAliveOptions({
    this.minIntervalBetweenPingsWithoutData =
        const Duration(milliseconds: 300000),
    this.maxBadPings = 2,
  });
}

/// A keep alive "manager", deciding what do to when receiving pings from a
/// client trying to keep the connection alive, based on the set
/// [ServerKeepAliveOptions].
class ServerKeepAlive {
  /// What to do after receiving too many bad pings, probably shut down the
  /// connection to not be DDoSed.
  final Future<void> Function()? tooManyBadPings;

  final ServerKeepAliveOptions options;

  /// A stream of events for every time the server gets pinged.
  final Stream<void> pingNotifier;

  /// A stream of events for every time the server receives data.
  final Stream<void> dataNotifier;

  int _badPings = 0;
  Stopwatch? _timeOfLastReceivedPing;

  ServerKeepAlive({
    this.tooManyBadPings,
    required this.options,
    required this.pingNotifier,
    required this.dataNotifier,
  });

  void handle() {
    // If we don't care about bad pings, there is not point in listening to
    // events.
    if (_enforcesMaxBadPings) {
      pingNotifier.listen((_) => _onPingReceived());
      dataNotifier.listen((_) => _onDataReceived());
    }
  }

  bool get _enforcesMaxBadPings => (options.maxBadPings ?? 0) > 0;

  Future<void> _onPingReceived() async {
    if (_enforcesMaxBadPings) {
      if (_timeOfLastReceivedPing == null) {
        _timeOfLastReceivedPing = clock.stopwatch()
          ..reset()
          ..start();
      } else if (_timeOfLastReceivedPing!.elapsed >
          options.minIntervalBetweenPingsWithoutData) {
        _badPings++;
      }
      if (_badPings > options.maxBadPings!) {
        await tooManyBadPings?.call();
      }
    }
  }

  void _onDataReceived() {
    if (_enforcesMaxBadPings) {
      _badPings = 0;
      _timeOfLastReceivedPing = null;
    }
  }
}
