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
import 'package:mockito/mockito.dart';

import 'package:grpc/grpc.dart';

import 'utils.dart';

class MockTransport extends Mock implements ClientTransportConnection {}

class MockStream extends Mock implements ClientTransportStream {}

class FakeConnection extends ClientConnection {
  final ClientTransportConnection transport;

  var connectionError;

  FakeConnection(String host, this.transport, ChannelOptions options)
      : super(host, 443, options);

  @override
  Future<ClientTransportConnection> connectTransport() async {
    if (connectionError != null) throw connectionError;
    return transport;
  }
}

Duration testBackoff(Duration lastBackoff) => const Duration(milliseconds: 1);

class FakeChannelOptions implements ChannelOptions {
  Http2Options http2 = const Http2Options();
  ChannelCredentials credentials = const ChannelCredentials.secure();
  Duration idleTimeout = const Duration(seconds: 1);
  BackoffStrategy backoffStrategy = testBackoff;
}

class FakeChannel extends ClientChannel {
  final ClientConnection connection;
  final FakeChannelOptions options;

  FakeChannel(String host, this.connection, this.options)
      : super(host, options: options);

  @override
  Future<ClientConnection> getConnection() async => connection;
}

typedef ServerMessageHandler = void Function(StreamMessage message);

class TestClient extends Client {
  static final _$unary =
      new ClientMethod<int, int>('/Test/Unary', mockEncode, mockDecode);
  static final _$clientStreaming = new ClientMethod<int, int>(
      '/Test/ClientStreaming', mockEncode, mockDecode);
  static final _$serverStreaming = new ClientMethod<int, int>(
      '/Test/ServerStreaming', mockEncode, mockDecode);
  static final _$bidirectional =
      new ClientMethod<int, int>('/Test/Bidirectional', mockEncode, mockDecode);

  TestClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<int> unary(int request, {CallOptions options}) {
    final call = $createCall(_$unary, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<int> clientStreaming(Stream<int> request,
      {CallOptions options}) {
    final call = $createCall(_$clientStreaming, request, options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<int> serverStreaming(int request, {CallOptions options}) {
    final call = $createCall(
        _$serverStreaming, new Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
  }

  ResponseStream<int> bidirectional(Stream<int> request,
      {CallOptions options}) {
    final call = $createCall(_$bidirectional, request, options: options);
    return new ResponseStream(call);
  }
}

class ClientHarness {
  MockTransport transport;
  FakeConnection connection;
  FakeChannel channel;
  FakeChannelOptions channelOptions;
  MockStream stream;

  StreamController<StreamMessage> fromClient;
  StreamController<StreamMessage> toClient;

  TestClient client;

  void setUp() {
    transport = new MockTransport();
    channelOptions = new FakeChannelOptions();
    connection = new FakeConnection('test', transport, channelOptions);
    channel = new FakeChannel('test', connection, channelOptions);
    stream = new MockStream();
    fromClient = new StreamController();
    toClient = new StreamController();
    when(transport.makeRequest(any, endStream: anyNamed('endStream')))
        .thenReturn(stream);
    when(transport.onActiveStateChanged = captureAny).thenReturn(null);
    when(stream.outgoingMessages).thenReturn(fromClient.sink);
    when(stream.incomingMessages).thenAnswer((_) => toClient.stream);
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

  void signalIdle() {
    final ActiveStateHandler handler =
        verify(transport.onActiveStateChanged = captureAny).captured.single;
    expect(handler, isNotNull);
    handler(false);
  }

  Future<Null> runTest(
      {Future clientCall,
      dynamic expectedResult,
      String expectedPath,
      Duration expectedTimeout,
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

    final List<Header> capturedHeaders =
        verify(transport.makeRequest(captureAny)).captured.single;
    validateRequestHeaders(capturedHeaders,
        path: expectedPath,
        timeout: toTimeoutString(expectedTimeout),
        customHeaders: expectedCustomHeaders);

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
      Duration expectedTimeout,
      Map<String, String> expectedCustomHeaders,
      List<MessageHandler> serverHandlers = const [],
      bool expectDone = true}) async {
    return runTest(
      clientCall: expectThrows(clientCall, expectedException),
      expectedPath: expectedPath,
      expectedTimeout: expectedTimeout,
      expectedCustomHeaders: expectedCustomHeaders,
      serverHandlers: serverHandlers,
      expectDone: expectDone,
    );
  }
}
