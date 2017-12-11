// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

const supportedAlpnProtocols = const ['grpc-exp', 'h2'];

// TODO: Simplify once we have a stable Dart 1.25 release (update pubspec to
// require SDK >=1.25.0, and remove check for alpnSupported).
SecurityContext createSecurityContext(bool isServer) =>
    SecurityContext.alpnSupported
        ? (new SecurityContext()
      ..setAlpnProtocols(supportedAlpnProtocols, isServer))
        : new SecurityContext();
