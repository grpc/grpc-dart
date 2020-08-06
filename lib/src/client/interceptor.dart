import 'package:grpc/service_api.dart';

import 'call.dart';
import 'method.dart';

typedef ClientUnaryInvoker = ResponseFuture Function(
    ClientMethod method, dynamic request, CallOptions options);

class ClientUnaryInterceptor {
  ResponseFuture interceptUnary(ClientMethod method, dynamic request,
      CallOptions options, ClientUnaryInvoker invoker) {
    return invoker(method, request, options);
  }
}

typedef ClientStreamingInvoker = ResponseStream Function(
    ClientMethod method, Stream requests, CallOptions options);

class ClientStreamingInterceptor {
  ResponseStream interceptStreaming(ClientMethod method, Stream requests,
      CallOptions options, ClientStreamingInvoker invoker) {
    return invoker(method, requests, options);
  }
}
