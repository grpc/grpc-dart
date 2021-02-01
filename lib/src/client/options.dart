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

import 'dart:math';

import '../shared/codec_registry.dart';
import 'transport/http2_credentials.dart';

const defaultIdleTimeout = Duration(minutes: 5);

/// It seems like Google's gRPC endpoints will forcefully close the
/// connection after precisely 1 hour. So we *proactively* refresh our
/// connection after 50 minutes. This will avoid one failed RPC call.
const defaultConnectionTimeOut = Duration(minutes: 50);
const defaultUserAgent = 'dart-grpc/2.0.0';

typedef BackoffStrategy = Duration Function(Duration? lastBackoff);

// Backoff algorithm from https://github.com/grpc/grpc/blob/master/doc/connection-backoff.md
const _initialBackoff = Duration(seconds: 1);
const _maxBackoff = Duration(seconds: 120);
const _multiplier = 1.6;
const _jitter = 0.2;
final _random = Random();

Duration defaultBackoffStrategy(Duration? lastBackoff) {
  if (lastBackoff == null) return _initialBackoff;
  final jitter = _random.nextDouble() * 2 * _jitter - _jitter;
  final nextBackoff = lastBackoff * (_multiplier + jitter);
  return nextBackoff < _maxBackoff ? nextBackoff : _maxBackoff;
}

/// Options controlling how connections are made on a [ClientChannel].
class ChannelOptions {
  final ChannelCredentials credentials;
  final Duration? idleTimeout;
  final CodecRegistry? codecRegistry;

  /// The maximum time a single connection will be used for new requests.
  final Duration connectionTimeout;
  final BackoffStrategy backoffStrategy;
  final String userAgent;

  const ChannelOptions({
    this.credentials = const ChannelCredentials.secure(),
    this.idleTimeout = defaultIdleTimeout,
    this.userAgent = defaultUserAgent,
    this.backoffStrategy = defaultBackoffStrategy,
    this.connectionTimeout = defaultConnectionTimeOut,
    this.codecRegistry,
  });
}
