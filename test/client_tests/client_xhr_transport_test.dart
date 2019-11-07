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
@TestOn('browser')

import 'dart:async';

import 'dart:html';

import 'package:grpc/src/client/transport/xhr_transport.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

class MockHttpRequest extends Mock implements HttpRequest {
  // ignore: close_sinks
  StreamController<Event> readyStateChangeController =
      StreamController<Event>();
  // ignore: close_sinks
  StreamController<ProgressEvent> progressController =
      StreamController<ProgressEvent>();

  @override
  Stream<Event> get onReadyStateChange => readyStateChangeController.stream;

  @override
  Stream<ProgressEvent> get onProgress => progressController.stream;

  @override
  Stream<ProgressEvent> get onError => StreamController<ProgressEvent>().stream;

  @override
  int status = 200;
}

class MockXhrClientConnection extends XhrClientConnection {
  MockXhrClientConnection() : super(Uri.parse('test:8080'));

  MockHttpRequest latestRequest;

  @override
  createHttpRequest() {
    final request = MockHttpRequest();
    latestRequest = request;
    return request;
  }
}

void main() {
  test('Make request sends correct headers', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();

    connection.makeRequest('path', Duration(seconds: 10), metadata,
        (error) => fail(error.toString()));

    verify(connection.latestRequest
        .setRequestHeader('Content-Type', 'application/grpc-web+proto'));
    verify(connection.latestRequest
        .setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1'));
    verify(connection.latestRequest.setRequestHeader('X-Grpc-Web', '1'));
    verify(connection.latestRequest
        .overrideMimeType('text/plain; charset=x-user-defined'));
    verify(connection.latestRequest.responseType = 'text');
  });

  test('Sent data converted to stream properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);
    await stream.terminate();

    final expectedData = frame(data);
    expect(verify(connection.latestRequest.send(captureAny)).captured.single,
        expectedData);
  });

  test('Stream handles headers properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final transport = MockXhrClientConnection();

    final stream = transport.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));

    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        message.metadata.forEach((key, value) {
          expect(value, metadata[key]);
        });
      }
    });
  });

  test('Stream handles trailers properly', () async {
    final trailers = <String, String>{
      'trailer_1': 'value_1',
      'trailer_2': 'value_2'
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        {}, (error) => fail(error.toString()));

    final encodedTrailers = frame(trailers.entries
        .map((e) => '${e.key}:${e.value}')
        .join('\r\n')
        .codeUnits);
    encodedTrailers[0] = 0x80; // Mark this frame as trailers.
    final encodedString = String.fromCharCodes(encodedTrailers);

    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        message.metadata.forEach((key, value) {
          expect(value, trailers[key]);
        });
      }
    });
    when(connection.latestRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(connection.latestRequest.responseHeaders).thenReturn({});
    when(connection.latestRequest.readyState)
        .thenReturn(HttpRequest.HEADERS_RECEIVED);
    when(connection.latestRequest.response).thenReturn(encodedString);
    connection.latestRequest.readyStateChangeController.add(null);
    connection.latestRequest.progressController.add(null);
  });

  test('Stream handles empty trailers properly', () async {
    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        {}, (error) => fail(error.toString()));

    final encoded = frame(''.codeUnits);
    encoded[0] = 0x80; // Mark this frame as trailers.
    final encodedString = String.fromCharCodes(encoded);

    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        message.metadata.isEmpty;
      }
    });
    when(connection.latestRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(connection.latestRequest.responseHeaders).thenReturn({});
    when(connection.latestRequest.readyState)
        .thenReturn(HttpRequest.HEADERS_RECEIVED);
    when(connection.latestRequest.response).thenReturn(encodedString);
    connection.latestRequest.readyStateChangeController.add(null);
    connection.latestRequest.progressController.add(null);
  });

  test('Stream deserializes data properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));
    final data = List<int>.filled(10, 224);
    final encoded = frame(data);
    final encodedString = String.fromCharCodes(encoded);

    stream.incomingMessages.listen(expectAsync1((message) {
      if (message is GrpcData) {
        expect(message.data, equals(data));
      }
    }, count: 2));

    when(connection.latestRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(connection.latestRequest.responseHeaders).thenReturn(metadata);
    when(connection.latestRequest.readyState)
        .thenReturn(HttpRequest.HEADERS_RECEIVED);
    when(connection.latestRequest.response).thenReturn(encodedString);
    connection.latestRequest.readyStateChangeController.add(null);
    connection.latestRequest.progressController.add(null);
  });

  test('Stream recieves multiple messages', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));

    final data = <List<int>>[
      List<int>.filled(10, 224),
      List<int>.filled(5, 124)
    ];
    final encoded = data.map((d) => frame(d));
    final encodedStrings = encoded.map((e) => String.fromCharCodes(e)).toList();

    final expectedMessages = <GrpcMessage>[
      GrpcMetadata(metadata),
      GrpcData(data[0]),
      GrpcData(data[1])
    ];
    int i = 0;
    stream.incomingMessages.listen(expectAsync1((message) {
      final expectedMessage = expectedMessages[i];
      i++;
      expect(message.runtimeType, expectedMessage.runtimeType);
      if (message is GrpcMetadata) {
        expect(message.metadata, (expectedMessage as GrpcMetadata).metadata);
      } else if (message is GrpcData) {
        expect(message.data, (expectedMessage as GrpcData).data);
      }
    }, count: expectedMessages.length));

    when(connection.latestRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(connection.latestRequest.responseHeaders).thenReturn(metadata);
    when(connection.latestRequest.readyState)
        .thenReturn(HttpRequest.HEADERS_RECEIVED);
    // At first - expected response is the first message
    when(connection.latestRequest.response)
        .thenAnswer((_) => encodedStrings[0]);
    connection.latestRequest.readyStateChangeController.add(null);
    connection.latestRequest.progressController.add(null);

    // After the first call, expected response should now be both responses together
    when(connection.latestRequest.response)
        .thenAnswer((_) => encodedStrings[0] + encodedStrings[1]);
    connection.latestRequest.progressController.add(null);
  });
}
