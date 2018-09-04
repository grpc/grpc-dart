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

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/options.dart';
import 'package:grpc/src/client/transport/xhr_transport.dart';
import 'package:mockito/mockito.dart';

import 'package:test/test.dart';

class MockHttpRequest extends Mock implements HttpRequest {}

class MockXhrTransport extends XhrTransport {
  StreamController<Event> readyStateChangeStream = new StreamController<Event>();
  StreamController<ProgressEvent> progressStream = new StreamController<ProgressEvent>();

  MockHttpRequest mockRequest;

  MockXhrTransport(this.mockRequest)
    : super("test", 8080, new ChannelOptions()) {

    }

  @override
  GrpcTransportStream makeRequest(String path, Duration timeout, Map<String, String> metadata) {
    when(mockRequest.onReadyStateChange).thenAnswer((_) => readyStateChangeStream.stream);
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

  setUp(() {

  });

  test('Make request sends correct headers', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

    final mockRequest = new MockHttpRequest();
    final transport = new MockXhrTransport(mockRequest);

    transport.makeRequest('path', Duration(seconds: 10), metadata);

    verify(mockRequest.setRequestHeader('Content-Type', 'application/grpc-web+proto'));
    verify(mockRequest.setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1'));
    verify(mockRequest.setRequestHeader('X-Grpc-Web', '1'));
    verify(mockRequest.overrideMimeType('text/plain; charset=x-user-defined'));
    verify(mockRequest.responseType = 'text');
  });

  test('Sent data converted to stream properly', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

    final mockRequest = new MockHttpRequest();
    final transport = new MockXhrTransport(mockRequest);

    final stream = transport.makeRequest('path', Duration(seconds: 10), metadata);

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);

    final expectedData = GrpcHttpEncoder.frame(data);
    verify(mockRequest.send(captureAny));
    //expect(.captured.single, expectedData);
  });

  // test('StreamMessages deserializes headers properly', () async {
  //   final metadata = <String, String>{
  //     "parameter_1": "value_1",
  //     "parameter_2": "value_2"
  //   };

  //   final mockRequest = new MockHttpRequest();
  //   final transport = new MockXhrTransport(mockRequest);

  //   final stream =
  //       transport.makeRequest('test_path', Duration(seconds: 10), metadata);

  //   stream.incomingMessages.listen((message) {
  //     expect(message, TypeMatcher<GrpcMetadata>());
  //     if (message is GrpcMetadata) {
  //       message.metadata.forEach((key, value) {
  //         expect(value, metadata[key]);
  //       });
  //     }
  //   });

  //   final httpMessage = GrpcHttpEncoder().convert(GrpcMetadata(metadata));
  //   transport.readyStateChangeStream.add(event)
  // });

  // test('StreamMessages deserializes data properly', () async {
  //   final metadata = <String, String>{
  //     "parameter_1": "value_1",
  //     "parameter_2": "value_2"
  //   };

  //   final mockRequest = new MockHttpRequest();
  //   final transport = new MockXhrTransport(mockRequest);

  //   final stream =
  //       transport.makeRequest('test_path', Duration(seconds: 10), metadata);
  //   final data = List<int>.filled(10, 0);
  //   stream.incomingMessages.listen((message) {
  //     expect(message, TypeMatcher<GrpcData>());
  //     if (message is GrpcData) {
  //       expect(message.data, equals(data));
  //     }
  //   });

  //   final httpMessage = GrpcHttpEncoder().convert(GrpcData(data));
  //   transport.toClient.add(httpMessage);
  // });
}
