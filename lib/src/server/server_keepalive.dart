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

import 'package:clock/clock.dart';

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
    this.minIntervalBetweenPingsWithoutData = const Duration(minutes: 5),
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
