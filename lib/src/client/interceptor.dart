// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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
import 'common.dart';
import 'method.dart';

typedef ClientUnaryInvoker<Q, R> =
    ResponseFuture<R> Function(
      ClientMethod<Q, R> method,
      Q request,
      CallOptions options,
    );

typedef ClientStreamingInvoker<Q, R> =
    ResponseStream<R> Function(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
    );

/// ClientInterceptors intercepts client calls before they are executed.
///
/// Invoker either calls next interceptor in the chain or performs the call if it is last in chain.
/// To modify [CallOptions] make a clone using [CallOptions.mergedWith].
abstract class ClientInterceptor {
  // Intercept unary call.
  // This method is called when client sends single request and receives single response.
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    return invoker(method, request, options);
  }

  // Intercept streaming call.
  // This method is called when client sends either request or response stream.
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    return invoker(method, requests, options);
  }
}
