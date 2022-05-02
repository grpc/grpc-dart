import 'call.dart';
import 'common.dart';
import 'method.dart';

typedef ClientUnaryInvoker<Q, R> = ResponseFuture<R> Function(
    ClientMethod<Q, R> method, Q request, CallOptions options);

typedef ClientStreamingInvoker<Q, R> = ResponseStream<R> Function(
    ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options);

/// ClientInterceptors intercepts client calls before they are executed.
///
/// Invoker either calls next interceptor in the chain or performs the call if it is last in chain.
/// To modify [CallOptions] make a clone using [CallOptions.mergedWith].
abstract class ClientInterceptor {
  /// Intercept unary call.
  ///
  /// This method is called when client sends single request and receives single response.
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    return invoker(method, request, options);
  }

  Future<Map<String, String>> interceptHeaders<Q, R>(
      ClientMethod<Q, R> method, Future<Map<String, String>> headers) {
    return headers;
  }

  Future<Map<String, String>> interceptTrailers<Q, R>(
      ClientMethod<Q, R> method, Future<Map<String, String>> trailers) {
    return trailers;
  }

  Future<R> interceptUnaryResponse<Q, R>(
      ClientMethod<Q, R> method, Q request, Future<R> response) {
    return response;
  }

  // Intercept streaming call.
  // This method is called when client sends either request or response stream.
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    return invoker(method, requests, options);
  }

  Stream<R> interceptStreamingResponse<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> request, Stream<R> response) {
    return response;
  }
}
