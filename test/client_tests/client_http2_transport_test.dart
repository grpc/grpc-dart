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
@TestOn('vm')

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/transport/http2_credentials.dart';
import 'package:grpc/src/client/transport/http2_transport.dart';

import 'package:http2/transport.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../src/utils.dart';

class MockTransport extends Mock implements ClientTransportConnection {}

class MockStream extends Mock implements ClientTransportStream {}

typedef void VerifyHeadersCallback(List<Header> headers);

class MockHttp2Transport extends Http2Transport {
  MockStream mockClientStream;
  VerifyHeadersCallback onVerifyHeaders;

  StreamController<StreamMessage> fromClient;
  StreamController<StreamMessage> toClient;

  MockHttp2Transport(String host, int port, ChannelOptions options)
      : super(host, port, options);

  @override
  Future<void> connect() async {
    transport = MockTransport();

    when(transport.makeRequest(any)).thenAnswer((call) {
      if (onVerifyHeaders != null) {
        onVerifyHeaders(call.positionalArguments[0]);
      }
      mockClientStream = new MockStream();
      fromClient = StreamController<StreamMessage>();
      toClient = StreamController<StreamMessage>();
      when(mockClientStream.outgoingMessages)
          .thenAnswer((_) => fromClient.sink);
      when(mockClientStream.incomingMessages)
          .thenAnswer((_) => toClient.stream);

      return mockClientStream;
    });
  }

  @override
  Future<void> terminate() async {
    fromClient.close();
    toClient.close();
  }
}

void main() {
  final MockHttp2Transport transport = new MockHttp2Transport(
      'host',
      9999,
      ChannelOptions(
          credentials: new Http2ChannelCredentials.secure(authority: 'test'),
          transportType: TransportType.Http2));

  setUp(() {
    transport.connect();
  });

  tearDown(() {
    transport.terminate();
  });

  test('Make request passes proper headers', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

    transport.onVerifyHeaders = (headers) {
      final headerMap = headersToMap(headers);
      validateRequestHeaders(headerMap,
          path: 'test_path',
          customHeaders: metadata,
          timeout: toTimeoutString(Duration(seconds: 10)));
    };

    transport.makeRequest('test_path', Duration(seconds: 10), metadata);
  });

  test('Sent data converted to StreamMessages properly', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

    final stream =
        transport.makeRequest('test_path', Duration(seconds: 10), metadata);

    transport.fromClient.stream.listen((message) {
      final dataMessage = validateDataMessage(message);
      expect(dataMessage.data.length, 10);
    });

    stream.outgoingMessages.add(List.filled(10, 0));
  });

  test('StreamMessages deserializes headers properly', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

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

    final httpMessage = GrpcHttpEncoder().convert(GrpcMetadata(metadata));
    transport.toClient.add(httpMessage);
  });

  test('StreamMessages deserializes data properly', () async {
    final metadata = <String, String>{
      "parameter_1": "value_1",
      "parameter_2": "value_2"
    };

    final stream =
        transport.makeRequest('test_path', Duration(seconds: 10), metadata);
    final data = List<int>.filled(10, 0);
    stream.incomingMessages.listen((message) {
      expect(message, TypeMatcher<GrpcData>());
      if (message is GrpcData) {
        expect(message.data, equals(data));
      }
    });

    final httpMessage = GrpcHttpEncoder().convert(GrpcData(data));
    transport.toClient.add(httpMessage);
  });
}
