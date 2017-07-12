// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:grpc/src/client.dart';
import 'package:grpc/src/status.dart';

/// A gRPC response.
abstract class Response {
  /// Header metadata returned from the server.
  ///
  /// The [headers] future will complete before any response objects become
  /// available. If [cancel] is called before the headers are available, the
  /// returned future will complete with an error.
  Future<Map<String, String>> get headers;

  /// Trailer metadata returned from the server.
  ///
  /// The [trailers] future will complete after all responses have been received
  /// from the server. If [cancel] is called before the trailers are available,
  /// the returned future will complete with an error.
  Future<Map<String, String>> get trailers;

  /// Cancel this gRPC call. Any remaining request objects will not be sent, and
  /// no further responses will be received.
  Future<Null> cancel();
}

/// A gRPC response producing a single value.
class ResponseFuture<R> extends DelegatingFuture<R>
    with _ResponseMixin<dynamic, R> {
  final ClientCall<dynamic, R> _call;

  static R _ensureOnlyOneResponse<R>(R previous, R element) {
    if (previous != null) {
      throw new GrpcError.unimplemented('More than one response received');
    }
    return element;
  }

  static R _ensureOneResponse<R>(R value) {
    if (value == null)
      throw new GrpcError.unimplemented('No responses received');
    return value;
  }

  ResponseFuture(this._call)
      : super(_call.response
            .fold(null, _ensureOnlyOneResponse)
            .then(_ensureOneResponse));
}

/// A gRPC response producing a stream of values.
class ResponseStream<R> extends DelegatingStream<R>
    with _ResponseMixin<dynamic, R> {
  final ClientCall<dynamic, R> _call;

  ResponseStream(this._call) : super(_call.response);
}

abstract class _ResponseMixin<Q, R> implements Response {
  ClientCall<Q, R> get _call;

  @override
  Future<Map<String, String>> get headers => _call.headers;

  @override
  Future<Map<String, String>> get trailers => _call.trailers;

  @override
  Future<Null> cancel() => _call.cancel();
}
