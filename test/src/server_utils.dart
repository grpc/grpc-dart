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

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'utils.dart';

class TestService extends Service {
  @override
  String get $name => 'Test';

  Future<int> Function(ServiceCall call, Future<int> request)? unaryHandler;
  Future<int> Function(ServiceCall call, Stream<int> request)?
  clientStreamingHandler;
  Stream<int> Function(ServiceCall call, Future<int> request)?
  serverStreamingHandler;
  Stream<int> Function(ServiceCall call, Stream<int> request)?
  bidirectionalHandler;

  TestService() {
    $addMethod(ServerHarness.createMethod('Unary', _unary, false, false));
    $addMethod(
      ServerHarness.createMethod(
        'ClientStreaming',
        _clientStreaming,
        true,
        false,
      ),
    );
    $addMethod(
      ServerHarness.createMethod(
        'ServerStreaming',
        _serverStreaming,
        false,
        true,
      ),
    );
    $addMethod(
      ServerHarness.createMethod('Bidirectional', _bidirectional, true, true),
    );
    $addMethod(
      ServiceMethod<int, int>(
        'RequestError',
        _bidirectional,
        true,
        true,
        (List<int> value) => throw 'Failed',
        mockEncode,
      ),
    );
    $addMethod(
      ServiceMethod<int, int>(
        'ResponseError',
        _bidirectional,
        true,
        true,
        mockDecode,
        (int value) => throw 'Failed',
      ),
    );
  }

  Future<int> _unary(ServiceCall call, Future<int> request) {
    if (unaryHandler == null) {
      fail('Should not invoke Unary');
    }
    return unaryHandler!(call, request);
  }

  Future<int> _clientStreaming(ServiceCall call, Stream<int> request) {
    if (clientStreamingHandler == null) {
      fail('Should not invoke ClientStreaming');
    }
    return clientStreamingHandler!(call, request);
  }

  Stream<int> _serverStreaming(ServiceCall call, Future<int> request) {
    if (serverStreamingHandler == null) {
      fail('Should not invoke ServerStreaming');
    }
    return serverStreamingHandler!(call, request);
  }

  Stream<int> _bidirectional(ServiceCall call, Stream<int> request) {
    if (bidirectionalHandler == null) {
      fail('Should not invoke Bidirectional');
    }
    return bidirectionalHandler!(call, request);
  }
}

class TestInterceptor {
  Interceptor? handler;

  FutureOr<GrpcError?> call(ServiceCall call, ServiceMethod method) {
    if (handler == null) {
      return null;
    }

    return handler!(call, method);
  }
}

typedef TestServerInterceptorOnStart =
    Function(ServiceCall call, ServiceMethod method, Stream requests);
typedef TestServerInterceptorOnData =
    Function(
      ServiceCall call,
      ServiceMethod method,
      Stream requests,
      dynamic data,
    );
typedef TestServerInterceptorOnFinish =
    Function(ServiceCall call, ServiceMethod method, Stream requests);

class TestServerInterceptor extends ServerInterceptor {
  TestServerInterceptorOnStart? onStart;
  TestServerInterceptorOnData? onData;
  TestServerInterceptorOnFinish? onFinish;

  TestServerInterceptor({this.onStart, this.onData, this.onFinish});

  @override
  Stream<R> intercept<Q, R>(
    ServiceCall call,
    ServiceMethod<Q, R> method,
    Stream<Q> requests,
    ServerStreamingInvoker<Q, R> invoker,
  ) async* {
    await onStart?.call(call, method, requests);

    await for (final chunk in super.intercept(
      call,
      method,
      requests,
      invoker,
    )) {
      await onData?.call(call, method, requests, chunk);
      yield chunk;
    }

    await onFinish?.call(call, method, requests);
  }
}

class TestServerInterruptingInterceptor extends ServerInterceptor {
  final R Function<R>(R) transform;

  TestServerInterruptingInterceptor({required this.transform});

  @override
  Stream<R> intercept<Q, R>(
    ServiceCall call,
    ServiceMethod<Q, R> method,
    Stream<Q> requests,
    ServerStreamingInvoker<Q, R> invoker,
  ) async* {
    yield* super.intercept(call, method, requests, invoker).map(transform);
  }
}

class TestServerStream extends ServerTransportStream {
  @override
  final Stream<StreamMessage> incomingMessages;
  @override
  final StreamSink<StreamMessage> outgoingMessages;

