// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'dart:math';

import '../shared/security.dart';

const defaultIdleTimeout = const Duration(minutes: 5);

typedef Duration BackoffStrategy(Duration lastBackoff);

// Backoff algorithm from https://github.com/grpc/grpc/blob/master/doc/connection-backoff.md
const _minConnectTimeout = const Duration(seconds: 20);
const _initialBackoff = const Duration(seconds: 1);
const _maxBackoff = const Duration(seconds: 120);
const _multiplier = 1.6;
const _jitter = 0.2;
final _random = new Random();

Duration defaultBackoffStrategy(Duration lastBackoff) {
  if (lastBackoff == null) return _initialBackoff;
  final jitter = _random.nextDouble() * 2 * _jitter - _jitter;
  final nextBackoff = lastBackoff * (_multiplier + jitter);
  return nextBackoff < _maxBackoff ? nextBackoff : _maxBackoff;
}

/// Options controlling how connections are made on a [ClientChannel].
class ChannelOptions {
  final bool isSecure;
  final List<int> _certificateBytes;
  final String _certificatePassword;
  final String authority;
  final Duration idleTimeout;
  final BackoffStrategy backoffStrategy;

  const ChannelOptions._(
      this.isSecure,
      this._certificateBytes,
      this._certificatePassword,
      this.authority,
      Duration idleTimeout,
      BackoffStrategy backoffStrategy)
      : this.idleTimeout = idleTimeout ?? defaultIdleTimeout,
        this.backoffStrategy = backoffStrategy ?? defaultBackoffStrategy;

  /// Disable TLS. RPCs are sent in clear text.
  const ChannelOptions.insecure(
      {Duration idleTimeout,
      BackoffStrategy backoffStrategy =
          defaultBackoffStrategy}) // Remove when dart-lang/sdk#31066 is fixed.
      : this._(false, null, null, null, idleTimeout, backoffStrategy);

  /// Enable TLS and optionally specify the [certificate]s to trust. If
  /// [certificates] is not provided, the default trust store is used.
  const ChannelOptions.secure(
      {List<int> certificate,
      String password,
      String authority,
      Duration idleTimeout,
      BackoffStrategy backoffStrategy =
          defaultBackoffStrategy}) // Remove when dart-lang/sdk#31066 is fixed.
      : this._(true, certificate, password, authority, idleTimeout,
            backoffStrategy);

  SecurityContext get securityContext {
    if (!isSecure) return null;
    if (_certificateBytes != null) {
      return createSecurityContext(false)
        ..setTrustedCertificatesBytes(_certificateBytes,
            password: _certificatePassword);
    }
    final context = new SecurityContext(withTrustedRoots: true);
    if (SecurityContext.alpnSupported) {
      context.setAlpnProtocols(supportedAlpnProtocols, false);
    }
    return context;
  }
}

/// Provides per-RPC metadata.
///
/// Metadata providers will be invoked for every RPC, and can add their own
/// metadata to the RPC. If the function returns a [Future], the RPC will await
/// completion of the returned [Future] before transmitting the request.
///
/// The metadata provider is given the current metadata map (possibly modified
/// by previous metadata providers), and is expected to modify the map before
/// returning or before completing the returned [Future].
typedef FutureOr<Null> MetadataProvider(Map<String, String> metadata);

/// Runtime options for an RPC.
class CallOptions {
  final Map<String, String> metadata;
  final Duration timeout;
  final List<MetadataProvider> metadataProviders;

  CallOptions._(this.metadata, this.timeout, this.metadataProviders);

  /// Creates a [CallOptions] object.
  ///
  /// [CallOptions] can specify static [metadata], set the [timeout], and
  /// configure per-RPC metadata [providers]. The metadata [providers] are
  /// invoked in order for every RPC, and can modify the outgoing metadata
  /// (including metadata provided by previous providers).
  factory CallOptions(
      {Map<String, String> metadata,
      Duration timeout,
      List<MetadataProvider> providers}) {
    return new CallOptions._(new Map.unmodifiable(metadata ?? {}), timeout,
        new List.unmodifiable(providers ?? []));
  }

  factory CallOptions.from(Iterable<CallOptions> options) =>
      options.fold(new CallOptions(), (p, o) => p.mergedWith(o));

  CallOptions mergedWith(CallOptions other) {
    if (other == null) return this;
    final mergedMetadata = new Map.from(metadata)..addAll(other.metadata);
    final mergedTimeout = other.timeout ?? timeout;
    final mergedProviders = new List.from(metadataProviders)
      ..addAll(other.metadataProviders);
    return new CallOptions._(new Map.unmodifiable(mergedMetadata),
        mergedTimeout, new List.unmodifiable(mergedProviders));
  }
}
