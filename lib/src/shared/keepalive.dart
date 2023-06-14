import 'dart:async';

import 'package:clock/clock.dart';
import 'package:meta/meta.dart';

class KeepAliveOptions {
  final int? _keepaliveTimeMs;
  final int _keepaliveTimeoutMs;
  final bool keepalivePermitWithoutCalls;
  final int? _http2MinRecvPingIntervalWithoutData;
  final int? _http2MaxPingStrikes;

  Duration? get keepaliveTime => _keepaliveTimeMs != null
      ? Duration(milliseconds: _keepaliveTimeMs!)
      : null;

  Duration get keepaliveTimeout => Duration(milliseconds: _keepaliveTimeoutMs);
  Duration get minRecvPingIntervalWithoutData =>
      Duration(milliseconds: _http2MinRecvPingIntervalWithoutData!);

  const KeepAliveOptions._({
    int? keepaliveTimeMs,
    int keepaliveTimeoutMs = 20000,
    this.keepalivePermitWithoutCalls = false,
    int? http2MinRecvPingIntervalWithoutDataMs,
    int? http2MaxPingStrikes,
  })  : _http2MaxPingStrikes = http2MaxPingStrikes,
        _http2MinRecvPingIntervalWithoutData =
            http2MinRecvPingIntervalWithoutDataMs,
        _keepaliveTimeoutMs = keepaliveTimeoutMs,
        _keepaliveTimeMs = keepaliveTimeMs != null
            ? (keepaliveTimeMs < 10 ? 10 : keepaliveTimeMs)
            : null;

  const KeepAliveOptions.client({
    int? keepaliveTimeMs,
    int keepaliveTimeoutMs = 20000,
    bool keepalivePermitWithoutCalls = false,
    int? http2MinRecvPingIntervalWithoutDataMs,
    int? http2MaxPingStrikes,
  }) : this._(
          keepaliveTimeMs: keepaliveTimeMs,
          keepaliveTimeoutMs: keepaliveTimeoutMs,
          keepalivePermitWithoutCalls: keepalivePermitWithoutCalls,
          http2MinRecvPingIntervalWithoutDataMs:
              http2MinRecvPingIntervalWithoutDataMs,
          http2MaxPingStrikes: http2MaxPingStrikes,
        );

  const KeepAliveOptions.server({
    int? keepaliveTimeMs = 7200000,
    int keepaliveTimeoutMs = 20000,
    bool keepalivePermitWithoutCalls = false,
    int http2MinRecvPingIntervalWithoutDataMs = 300000,
    int http2MaxPingStrikes = 2,
  }) : this._(
          keepaliveTimeMs: keepaliveTimeMs,
          keepaliveTimeoutMs: keepaliveTimeoutMs,
          keepalivePermitWithoutCalls: keepalivePermitWithoutCalls,
          http2MinRecvPingIntervalWithoutDataMs:
              http2MinRecvPingIntervalWithoutDataMs,
          http2MaxPingStrikes: http2MaxPingStrikes,
        );

  bool get sendPings => keepaliveTime != null;
}

enum _KeepAliveState {
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

class ClientKeepAlive {
  _KeepAliveState _state;

  final KeepAliveOptions _options;

  final Stopwatch _stopwatch;

  @visibleForTesting
  Timer? shutdownFuture;

  @visibleForTesting
  Timer? pingFuture;

  bool get _keepAliveDuringTransportIdle =>
      _options.keepalivePermitWithoutCalls;

  Duration get _keepAliveTime => _options.keepaliveTime!;
  final void Function() _onPingTimeout;
  final void Function() _ping;

  ClientKeepAlive({
    required KeepAliveOptions options,
    required void Function() ping,
    required void Function() onPingTimeout,
  })  : _ping = ping,
        _onPingTimeout = onPingTimeout,
        _options = options,
        _stopwatch = clock.stopwatch()..start(),
        _state = _KeepAliveState.idle;

  void onTransportStarted() {
    if (_keepAliveDuringTransportIdle) {
      onTransportActive();
    }
  }

