// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:io';

import '../../shared/security.dart';

/// Handler for checking certificates that fail validation. If this handler
/// returns `true`, the bad certificate is allowed, and the TLS handshake can
/// continue. If the handler returns `false`, the TLS handshake fails, and the
/// connection is aborted.
typedef BadCertificateHandler =
    bool Function(X509Certificate certificate, String host);

/// Bad certificate handler that disables all certificate checks.
/// DO NOT USE IN PRODUCTION!
/// Can be used during development and testing to accept self-signed
/// certificates, etc.
bool allowBadCertificates(X509Certificate certificate, String host) => true;

/// Options controlling TLS security settings on a [ClientChannel].
class ChannelCredentials {
  final bool isSecure;
  final String? authority;
  final List<int>? _certificateBytes;
  final String? _certificatePassword;
  final BadCertificateHandler? onBadCertificate;

  const ChannelCredentials._(
    this.isSecure,
    this._certificateBytes,
    this._certificatePassword,
    this.authority,
    this.onBadCertificate,
  );

  /// Disable TLS. RPCs are sent in clear text.
  const ChannelCredentials.insecure({String? authority})
    : this._(false, null, null, authority, null);

  /// Enable TLS and optionally specify the [certificates] to trust. If
  /// [certificates] is not provided, the default trust store is used.
  const ChannelCredentials.secure({
    List<int>? certificates,
    String? password,
    String? authority,
    BadCertificateHandler? onBadCertificate,
  }) : this._(true, certificates, password, authority, onBadCertificate);

  SecurityContext? get securityContext {
    if (!isSecure) return null;
    if (_certificateBytes != null) {
      return createSecurityContext(false)..setTrustedCertificatesBytes(
        _certificateBytes,
        password: _certificatePassword,
      );
    }
    final context = SecurityContext(withTrustedRoots: true);
    context.setAlpnProtocols(supportedAlpnProtocols, false);
    return context;
  }
}
