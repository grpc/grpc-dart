import 'dart:async';

import 'package:clock/clock.dart';
import 'package:http2/http2.dart';

class KeepAliveOptions {
  final int? _keepaliveTimeMs;
  final int _keepaliveTimeoutMs;
  final bool keepalivePermitWithoutCalls;
  final int _http2MaxPingsWithoutData;
  final int? _http2MinRecvPingIntervalWithoutDataMs;
  final int? _http2MaxPingStrikes;

  Duration? get keepaliveTime => _keepaliveTimeMs != null
      ? Duration(milliseconds: _keepaliveTimeMs!)
      : null;

  Duration get keepaliveTimeout => Duration(milliseconds: _keepaliveTimeoutMs);

  const KeepAliveOptions._({
    int? keepaliveTimeMs,
    int keepaliveTimeoutMs = 20000,
    this.keepalivePermitWithoutCalls = false,
    int http2MaxPingsWithoutData = 2,
    int? http2MinRecvPingIntervalWithoutDataMs,
    int? http2MaxPingStrikes,
  })  : _http2MaxPingStrikes = http2MaxPingStrikes,
        _http2MinRecvPingIntervalWithoutDataMs =
            http2MinRecvPingIntervalWithoutDataMs,
        _http2MaxPingsWithoutData = http2MaxPingsWithoutData,
        _keepaliveTimeoutMs = keepaliveTimeoutMs,
        _keepaliveTimeMs = keepaliveTimeMs != null
            ? (keepaliveTimeMs < 10 ? 10 : keepaliveTimeMs)
            : null;

  const KeepAliveOptions.client({
    int? keepaliveTimeMs,
    int keepaliveTimeoutMs = 20000,
    bool keepalivePermitWithoutCalls = false,
    int http2MaxPingsWithoutData = 2,
    int? http2MinRecvPingIntervalWithoutDataMs,
    int? http2MaxPingStrikes,
  }) : this._(
          keepaliveTimeMs: keepaliveTimeMs,
          keepaliveTimeoutMs: keepaliveTimeoutMs,
          keepalivePermitWithoutCalls: keepalivePermitWithoutCalls,
          http2MaxPingsWithoutData: http2MaxPingsWithoutData,
          http2MinRecvPingIntervalWithoutDataMs:
              http2MinRecvPingIntervalWithoutDataMs,
          http2MaxPingStrikes: http2MaxPingStrikes,
        );

  const KeepAliveOptions.server({
    int? keepaliveTimeMs = 7200000,
    int keepaliveTimeoutMs = 20000,
    bool keepalivePermitWithoutCalls = false,
    int http2MaxPingsWithoutData = 2,
    int? http2MinRecvPingIntervalWithoutDataMs = 300000,
    int? http2MaxPingStrikes = 2,
  }) : this._(
          keepaliveTimeMs: keepaliveTimeMs,
          keepaliveTimeoutMs: keepaliveTimeoutMs,
          keepalivePermitWithoutCalls: keepalivePermitWithoutCalls,
          http2MaxPingsWithoutData: http2MaxPingsWithoutData,
          http2MinRecvPingIntervalWithoutDataMs:
              http2MinRecvPingIntervalWithoutDataMs,
          http2MaxPingStrikes: http2MaxPingStrikes,
        );
}

enum KeepAliveState {
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

class KeepAliveManager {
  KeepAliveState state;

  final KeepAliveOptions options;
  final KeepAlivePinger keepAlivePinger;
  Timer? shutdownFuture;

  Stopwatch stopwatch;

  Timer? pingFuture;

  bool get keepAliveDuringTransportIdle => options.keepalivePermitWithoutCalls;

  Duration get keepAliveTimeout => options.keepaliveTimeout;
  Duration get keepAliveTime =>
      options.keepaliveTime ?? Duration(days: 365); //infinite

  KeepAliveManager(
    TransportConnection? transport,
    this.options, [
    KeepAlivePinger? pinger,
  ])  : stopwatch = clock.stopwatch()..start(),
        keepAlivePinger = pinger ?? KeepAlivePinger(transport),
        state = KeepAliveState.idle;

  void onTransportStarted() {
    if (keepAliveDuringTransportIdle) {
      onTransportActive();
    }
  }

  void onDataReceived() {
    stopwatch.reset();
    stopwatch.start();
    // We do not cancel the ping future here. This avoids constantly scheduling and cancellation in
    // a busy transport. Instead, we update the status here and reschedule later. So we actually
    // keep one sendPing task always in flight when there're active rpcs.
    if (state == KeepAliveState.pingScheduled) {
      state = KeepAliveState.pingDelayed;
    } else if (state == KeepAliveState.pingSent ||
        state == KeepAliveState.idleAndPingSent) {
      // Ping acked or effectively ping acked. Cancel shutdown, and then if not idle,
      // schedule a new keep-alive ping.
      shutdownFuture?.cancel();
      if (state == KeepAliveState.idleAndPingSent) {
        // not to schedule new pings until onTransportActive
        state = KeepAliveState.idle;
        return;
      }
      // schedule a new ping
      state = KeepAliveState.pingScheduled;
      assert(pingFuture == null);
      pingFuture = Timer(keepAliveTime, sendPing);
    }
  }

  void shutdown() {
    var shouldShutdown = false;
    if (state != KeepAliveState.disconnected) {
      // We haven't received a ping response within the timeout. The connection is likely gone
      // already. Shutdown the transport and fail all existing rpcs.
      state = KeepAliveState.disconnected;
      shouldShutdown = true;
    }
    if (shouldShutdown) {
      keepAlivePinger.onPingTimeout();
    }
  }

  void sendPing() {
    pingFuture = null;
    if (state == KeepAliveState.pingScheduled) {
      state = KeepAliveState.pingSent;
      // Schedule a shutdown. It fires if we don't receive the ping response within the timeout.
      shutdownFuture = Timer(keepAliveTimeout, shutdown);
      keepAlivePinger.ping();
    } else if (state == KeepAliveState.pingDelayed) {
      // We have received some data. Reschedule the ping with the new time.
      pingFuture = Timer(keepAliveTime - stopwatch.elapsed, sendPing);
      state = KeepAliveState.pingScheduled;
    }
  }

  void onTransportActive() {
    if (state == KeepAliveState.idle) {
      // When the transport goes active, we do not reset the nextKeepaliveTime. This allows us to
      // quickly check whether the connection is still working.
      state = KeepAliveState.pingScheduled;
      pingFuture ??= Timer(keepAliveTime - stopwatch.elapsed, sendPing);
    } else if (state == KeepAliveState.idleAndPingSent) {
      state = KeepAliveState.pingSent;
    } // Other states are possible when keepAliveDuringTransportIdle == true
  }

  void onTransportIdle() {
    if (keepAliveDuringTransportIdle) {
      return;
    }
    if (state == KeepAliveState.pingScheduled ||
        state == KeepAliveState.pingDelayed) {
      state = KeepAliveState.idle;
    }
    if (state == KeepAliveState.pingSent) {
      state = KeepAliveState.idleAndPingSent;
    }
  }

  void onTransportTermination() {
    if (state != KeepAliveState.disconnected) {
      state = KeepAliveState.disconnected;
      shutdownFuture?.cancel();
      pingFuture?.cancel();
      pingFuture = null;
    }
  }
}

class KeepAlivePinger {
  final TransportConnection? transport;

  KeepAlivePinger(this.transport);

  void ping() => transport?.ping();

  void onPingTimeout() => transport?.terminate(); //TODO: or finish?
}