  void onFrameReceived() {
    _stopwatch.reset();
    _stopwatch.start();
    // We do not cancel the ping future here. This avoids constantly scheduling and cancellation in
    // a busy transport. Instead, we update the status here and reschedule later. So we actually
    // keep one sendPing task always in flight when there're active rpcs.
    if (_state == _KeepAliveState.pingScheduled) {
      _state = _KeepAliveState.pingDelayed;
    } else if (_state == _KeepAliveState.pingSent ||
        _state == _KeepAliveState.idleAndPingSent) {
      // Ping acked or effectively ping acked. Cancel shutdown, and then if not idle,
      // schedule a new keep-alive ping.
      shutdownFuture?.cancel();
      if (_state == _KeepAliveState.idleAndPingSent) {
        // not to schedule new pings until onTransportActive
        _state = _KeepAliveState.idle;
        return;
      }
      // schedule a new ping
      _state = _KeepAliveState.pingScheduled;
      assert(pingFuture == null);
      pingFuture = Timer(_keepAliveTime, _sendPing);
    }
  }

  void _shutdown() {
    if (_state != _KeepAliveState.disconnected) {
      // We haven't received a ping response within the timeout. The connection is likely gone
      // already. Shutdown the transport and fail all existing rpcs.
      _state = _KeepAliveState.disconnected;
      _onPingTimeout();
    }
  }

  void _sendPing() {
    pingFuture = null;
    if (_state == _KeepAliveState.pingScheduled) {
      _state = _KeepAliveState.pingSent;
      // Schedule a shutdown. It fires if we don't receive the ping response within the timeout.
      shutdownFuture = Timer(_options.keepaliveTimeout, _shutdown);
      _ping();
    } else if (_state == _KeepAliveState.pingDelayed) {
      // We have received some data. Reschedule the ping with the new time.
      pingFuture = Timer(_keepAliveTime - _stopwatch.elapsed, _sendPing);
      _state = _KeepAliveState.pingScheduled;
    }
  }

  void onTransportActive() {
    if (_state == _KeepAliveState.idle) {
      // When the transport goes active, we do not reset the nextKeepaliveTime. This allows us to
      // quickly check whether the connection is still working.
      _state = _KeepAliveState.pingScheduled;
      pingFuture ??= Timer(_keepAliveTime - _stopwatch.elapsed, _sendPing);
    } else if (_state == _KeepAliveState.idleAndPingSent) {
      _state = _KeepAliveState.pingSent;
    } // Other states are possible when keepAliveDuringTransportIdle == true
  }

  void onTransportIdle() {
    if (_keepAliveDuringTransportIdle) {
      return;
    }
    if (_state == _KeepAliveState.pingScheduled ||
        _state == _KeepAliveState.pingDelayed) {
      _state = _KeepAliveState.idle;
    }
    if (_state == _KeepAliveState.pingSent) {
      _state = _KeepAliveState.idleAndPingSent;
    }
  }

  void onTransportTermination() {
    if (_state != _KeepAliveState.disconnected) {
      _state = _KeepAliveState.disconnected;
      shutdownFuture?.cancel();
      pingFuture?.cancel();
      pingFuture = null;
    }
  }
}

class ServerKeepAlive {
  final Future<void> Function()? _goAwayAfterMaxPings;
  final KeepAliveOptions _options;
  final Stream<void> _pingStream;
  final Stream<void> _dataStream;

  int _badPings = 0;
  Stopwatch? _timeOfLastReceivedPing;

  ServerKeepAlive({
    Future<void> Function()? goAwayAfterMaxPings,
    required KeepAliveOptions options,
    required Stream<void> pingStream,
    required Stream<void> dataStream,
  })  : _goAwayAfterMaxPings = goAwayAfterMaxPings,
        _options = options,
        _pingStream = pingStream,
        _dataStream = dataStream;

  void handle() {
    _pingStream.listen((_) => _onPingReceived());
    _dataStream.listen((_) => _onDataReceived());
  }

  bool get _enforcesMaxPings => _options._http2MaxPingStrikes! > 0;

  Future<void> _onPingReceived() async {
    if (_enforcesMaxPings) {
      if (_timeOfLastReceivedPing == null) {
        _timeOfLastReceivedPing = clock.stopwatch()
          ..reset()
          ..start();
      } else if (_timeOfLastReceivedPing!.elapsed >
          _options.minRecvPingIntervalWithoutData) {
        _badPings++;
      }
      if (_badPings + 1 > _options._http2MaxPingStrikes!) {
        await _goAwayAfterMaxPings?.call();
      }
    }
  }

  void _onDataReceived() {
    if (_enforcesMaxPings) {
      _badPings = 0;
      _timeOfLastReceivedPing = null;
    }
  }
}
