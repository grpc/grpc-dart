import 'call.dart';
import 'common.dart';
import 'method.dart';

typedef ClientUnaryInvoker<Q, R> = ResponseFuture<R> Function(
    ClientMethod method, Q request, CallOptions options);

typedef ClientStreamingInvoker<Q, R> = ResponseStream<R> Function(
    ClientMethod method, Stream<Q> requests, CallOptions options);

/// ClientInterceptors intercepts client unary and streaming calls before
/// they are executed.
///
/// Invoker argument either calls next interceptor in the chain or performs
/// the call if it is last in chain.
abstract class ClientInterceptor {
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    return invoker(method, request, options);
  }

  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options);
  }
}
