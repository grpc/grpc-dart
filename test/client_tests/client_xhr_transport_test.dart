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

import 'package:grpc/grpc_web.dart';
import 'package:grpc/src/client/transport/xhr_transport.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

class MockHttpRequest extends Mock implements HttpRequest {}

class MockXhrTransport extends XhrTransport {
  StreamController<Event> readyStateChangeStream = StreamController<Event>();
  StreamController<ProgressEvent> progressStream =
      StreamController<ProgressEvent>();

  MockHttpRequest mockRequest;

  MockXhrTransport(this.mockRequest) : super('test', 8080) {}

  @override
  GrpcTransportStream makeRequest(
      String path, Duration timeout, Map<String, String> metadata) {
    when(mockRequest.onReadyStateChange)
        .thenAnswer((_) => readyStateChangeStream.stream);
    when(mockRequest.onProgress).thenAnswer((_) => progressStream.stream);

    initializeRequest(mockRequest, metadata);

    return XhrTransportStream(mockRequest);
  }

  @override
  Future<void> terminate() async {
    readyStateChangeStream.close();
    progressStream.close();
  }
}

void main() {
  test('Make request sends correct headers', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final mockRequest = MockHttpRequest();
    final transport = MockXhrTransport(mockRequest);

    transport.makeRequest('path', Duration(seconds: 10), metadata);

    verify(mockRequest.setRequestHeader(
        'Content-Type', 'application/grpc-web+proto'));
    verify(mockRequest.setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1'));
    verify(mockRequest.setRequestHeader('X-Grpc-Web', '1'));
    verify(mockRequest.overrideMimeType('text/plain; charset=x-user-defined'));
    verify(mockRequest.responseType = 'text');
  });

  test('Sent data converted to stream properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final mockRequest = MockHttpRequest();
    final transport = MockXhrTransport(mockRequest);

    final stream =
        transport.makeRequest('path', Duration(seconds: 10), metadata);

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);
    await stream.terminate();

    final expectedData = frame(data);
    expect(verify(mockRequest.send(captureAny)).captured.single, expectedData);
  });

  test('Stream handles headers properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final mockRequest = MockHttpRequest();
    final transport = MockXhrTransport(mockRequest);

    final stream =
        transport.makeRequest('test_path', Duration(seconds: 10), metadata);

    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcMetadata>());
      if (message is GrpcMetadata) {
        message.metadata.forEach((key, value) {
          expect(value, metadata[key]);
        });
      }
    });
  });

  test('Stream deserializes data properly', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final mockRequest = MockHttpRequest();
    final transport = MockXhrTransport(mockRequest);

    final stream =
        transport.makeRequest('test_path', Duration(seconds: 10), metadata);
    final data = List<int>.filled(10, 224);
    final encoded = frame(data);
    final encodedString = String.fromCharCodes(encoded);

    bool dataVerified = false;
    stream.incomingMessages.listen((message) {
      if (message is GrpcData) {
        dataVerified = true;
        expect(message.data, equals(data));
      }
    });

    when(mockRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(mockRequest.responseHeaders).thenReturn(metadata);
    when(mockRequest.readyState).thenReturn(HttpRequest.HEADERS_RECEIVED);
    when(mockRequest.response).thenReturn(encodedString);
    transport.readyStateChangeStream.add(null);
    transport.progressStream.add(null);

    // Wait for all streams to process
    await Future.sync(() {});

    await stream.terminate();
    expect(dataVerified, true);
  });

  test('Stream recieves multiple messages', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2'
    };

    final mockRequest = MockHttpRequest();
    final transport = MockXhrTransport(mockRequest);

    final stream =
        transport.makeRequest('test_path', Duration(seconds: 10), metadata);

    final data = <List<int>>[
      List<int>.filled(10, 224),
      List<int>.filled(5, 124)
    ];
    final encoded = data.map((d) => frame(d));
    final encodedStrings = encoded.map((e) => String.fromCharCodes(e)).toList();
    // to start - expected response is the first message
    var expectedResponse = encodedStrings[0];

    final expectedMessages = <GrpcMessage>[
      GrpcMetadata(metadata),
      GrpcData(data[0]),
      GrpcData(data[1])
    ];
    stream.incomingMessages.listen((message) {
      final expectedMessage = expectedMessages.removeAt(0);
      expect(message.runtimeType, expectedMessage.runtimeType);
      if (message is GrpcMetadata) {
        expect(message.metadata, (expectedMessage as GrpcMetadata).metadata);
      } else if (message is GrpcData) {
        expect(message.data, (expectedMessage as GrpcData).data);
      }
    });

    when(mockRequest.getResponseHeader('Content-Type'))
        .thenReturn('application/grpc+proto');
    when(mockRequest.responseHeaders).thenReturn(metadata);
    when(mockRequest.readyState).thenReturn(HttpRequest.HEADERS_RECEIVED);
    when(mockRequest.response).thenAnswer((_) => expectedResponse);
    transport.readyStateChangeStream.add(null);
    transport.progressStream.add(null);
    // Wait for all streams to process
    await Future.sync(() {});

    // After the first call, expected response should now be both responses together
    expectedResponse = encodedStrings[0] + encodedStrings[1];
    transport.progressStream.add(null);

    // Wait for all streams to process
    await Future.sync(() {});

    await stream.terminate();
    expect(expectedMessages.isEmpty, isTrue);
  });
}
