// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
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

/// Convert [timeout] to grpc-timeout header string format.
// Mostly inspired by grpc-java implementation.
// TODO(jakobr): Modify to match grpc/core implementation instead.
String toTimeoutString(Duration duration) {
  const cutoff = 100000;
  final timeout = duration.inMicroseconds;
  if (timeout < 0) {
    // Smallest possible timeout.
    return '1n';
  } else if (timeout < cutoff) {
    return '${timeout}u';
  } else if (timeout < cutoff * 1000) {
    return '${timeout ~/ 1000}m';
  } else if (timeout < cutoff * 1000 * 1000) {
    return '${timeout ~/ 1000000}S';
  } else if (timeout < cutoff * 1000 * 1000 * 60) {
    return '${timeout ~/ 60000000}M';
  } else {
    return '${timeout ~/ 3600000000}H';
  }
}

/// Convert [timeout] from grpc-timeout header string format to [Duration].
/// Returns [null] if [timeout] is not correctly formatted.
Duration? fromTimeoutString(String? timeout) {
  if (timeout == null) return null;
  if (timeout.length < 2) return null;
  final value = int.tryParse(timeout.substring(0, timeout.length - 1));
  if (value == null) return null;
  switch (timeout[timeout.length - 1]) {
    case 'n':
      return Duration(microseconds: value * 1000);
    case 'u':
      return Duration(microseconds: value);
    case 'm':
      return Duration(milliseconds: value);
    case 'S':
      return Duration(seconds: value);
    case 'M':
      return Duration(minutes: value);
    case 'H':
      return Duration(hours: value);
    default:
      return null;
  }
}
