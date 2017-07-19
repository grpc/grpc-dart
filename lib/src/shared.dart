// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:grpc/src/client.dart';
import 'package:grpc/src/status.dart';

/// Convert [timeout] to grpc-timeout header string format.
// Mostly inspired by grpc-java implementation.
// TODO(jakobr): Modify to match grpc/core implementation instead.
String toTimeoutString(Duration duration) {
  if (duration == null) return null;
  const cutoff = 100000;
  final timeout = duration.inMicroseconds;
  if (timeout < 0) {
    // Smallest possible timeout.
    return '1n';
  } else if (timeout < cutoff) {
    return '${timeout}u';
  } else if (timeout < cutoff * 1000) {
    return '${timeout~/1000}m';
  } else if (timeout < cutoff * 1000 * 1000) {
    return '${timeout~/1000000}S';
  } else if (timeout < cutoff * 1000 * 1000 * 60) {
    return '${timeout~/60000000}M';
  } else {
    return '${timeout~/3600000000}H';
  }
}

/// Convert [timeout] from grpc-timeout header string format to [Duration].
/// Returns [null] if [timeout] is not correctly formatted.
Duration fromTimeoutString(String timeout) {
  if (timeout == null) return null;
  if (timeout.length < 2) return null;
  try {
    final value = int.parse(timeout.substring(0, timeout.length - 1));
    switch (timeout[timeout.length - 1]) {
      case 'n':
        return new Duration(microseconds: value * 1000);
      case 'u':
        return new Duration(microseconds: value);
      case 'm':
        return new Duration(milliseconds: value);
      case 'S':
        return new Duration(seconds: value);
      case 'M':
        return new Duration(minutes: value);
      case 'H':
        return new Duration(hours: value);
      default:
        return null;
    }
  } catch (_) {
    return null;
  }
}

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