  TestServerStream(this.incomingMessages, this.outgoingMessages);

  @override
  int get id => -1;

  @override
  void terminate() {
    outgoingMessages.addError('TERMINATED');
    outgoingMessages.close();
  }

  @override
  set onTerminated(void Function(int x) value) {}

  @override
  bool get canPush => true;

  @override
  ServerTransportStream push(List<Header> requestHeaders) =>
      throw 'unimplemented';
}

class ServerHarness extends _Harness {
  @override
  ConnectionServer createServer() => Server.create(
    services: <Service>[service],
    interceptors: <Interceptor>[interceptor.call],
    serverInterceptors: serverInterceptors..insert(0, serverInterceptor),
  );

  static ServiceMethod<int, int> createMethod(
    String name,
    Function methodHandler,
    bool clientStreaming,
    bool serverStreaming,
  ) {
    return ServiceMethod<int, int>(
      name,
      methodHandler,
      clientStreaming,
      serverStreaming,
      mockDecode,
      mockEncode,
    );
  }
}

class ConnectionServerHarness extends _Harness {
  @override
  ConnectionServer createServer() =>
      ConnectionServer(<Service>[service], <Interceptor>[interceptor.call]);

  static ServiceMethod<int, int> createMethod(
    String name,
    Function methodHandler,
    bool clientStreaming,
    bool serverStreaming,
  ) {
    return ServiceMethod<int, int>(
      name,
      methodHandler,
      clientStreaming,
      serverStreaming,
      mockDecode,
      mockEncode,
    );
  }
}

abstract class _Harness {
  final toServer = StreamController<StreamMessage>();
  final fromServer = StreamController<StreamMessage>();
  final service = TestService();
  final interceptor = TestInterceptor();
  final serverInterceptor = TestServerInterceptor();

  final serverInterceptors = <ServerInterceptor>[];

  ConnectionServer? _server;

  ConnectionServer createServer();

  ConnectionServer get server => _server ??= createServer();

  void setUp() {
    final stream = TestServerStream(toServer.stream, fromServer.sink);
    server.serveStream_(stream: stream);
  }

  void tearDown() {
    fromServer.close();
    toServer.close();
  }

  void setupTest(List<MessageHandler> handlers) {
    var handlerIndex = 0;
    void handleMessages(StreamMessage message) {
      handlers[handlerIndex++](message);
    }

    fromServer.stream.listen(
      expectAsync1(handleMessages, count: handlers.length),
      onError: expectAsync1((dynamic _) {}, count: 0),
      onDone: expectAsync0(() {}, count: 1),
    );
  }

  void expectErrorResponse(int status, String message) {
    setupTest([errorTrailerValidator(status, message, validateHeader: true)]);
  }

  void expectTrailingErrorResponse(int status, String message) {
    setupTest([
      headerValidator(),
      errorTrailerValidator(status, message, validateHeader: false),
    ]);
  }

  void sendRequestHeader(
    String path, {
    String authority = 'test',
    Map<String, String>? metadata,
    Duration? timeout,
  }) {
    final headers = Http2ClientConnection.createCallHeaders(
      true,
      authority,
      path,
      timeout,
      metadata,
      null,
      userAgent: 'dart-grpc/1.0.0 test',
    );
    toServer.add(HeadersStreamMessage(headers));
  }

  void sendData(int value) {
    toServer.add(DataStreamMessage(frame(mockEncode(value))));
  }

  void runTest(String path, List<int> requests, List<int> expectedResponses) {
    void handleHeader(StreamMessage message) {
      final header = validateMetadataMessage(message);
      validateResponseHeaders(header.metadata);
    }

    var responseIndex = 0;
    void handleResponse(StreamMessage message) {
      final response = validateDataMessage(message);
      expect(mockDecode(response.data), expectedResponses[responseIndex++]);
    }

    void handleTrailer(StreamMessage message) {
      final trailer = validateMetadataMessage(message, endStream: true);
      validateResponseTrailers(trailer.metadata);
    }

    final handlers = [handleHeader];
    for (var i = 0; i < expectedResponses.length; i++) {
      handlers.add(handleResponse);
    }
    handlers.add(handleTrailer);

    setupTest(handlers);
    sendRequestHeader(path);
    requests.forEach(sendData);
    toServer.close();
  }
}
