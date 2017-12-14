// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Description of a gRPC method.
class ClientMethod<Q, R> {
  final String path;
  final List<int> Function(Q value) requestSerializer;
  final R Function(List<int> value) responseDeserializer;

  ClientMethod(this.path, this.requestSerializer, this.responseDeserializer);
}
