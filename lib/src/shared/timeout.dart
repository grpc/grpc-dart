// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Convert [timeout] to grpc-timeout header string format.
// Mostly inspired by grpc-java implementation.
// TODO(jakobr): Modify to match grpc/core implementation instead.
String toTimeoutString(Duration duration) {
  if (duration == null) return null;
  const cutoff = 100000;
  final timeout = duration.inMicroseconds;
  if (timeout < 0) {
    // Smallest possible timeout.
    return '1n';
  } else if (timeout < cutoff) {
    return '${timeout}u';
  } else if (timeout < cutoff * 1000) {
    return '${timeout~/1000}m';
  } else if (timeout < cutoff * 1000 * 1000) {
    return '${timeout~/1000000}S';
  } else if (timeout < cutoff * 1000 * 1000 * 60) {
    return '${timeout~/60000000}M';
  } else {
    return '${timeout~/3600000000}H';
  }
}

/// Convert [timeout] from grpc-timeout header string format to [Duration].
/// Returns [null] if [timeout] is not correctly formatted.
Duration fromTimeoutString(String timeout) {
  if (timeout == null) return null;
  if (timeout.length < 2) return null;
  final value =
      int.parse(timeout.substring(0, timeout.length - 1), onError: (_) => null);
  if (value == null) return null;
  switch (timeout[timeout.length - 1]) {
    case 'n':
      return new Duration(microseconds: value * 1000);
    case 'u':
      return new Duration(microseconds: value);
    case 'm':
      return new Duration(milliseconds: value);
    case 'S':
      return new Duration(seconds: value);
    case 'M':
      return new Duration(minutes: value);
    case 'H':
      return new Duration(hours: value);
    default:
      return null;
  }
}
