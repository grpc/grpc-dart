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

  StreamController<Q> createRequestStream(StreamSubscription incoming) =>
      new StreamController<Q>(
          onListen: incoming.resume,
          onPause: incoming.pause,
          onResume: incoming.resume);

  Q deserialize(List<int> data) => requestDeserializer(data);

  List<int> serialize(dynamic response) => responseSerializer(response as R);

  Stream<R> handle(ServiceCall call, Stream<Q> requests) {
    if (streamingResponse) {
      if (streamingRequest) {
        return handler(call, requests);
      } else {
        return handler(call, _toSingleFuture(requests));
      }
    } else {
      Future<R> response;
      if (streamingRequest) {
        response = handler(call, requests);
      } else {
        response = handler(call, _toSingleFuture(requests));
      }
      return response.asStream();
    }
  }

  Future<Q> _toSingleFuture(Stream<Q> stream) {
    Q _ensureOnlyOneRequest(Q previous, Q element) {
      if (previous != null) {
        throw new GrpcError.unimplemented('More than one request received');
      }
      return element;
    }

    Q _ensureOneRequest(Q value) {
      if (value == null)
        throw new GrpcError.unimplemented('No requests received');
      return value;
    }

    final future =
        stream.fold(null, _ensureOnlyOneRequest).then(_ensureOneRequest);
    // Make sure errors on the future aren't unhandled, but return the original
    // future so the request handler can also get the error.
    future.catchError((_) {});
    return future;
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

  ServiceMethod $lookupMethod(String name) => _$methods[name];
}
