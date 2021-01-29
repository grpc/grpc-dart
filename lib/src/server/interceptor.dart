import 'dart:async';

import '../shared/status.dart';
import 'call.dart';
import 'service.dart';

/// A gRPC Interceptor.
///
/// An interceptor is called before the corresponding [ServiceMethod] invocation.
/// If the interceptor returns a [GrpcError], the error will be returned as a response and [ServiceMethod] wouldn't be called.
/// If the interceptor throws [Exception], [GrpcError.internal] with exception.toString() will be returned.
/// If the interceptor returns null, the corresponding [ServiceMethod] of [Service] will be called.
typedef Interceptor = FutureOr<GrpcError?> Function(
    ServiceCall call, ServiceMethod method);
