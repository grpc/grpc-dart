// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:grpc/src/client.dart';

/// A gRPC response.
abstract class Response {
  /// Header metadata returned from the server.
  ///
  /// The [headers] future will complete before any response objects become
  /// available.
  Future<Map<String, String>> get headers;

  /// Trailer metadata returned from the server.
  ///
  /// The [trailers] future will complete after all responses have been received
  /// from the server.
  Future<Map<String, String>> get trailers;

  /// Cancel this gRPC call.
  Future<Null> cancel();
}

/// A gRPC response producing a single value.
class ResponseFuture<R> extends DelegatingFuture<R>
    with _ResponseMixin<dynamic, R> {
  final ClientCall<dynamic, R> _call;

  ResponseFuture(this._call) : super(_call.response.single);
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

abstract class ServerContext {
  Map<String, String> get clientMetadata;

  Map<String, String> get headers;
  Map<String, String> get trailers;

  int get timeout;
  bool get isCanceled;

  void sendHeaders();
  void sendTrailer(int status, [String statusMessage]);
}
