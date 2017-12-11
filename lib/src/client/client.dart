// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'call.dart';
import 'channel.dart';
import 'options.dart';

/// Description of a gRPC method.
class ClientMethod<Q, R> {
  final String path;
  final List<int> Function(Q value) requestSerializer;
  final R Function(List<int> value) responseDeserializer;

  ClientMethod(this.path, this.requestSerializer, this.responseDeserializer);
}

/// Base class for client stubs.
class Client {
  final ClientChannel _channel;
  final CallOptions _options;

  Client(this._channel, {CallOptions options})
      : _options = options ?? new CallOptions();

  ClientCall<Q, R> $createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests,
      {CallOptions options}) {
    return _channel.createCall(method, requests, _options.mergedWith(options));
  }
}
