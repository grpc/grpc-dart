// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:grpc/src/streams.dart';
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
    $addMethod(new ServiceMethod('RequestError', _bidirectional, true, true,
        (List<int> value) => throw 'Failed', mockEncode));
    $addMethod(new ServiceMethod('ResponseError', _bidirectional, true, true,
        mockDecode, (int value) => throw 'Failed'));
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
  set onTerminated(void value(int)) {}

  @override
  bool get canPush => true;

  @override
  ServerTransportStream push(List<Header> requestHeaders) => null;
}

class ServerHarness {
  final toServer = new StreamController<StreamMessage>();
  final fromServer = new StreamController<StreamMessage>();
  final service = new TestService();
  final server = new Server();

  static ServiceMethod<int, int> createMethod(String name,
      Function methodHandler, bool clientStreaming, bool serverStreaming) {
    return new ServiceMethod<int, int>(name, methodHandler, clientStreaming,
        serverStreaming, mockDecode, mockEncode);
  }

  void setUp() {
    server.addService(service);
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
      String timeout,
      Map<String, String> metadata}) {
    final headers = ClientCall.createCallHeaders(path, authority,
        timeout: timeout, metadata: metadata);
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
