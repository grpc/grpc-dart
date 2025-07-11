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

import 'call.dart';
import 'channel.dart';
import 'common.dart';
import 'interceptor.dart';
import 'method.dart';

/// Base class for client stubs.
class Client {
  final ClientChannel _channel;
  final CallOptions _options;
  final List<ClientInterceptor> _interceptors;

  /// Interceptors will be applied in direct order before making a request.
  Client(
    this._channel, {
    CallOptions? options,
    Iterable<ClientInterceptor>? interceptors,
  }) : _options = options ?? CallOptions(),
       _interceptors = List.unmodifiable(interceptors ?? Iterable.empty());

  @Deprecated(r'''This method does not invoke interceptors and is superseded
by $createStreamingCall and $createUnaryCall which invoke interceptors.

If you are getting this warning in autogenerated protobuf client stubs,
regenerate these stubs using  protobuf compiler plugin version 19.2.0 or newer.
''')
  ClientCall<Q, R> $createCall<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests, {
    CallOptions? options,
  }) {
    return _channel.createCall(method, requests, _options.mergedWith(options));
  }

  ResponseFuture<R> $createUnaryCall<Q, R>(
    ClientMethod<Q, R> method,
    Q request, {
    CallOptions? options,
  }) {
    var invoker = (method, request, options) => ResponseFuture<R>(
      _channel.createCall<Q, R>(method, Stream.value(request), options),
    );

    for (final interceptor in _interceptors.reversed) {
      final delegate = invoker;
      invoker = (method, request, options) =>
          interceptor.interceptUnary<Q, R>(method, request, options, delegate);
    }

    return invoker(method, request, _options.mergedWith(options));
  }

  ResponseStream<R> $createStreamingCall<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests, {
    CallOptions? options,
  }) {
    var invoker = (method, requests, options) =>
        ResponseStream<R>(_channel.createCall<Q, R>(method, requests, options));

    for (final interceptor in _interceptors.reversed) {
      final delegate = invoker;
      invoker = (method, requests, options) => interceptor
          .interceptStreaming<Q, R>(method, requests, options, delegate);
    }

    return invoker(method, requests, _options.mergedWith(options));
  }
}
