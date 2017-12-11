// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'call.dart';

/// Definition of a gRPC service method.
class ServiceMethod<Q, R> {
  final String name;

  final bool streamingRequest;
  final bool streamingResponse;

  final Q Function(List<int> request) requestDeserializer;
  final List<int> Function(R response) responseSerializer;

  final Function handler;

  ServiceMethod(
      this.name,
      this.handler,
      this.streamingRequest,
      this.streamingResponse,
      this.requestDeserializer,
      this.responseSerializer);
}

/// Definition of a gRPC service.
abstract class Service {
  final Map<String, ServiceMethod> _$methods = {};

  String get $name;

  void $addMethod(ServiceMethod method) {
    _$methods[method.name] = method;
  }

  /// Client metadata handler.
  ///
  /// Services can override this method to provide common handling of incoming
  /// metadata from the client.
  void $onMetadata(ServiceCall context) {}

  ServiceMethod $lookupMethod(String name) => _$methods[name];
}
