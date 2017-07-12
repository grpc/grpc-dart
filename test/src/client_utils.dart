// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:grpc/src/streams.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:grpc/grpc.dart';

import 'utils.dart';

class MockConnection extends Mock implements ClientTransportConnection {}

class MockStream extends Mock implements ClientTransportStream {}

class MockChannel extends Mock implements ClientChannel {}

typedef ServerMessageHandler = void Function(StreamMessage message);

class TestClient {
  final ClientChannel _channel;

  static final _$unary =
      new ClientMethod<int, int>('/Test/Unary', mockEncode, mockDecode);
  static final _$clientStreaming = new ClientMethod<int, int>(
      '/Test/ClientStreaming', mockEncode, mockDecode);
  static final _$serverStreaming = new ClientMethod<int, int>(
      '/Test/ServerStreaming', mockEncode, mockDecode);
  static final _$bidirectional =
      new ClientMethod<int, int>('/Test/Bidirectional', mockEncode, mockDecode);

  TestClient(this._channel);

  ResponseFuture<int> unary(int request, {CallOptions options}) {
    final call = new ClientCall(_channel, _$unary, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseFuture(call);
  }

  ResponseFuture<int> clientStreaming(Stream<int> request,
      {CallOptions options}) {
    final call = new ClientCall(_channel, _$clientStreaming, options: options);
    request.pipe(call.request);
    return new ResponseFuture(call);
  }

  ResponseStream<int> serverStreaming(int request, {CallOptions options}) {
    final call = new ClientCall(_channel, _$serverStreaming, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseStream(call);
  }

  ResponseStream<int> bidirectional(Stream<int> request,
      {CallOptions options}) {
    final call = new ClientCall(_channel, _$bidirectional, options: options);
    request.pipe(call.request);
    return new ResponseStream(call);
  }
}

class ClientHarness {
  MockConnection connection;
  MockChannel channel;
  MockStream stream;

  StreamController<StreamMessage> fromClient;
  StreamController<StreamMessage> toClient;

  TestClient client;

  void setUp() {
    connection = new MockConnection();
    channel = new MockChannel();
    stream = new MockStream();
    fromClient = new StreamController();
    toClient = new StreamController();
    when(channel.host).thenReturn('test');
    when(channel.connect()).thenReturn(connection);
    when(connection.makeRequest(any)).thenReturn(stream);
    when(stream.outgoingMessages).thenReturn(fromClient.sink);
    when(stream.incomingMessages).thenReturn(toClient.stream);
    client = new TestClient(channel);
  }

  void tearDown() {
    fromClient.close();
    toClient.close();
  }

  void sendResponseHeader({List<Header> headers = const []}) {
    toClient.add(new HeadersStreamMessage(headers));
  }

  void sendResponseValue(int value) {
    toClient
        .add(new DataStreamMessage(GrpcHttpEncoder.frame(mockEncode(value))));
  }

  void sendResponseTrailer(
      {List<Header> headers = const [], bool closeStream = true}) {
    toClient.add(new HeadersStreamMessage(headers, endStream: true));
    if (closeStream) toClient.close();
  }

  Future<Null> runTest(
      {Future clientCall,
      dynamic expectedResult,
      String expectedPath,
      Map<String, String> expectedCustomHeaders,
      List<MessageHandler> serverHandlers = const [],
      Function doneHandler,
      bool expectDone = true}) async {
    int serverHandlerIndex = 0;
    void handleServerMessage(StreamMessage message) {
      serverHandlers[serverHandlerIndex++](message);
    }

    final clientSubscription = fromClient.stream.listen(
        expectAsync1(handleServerMessage, count: serverHandlers.length),
        onError: expectAsync1((_) {}, count: 0),
        onDone: expectAsync0(doneHandler ?? () {}, count: expectDone ? 1 : 0));

    final result = await clientCall;
    if (expectedResult != null) {
      expect(result, expectedResult);
    }

    verify(channel.connect()).called(1);

    final List<Header> capturedHeaders =
        verify(connection.makeRequest(captureAny)).captured.single;
    validateRequestHeaders(capturedHeaders,
        path: expectedPath, customHeaders: expectedCustomHeaders);

    await clientSubscription.cancel();
  }

  Future<Null> expectThrows(Future future, dynamic exception) async {
    try {
      await future;
      fail('Did not throw');
    } catch (e) {
      expect(e, exception);
    }
  }

  Future<Null> runFailureTest(
      {Future clientCall,
      dynamic expectedException,
      String expectedPath,
      Map<String, String> expectedCustomHeaders,
      List<MessageHandler> serverHandlers = const [],
      bool expectDone = true}) async {
    return runTest(
      clientCall: expectThrows(clientCall, expectedException),
      expectedPath: expectedPath,
      expectedCustomHeaders: expectedCustomHeaders,
      serverHandlers: serverHandlers,
      expectDone: expectDone,
    );
  }
}
