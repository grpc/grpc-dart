import 'dart:async';

import 'call.dart';
import 'method.dart';

typedef ClientInvoker = ClientCall Function(
    ClientMethod method, Stream requests, CallOptions options);

/// A client-side gRPC interceptor.
///
/// The interceptor is called before making the request, optionally modify the request,
/// and then call [invoker] to send the request.
typedef ClientInterceptor = ClientCall Function(
    ClientMethod method, Stream requests, CallOptions options, ClientInvoker invoker);
