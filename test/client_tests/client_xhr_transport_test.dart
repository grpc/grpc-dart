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

import 'package:grpc/src/client/transport/xhr_transport.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements Client {}

class MockRequest extends Mock implements Request {}

class MockXhrClientConnection extends XhrClientConnection {
  MockXhrClientConnection() : super(Uri.parse('test:8080'));

  MockRequest latestRequest = MockRequest();
  final client = MockClient();

  @override
  createHttpRequest(String path) {
    return latestRequest;
  }

  @override
  createClient() {
    return client;
  }
}

void main() {
  test('Make request sends correct headers', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    connection.makeRequest('path', Duration(seconds: 10), metadata,
        (error) => fail(error.toString()));

    expect(connection.latestRequest.headers['Content-Type'],
        'application/grpc-web+proto');
    expect(
        connection.latestRequest.headers['X-User-Agent'], 'grpc-web-dart/0.1');
    expect(connection.latestRequest.headers['X-Grpc-Web'], '1');
  });

  test('Sent data converted to stream properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    final stream = connection.makeRequest('path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));

    when(connection.client.send(captureAny)).thenAnswer(
        (_) => Future.value(StreamedResponse(Stream.fromIterable([]), 200)));
    final data = List.filled(10, 0);
    final expectedData = frame(data);

    stream.outgoingMessages.add(data);
    await stream.terminate();

    verify(connection.latestRequest.bodyBytes = expectedData);
  });

  test('Stream handles headers properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2',
      'content-type': 'application/grpc+proto',
    };

    final transport = MockXhrClientConnection();
    when(transport.latestRequest.headers).thenReturn({});

    final stream = transport.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));
    when(transport.client.send(captureAny)).thenAnswer((_) {
      return Future.value(
          StreamedResponse(Stream.fromIterable([]), 200, headers: metadata));
    });

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);

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
      'trailer_2': 'value_2',
    };

    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    final encodedTrailers = frame(trailers.entries
        .map((e) => '${e.key}:${e.value}')
        .join('\r\n')
        .codeUnits);
    encodedTrailers[0] = 0x80; // Mark this frame as trailers.
    final response = StreamedResponse(
        Future.value(encodedTrailers).asStream(), 200,
        headers: {'content-type': 'application/grpc+proto'});
    when(connection.client.send(connection.latestRequest))
        .thenAnswer((_) => Future.value(response));

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        {}, (error) => fail(error.toString()));

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);

    bool first = true;
    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        if (first) {
          expect(message.metadata.length, 1);
          expect(message.metadata.entries.first.key, 'content-type');
          expect(
              message.metadata.entries.first.value, 'application/grpc+proto');
          first = false;
        } else {
          message.metadata.forEach((key, value) {
            expect(value, trailers[key]);
          });
        }
      }
    });
  });

  test('Stream handles empty trailers properly', () async {
    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        {}, (error) => fail(error.toString()));

    final encoded = frame(''.codeUnits);
    encoded[0] = 0x80; // Mark this frame as trailers.
    final response = StreamedResponse(Future.value(encoded).asStream(), 200,
        headers: {'content-type': 'application/grpc+proto'});

    when(connection.client.send(connection.latestRequest))
        .thenAnswer((_) => Future.value(response));

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);

    bool trailer = false;
    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        if (trailer) {
          expect(message.metadata.isEmpty, true);
        }
        trailer = true;
      }
    });
  });

  test('Stream deserializes data properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));
    final data = List<int>.filled(10, 224);
    final encoded = frame(data);
    final response = StreamedResponse(Future.value(encoded).asStream(), 200,
        headers: {'content-type': 'application/grpc+proto'});

    stream.outgoingMessages.add(data);

    when(connection.client.send(connection.latestRequest))
        .thenAnswer((_) => Future.value(response));

    stream.incomingMessages.listen(expectAsync1((message) {
      if (message is GrpcData) {
        expect(message.data, equals(data));
      }
    }, count: 2));
  });

  test('Stream recieves multiple messages', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2',
      'content-type': 'application/grpc+proto',
    };

    final connection = MockXhrClientConnection();
    when(connection.latestRequest.headers).thenReturn({});

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error) => fail(error.toString()));

    final data = <List<int>>[
      List<int>.filled(10, 224),
      List<int>.filled(5, 124)
    ];
    final encoded = data.map((d) => frame(d));
    final response =
        StreamedResponse(Stream.fromIterable(encoded), 200, headers: metadata);

    when(connection.client.send(connection.latestRequest))
        .thenAnswer((_) => Future.value(response));

    final outData = List.filled(10, 0);
    stream.outgoingMessages.add(outData);

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
  });
}
