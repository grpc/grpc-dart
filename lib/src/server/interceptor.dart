import '../shared/status.dart';

import 'call.dart';
import 'service.dart';

/// A gRPC Interceptor.
///
/// Interceptor is called before correspoding [ServiceMethod] invocation.
/// If interceptor returns [GrpcError], the error will be returned as a response and [ServiceMethod] wouldn't be called.
/// If interceptor throws [Exception], [GrpcError.internal] with exception.toString() will be returned.
/// If interceptor returns null, correspoding [ServiceMethod] of [Service] will be called.
typedef Interceptor = GrpcError Function(
    ServiceCall call, ServiceMethod method);
