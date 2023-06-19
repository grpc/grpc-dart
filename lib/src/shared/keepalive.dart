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

enum _ClientKeepAliveState {
  /// Transport has no active rpcs. We don't need to do any keepalives.
  idle,

  /// We have scheduled a ping to be sent in the future. We may decide to delay
  /// it if we receive some data.
  pingScheduled,

  /// We need to delay the scheduled keepalive ping.
  pingDelayed,

  /// The ping has been sent out. Waiting for a ping response.
  pingSent,

  /// Transport goes idle after ping has been sent.
  idleAndPingSent,

  /// The transport has been disconnected. We won't do keepalives any more.
  disconnected;
}

/// A keep alive "manager", deciding when to send pings or shutdown based on the
/// [ClientKeepAliveOptions].
class ClientKeepAlive {
  _ClientKeepAliveState _state;

  final ClientKeepAliveOptions options;

  final Stopwatch _stopwatch;

  @visibleForTesting
  Timer? shutdownTimer;

  @visibleForTesting
  Timer? pingTimer;

  bool get _keepAliveDuringTransportIdle => options.permitWithoutCalls;

  Duration get _keepAliveTime => options.pingInterval ?? Duration(days: 365);

  final void Function() onPingTimeout;
  final void Function() ping;

  ClientKeepAlive({
    required this.options,
    required this.ping,
    required this.onPingTimeout,
  })  : _stopwatch = clock.stopwatch()..start(),
        _state = _ClientKeepAliveState.idle;

  void onTransportStarted() {
    if (_keepAliveDuringTransportIdle) {
      onTransportActive();
    }
  }

  /// If we receive any kind of frame from the server, that means the connection
  /// is still open, so we reset the ping timer.
  void onFrameReceived() {
    _stopwatch.reset();
    _stopwatch.start();
    // We do not cancel the ping future here. This avoids constantly scheduling
    // and cancellation in a busy transport. Instead, we update the status here
    // and reschedule later. So we actually keep one sendPing task always in
    // flight when there're active rpcs.
    if (_state == _ClientKeepAliveState.pingScheduled) {
      _state = _ClientKeepAliveState.pingDelayed;
    } else if (_state == _ClientKeepAliveState.pingSent ||
        _state == _ClientKeepAliveState.idleAndPingSent) {
      // Ping acked or effectively ping acked. Cancel shutdown, and then if not
      // idle, schedule a new keep-alive ping.
      shutdownTimer?.cancel();
      if (_state == _ClientKeepAliveState.idleAndPingSent) {
        // not to schedule new pings until onTransportActive
        _state = _ClientKeepAliveState.idle;
        return;
      }
      // schedule a new ping
      _state = _ClientKeepAliveState.pingScheduled;
      assert(pingTimer == null);
      pingTimer = Timer(_keepAliveTime, _sendPing);
    }
  }

  void _shutdown() {
    if (_state != _ClientKeepAliveState.disconnected) {
      // We haven't received a ping response within the timeout. The connection
      //is likely gone already. Shutdown the transport and fail all existing
      //rpcs.
      _state = _ClientKeepAliveState.disconnected;
      onPingTimeout();
    }
  }

  void _sendPing() {
    pingTimer = null;
    if (_state == _ClientKeepAliveState.pingScheduled) {
      _state = _ClientKeepAliveState.pingSent;
      // Schedule a shutdown. It fires if we don't receive the ping response
      // within the timeout.
      shutdownTimer = Timer(options.timeout, _shutdown);
      ping();
    } else if (_state == _ClientKeepAliveState.pingDelayed) {
      // We have received some data. Reschedule the ping with the new time.
      pingTimer = Timer(_keepAliveTime - _stopwatch.elapsed, _sendPing);
      _state = _ClientKeepAliveState.pingScheduled;
    }
  }

  /// When the transport becomes active, we start sending pings every
  /// [_keepAliveTime].
  void onTransportActive() {
    if (_state == _ClientKeepAliveState.idle) {
      // When the transport goes active, we do not reset the nextKeepaliveTime.
      // This allows us to quickly check whether the connection is still
      // working.
      _state = _ClientKeepAliveState.pingScheduled;
      pingTimer ??= Timer(_keepAliveTime - _stopwatch.elapsed, _sendPing);
    } else if (_state == _ClientKeepAliveState.idleAndPingSent) {
      _state = _ClientKeepAliveState.pingSent;
    } // Other states are possible when keepAliveDuringTransportIdle == true
  }

  /// If the transport has become idle and [_keepAliveDuringTransportIdle] is
  /// set, nothing changes, we still send pings and shutdown on no response.
  ///
  /// Otherwise, we stop sending pings.
  void onTransportIdle() {
    if (_keepAliveDuringTransportIdle) {
      return;
    }
    if (_state == _ClientKeepAliveState.pingScheduled ||
        _state == _ClientKeepAliveState.pingDelayed) {
      _state = _ClientKeepAliveState.idle;
    }
    if (_state == _ClientKeepAliveState.pingSent) {
      _state = _ClientKeepAliveState.idleAndPingSent;
    }
  }

  void onTransportTermination() {
    if (_state != _ClientKeepAliveState.disconnected) {
      _state = _ClientKeepAliveState.disconnected;
      shutdownTimer?.cancel();
      pingTimer?.cancel();
      pingTimer = null;
    }
  }
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
