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

import 'dart:async';

import '../shared/status.dart';
import 'call.dart';
import 'interceptor.dart';

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
    this.responseSerializer,
  );

  StreamController<Q> createRequestStream(StreamSubscription incoming) =>
      StreamController<Q>(
        onListen: incoming.resume,
        onPause: incoming.pause,
        onResume: incoming.resume,
      );

  Q deserialize(List<int> data) => requestDeserializer(data);

  List<int> serialize(dynamic response) => responseSerializer(response as R);

  ServerStreamingInvoker<Q, R> _createCall() =>
      ((ServiceCall call, ServiceMethod<Q, R> method, Stream<Q> requests) {
        if (streamingResponse) {
          if (streamingRequest) {
            return handler(call, requests);
          } else {
            return handler(call, _toSingleFuture(requests));
          }
        } else {
          final response = streamingRequest
              ? handler(call, requests)
              : handler(call, _toSingleFuture(requests));
          return response.asStream();
        }
      });

  Stream<R> handle(
    ServiceCall call,
    Stream<Q> requests,
    List<ServerInterceptor> interceptors,
  ) {
    var invoker = _createCall();

    for (final interceptor in interceptors.reversed) {
      final delegate = invoker;
      // invoker is actually reassigned in the same scope as the above function,
      // reassigning invoker in delegate is required to avoid an infinite
      // recursion
      invoker = (call, method, requests) =>
          interceptor.intercept<Q, R>(call, method, requests, delegate);
    }

    return invoker(call, this, requests);
  }

  Future<Q> _toSingleFuture(Stream<Q> stream) {
    Q ensureOnlyOneRequest(Q? previous, Q element) {
      if (previous != null) {
        throw GrpcError.unimplemented('More than one request received');
      }
      return element;
    }

    Q ensureOneRequest(Q? value) {
      if (value == null) throw GrpcError.unimplemented('No requests received');
      return value;
    }

    final future = stream
        .fold<Q?>(null, ensureOnlyOneRequest)
        .then(ensureOneRequest);
    // Make sure errors on the future aren't unhandled, but return the original
    // future so the request handler can also get the error.
    _awaitAndCatch(future);
    return future;
  }

  void _awaitAndCatch(Future<Q> f) async {
    try {
      await f;
    } catch (_) {}
  }
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

  ServiceMethod? $lookupMethod(String name) => _$methods[name];
}
