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

import 'package:grpc/src/shared/streams.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

import 'package:grpc/grpc.dart';

import 'utils.dart';

class TestService extends Service {
  @override
  String get $name => 'Test';

  Future<int> Function(ServiceCall call, Future<int> request) unaryHandler;
  Future<int> Function(ServiceCall call, Stream<int> request)
      clientStreamingHandler;
  Stream<int> Function(ServiceCall call, Future<int> request)
      serverStreamingHandler;
  Stream<int> Function(ServiceCall call, Stream<int> request)
      bidirectionalHandler;

  TestService() {
    $addMethod(ServerHarness.createMethod('Unary', _unary, false, false));
    $addMethod(ServerHarness.createMethod(
        'ClientStreaming', _clientStreaming, true, false));
    $addMethod(ServerHarness.createMethod(
        'ServerStreaming', _serverStreaming, false, true));
    $addMethod(ServerHarness.createMethod(
        'Bidirectional', _bidirectional, true, true));
    $addMethod(new ServiceMethod<int, int>('RequestError', _bidirectional, true,
        true, (List<int> value) => throw 'Failed', mockEncode));
    $addMethod(new ServiceMethod<int, int>('ResponseError', _bidirectional,
        true, true, mockDecode, (int value) => throw 'Failed'));
  }

  Future<int> _unary(ServiceCall call, Future<int> request) {
    if (unaryHandler == null) {
      fail('Should not invoke Unary');
    }
    return unaryHandler(call, request);
  }

  Future<int> _clientStreaming(ServiceCall call, Stream<int> request) {
    if (clientStreamingHandler == null) {
      fail('Should not invoke ClientStreaming');
    }
    return clientStreamingHandler(call, request);
  }

  Stream<int> _serverStreaming(ServiceCall call, Future<int> request) {
    if (serverStreamingHandler == null) {
      fail('Should not invoke ServerStreaming');
    }
    return serverStreamingHandler(call, request);
  }

  Stream<int> _bidirectional(ServiceCall call, Stream<int> request) {
    if (bidirectionalHandler == null) {
      fail('Should not invoke Bidirectional');
    }
    return bidirectionalHandler(call, request);
  }
}

class TestInterceptor {
  Interceptor handler;

  FutureOr<GrpcError> call(ServiceCall call, ServiceMethod method) {
    if (handler == null) {
      return null;
    }

    return handler(call, method);
  }
}

class TestServerStream extends ServerTransportStream {
  final Stream<StreamMessage> incomingMessages;
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
  set onTerminated(void value(int x)) {}

  @override
  bool get canPush => true;

  @override
  ServerTransportStream push(List<Header> requestHeaders) => null;
}

class ServerHarness {
  final toServer = new StreamController<StreamMessage>();
  final fromServer = new StreamController<StreamMessage>();
  final service = new TestService();
  final interceptor = new TestInterceptor();

  Server server;

  ServerHarness() {
    server = new Server(<Service>[service], <Interceptor>[interceptor]);
  }

  static ServiceMethod<int, int> createMethod(String name,
      Function methodHandler, bool clientStreaming, bool serverStreaming) {
    return new ServiceMethod<int, int>(name, methodHandler, clientStreaming,
        serverStreaming, mockDecode, mockEncode);
  }

  void setUp() {
    final stream = new TestServerStream(toServer.stream, fromServer.sink);
    server.serveStream(stream);
  }

  void tearDown() {
    fromServer.close();
    toServer.close();
  }

  void setupTest(List<MessageHandler> handlers) {
    int handlerIndex = 0;
    void handleMessages(StreamMessage message) {
      handlers[handlerIndex++](message);
    }

    fromServer.stream.listen(
        expectAsync1(handleMessages, count: handlers.length),
        onError: expectAsync1((_) {}, count: 0),
        onDone: expectAsync0(() {}, count: 1));
  }

  void expectErrorResponse(int status, String message) {
    setupTest([errorTrailerValidator(status, message, validateHeader: true)]);
  }

  void expectTrailingErrorResponse(int status, String message) {
    setupTest([
      headerValidator(),
      errorTrailerValidator(status, message, validateHeader: false)
    ]);
  }

  void sendRequestHeader(String path,
      {String authority = 'test',
      Map<String, String> metadata,
      Duration timeout}) {
    final headers = ClientConnection.createCallHeaders(
        true, authority, path, timeout, metadata);
    toServer.add(new HeadersStreamMessage(headers));
  }

  void sendData(int value) {
    toServer
        .add(new DataStreamMessage(GrpcHttpEncoder.frame(mockEncode(value))));
  }

  void runTest(String path, List<int> requests, List<int> expectedResponses) {
    void handleHeader(StreamMessage message) {
      final header = validateMetadataMessage(message);
      validateResponseHeaders(header.metadata);
    }

    int responseIndex = 0;
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
