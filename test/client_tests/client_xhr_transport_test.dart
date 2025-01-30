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
library;

import 'dart:async';
// ignore: deprecated_member_use (#756)
import 'dart:html';

import 'package:async/async.dart';
import 'package:grpc/src/client/call.dart';
import 'package:grpc/src/client/transport/xhr_transport.dart';
import 'package:grpc/src/shared/message.dart';
import 'package:grpc/src/shared/status.dart';
import 'package:mockito/mockito.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:test/test.dart';

final readyStateChangeEvent =
    Event('readystatechange', canBubble: false, cancelable: false);
final progressEvent = ProgressEvent('onloadstart');

class MockHttpRequest extends Mock implements HttpRequest {
  MockHttpRequest({int? code}) : status = code ?? 200;
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
  final int status;

  @override
  int get readyState =>
      super.noSuchMethod(Invocation.getter(#readyState), returnValue: -1);

  @override
  Map<String, String> get responseHeaders =>
      super.noSuchMethod(Invocation.getter(#responseHeaders),
          returnValue: <String, String>{});
}

class MockXhrClientConnection extends XhrClientConnection {
  MockXhrClientConnection({int? code})
      : _statusCode = code ?? 200,
        super(Uri.parse('test:0'));

  late MockHttpRequest latestRequest;
  final int _statusCode;

  @override
  HttpRequest createHttpRequest() {
    final request = MockHttpRequest(code: _statusCode);
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
        (error, _) => fail(error.toString()));

    verify(connection.latestRequest
        .setRequestHeader('Content-Type', 'application/grpc-web+proto'));
    verify(connection.latestRequest
        .setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1'));
    verify(connection.latestRequest.setRequestHeader('X-Grpc-Web', '1'));
    verify(connection.latestRequest
        .overrideMimeType('text/plain; charset=x-user-defined'));
    verify(connection.latestRequest.responseType = 'text');
  });

  test(
      'Make request sends correct headers and path if bypassCorsPreflight=true',
      () async {
    final metadata = {'header_1': 'value_1', 'header_2': 'value_2'};
    final connection = MockXhrClientConnection();

    connection.makeRequest('path', Duration(seconds: 10), metadata,
        (error, _) => fail(error.toString()),
        callOptions: WebCallOptions(bypassCorsPreflight: true));

    expect(metadata, isEmpty);
    verify(connection.latestRequest.open('POST',
        'test:path?%24httpHeaders=header_1%3Avalue_1%0D%0Aheader_2%3Avalue_2%0D%0AContent-Type%3Aapplication%2Fgrpc-web%2Bproto%0D%0AX-User-Agent%3Agrpc-web-dart%2F0.1%0D%0AX-Grpc-Web%3A1%0D%0A'));
    verify(connection.latestRequest
        .overrideMimeType('text/plain; charset=x-user-defined'));
    verify(connection.latestRequest.responseType = 'text');
  });

  test(
      'Make request sends correct headers if call options already have '
      'Content-Type header', () async {
    final metadata = {
      'header_1': 'value_1',
      'header_2': 'value_2',
      'Content-Type': 'application/json+protobuf'
    };
    final connection = MockXhrClientConnection();

    connection.makeRequest('/path', Duration(seconds: 10), metadata,
        (error, _) => fail(error.toString()));

    expect(metadata, {
      'header_1': 'value_1',
      'header_2': 'value_2',
      'Content-Type': 'application/json+protobuf',
    });
  });

  test('Content-Type header case insensitivity', () async {
    final metadata = {
      'header_1': 'value_1',
      'CONTENT-TYPE': 'application/json+protobuf'
    };
    final connection = MockXhrClientConnection();

    connection.makeRequest('/path', Duration(seconds: 10), metadata,
        (error, _) => fail(error.toString()));
    expect(metadata, {
      'header_1': 'value_1',
      'CONTENT-TYPE': 'application/json+protobuf',
    });

    final lowerMetadata = {
      'header_1': 'value_1',
      'content-type': 'application/json+protobuf'
    };
    connection.makeRequest('/path', Duration(seconds: 10), lowerMetadata,
        (error, _) => fail(error.toString()));
    expect(lowerMetadata, {
      'header_1': 'value_1',
      'content-type': 'application/json+protobuf',
    });
  });

  test('Make request sends correct headers path if only withCredentials=true',
      () async {
    final metadata = {'header_1': 'value_1', 'header_2': 'value_2'};
    final connection = MockXhrClientConnection();

    connection.makeRequest('path', Duration(seconds: 10), metadata,
        (error, _) => fail(error.toString()),
        callOptions: WebCallOptions(withCredentials: true));

    expect(metadata, {
      'header_1': 'value_1',
      'header_2': 'value_2',
      'Content-Type': 'application/grpc-web+proto',
      'X-User-Agent': 'grpc-web-dart/0.1',
      'X-Grpc-Web': '1'
    });
    verify(connection.latestRequest
        .setRequestHeader('Content-Type', 'application/grpc-web+proto'));
    verify(connection.latestRequest
        .setRequestHeader('X-User-Agent', 'grpc-web-dart/0.1'));
    verify(connection.latestRequest.setRequestHeader('X-Grpc-Web', '1'));
    verify(connection.latestRequest.open('POST', 'test:path'));
    verify(connection.latestRequest.withCredentials = true);
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
        metadata, (error, _) => fail(error.toString()));

    final data = List.filled(10, 0);
    stream.outgoingMessages.add(data);
    await stream.terminate();

    final expectedData = frame(data);
    expect(verify(connection.latestRequest.send(captureAny)).captured.single,
        expectedData);
  });

  test('Stream handles headers properly', () async {
    final responseHeaders = {
      'parameter_1': 'value_1',
      'parameter_2': 'value_2',
      'content-type': 'application/grpc+proto',
    };

    final transport = MockXhrClientConnection();

    final stream = transport.makeRequest('test_path', Duration(seconds: 10), {},
        (error, _) => fail(error.toString()));

    when(transport.latestRequest.responseHeaders).thenReturn(responseHeaders);
    when(transport.latestRequest.response)
        .thenReturn(String.fromCharCodes(frame(<int>[])));

    // Set expectation for request readyState and generate two readyStateChange
    // events, so that incomingMessages stream completes.
    final readyStates = [HttpRequest.HEADERS_RECEIVED, HttpRequest.DONE];
    when(transport.latestRequest.readyState)
        .thenAnswer((_) => readyStates.removeAt(0));
    transport.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    transport.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);

    // Should be only one metadata message with headers augmented with :status
    // field.
    final message = await stream.incomingMessages.single as GrpcMetadata;
    expect(message.metadata, responseHeaders);
  });

  test('Stream handles trailers properly', () async {
    final requestHeaders = {
      'parameter_1': 'value_1',
      'content-type': 'application/grpc+proto',
    };
    final responseTrailers = <String, String>{
      'trailer_1': 'value_1',
      'trailer_2': 'value_2',
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        requestHeaders, (error, _) => fail(error.toString()));

    final encodedTrailers = frame(responseTrailers.entries
        .map((e) => '${e.key}:${e.value}')
        .join('\r\n')
        .codeUnits);
    encodedTrailers[0] = 0x80; // Mark this frame as trailers.
    final encodedString = String.fromCharCodes(encodedTrailers);

    when(connection.latestRequest.responseHeaders).thenReturn(requestHeaders);
    when(connection.latestRequest.response).thenReturn(encodedString);

    // Set expectation for request readyState and generate events so that
    // incomingMessages stream completes.
    final readyStates = [HttpRequest.HEADERS_RECEIVED, HttpRequest.DONE];
    when(connection.latestRequest.readyState)
        .thenAnswer((_) => readyStates.removeAt(0));
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    connection.latestRequest.progressController.add(progressEvent);
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);

    // Should be two metadata messages: headers and trailers.
    final messages =
        await stream.incomingMessages.whereType<GrpcMetadata>().toList();
    expect(messages.length, 2);
    expect(messages.first.metadata, requestHeaders);
    expect(messages.last.metadata, responseTrailers);
  });

  test('Stream handles empty trailers properly', () async {
    final requestHeaders = {
      'content-type': 'application/grpc+proto',
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        {}, (error, _) => fail(error.toString()));

    final encoded = frame(''.codeUnits);
    encoded[0] = 0x80; // Mark this frame as trailers.
    final encodedString = String.fromCharCodes(encoded);

    when(connection.latestRequest.responseHeaders).thenReturn(requestHeaders);
    when(connection.latestRequest.response).thenReturn(encodedString);

    // Set expectation for request readyState and generate events so that
    // incomingMessages stream completes.
    final readyStates = [HttpRequest.HEADERS_RECEIVED, HttpRequest.DONE];
    when(connection.latestRequest.readyState)
        .thenAnswer((_) => readyStates.removeAt(0));
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    connection.latestRequest.progressController.add(progressEvent);
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);

    // Should be two metadata messages: headers and trailers.
    final messages =
        await stream.incomingMessages.whereType<GrpcMetadata>().toList();
    expect(messages.length, 2);
    expect(messages.first.metadata, requestHeaders);
    expect(messages.last.metadata, isEmpty);
  });

  test('Stream deserializes data properly', () async {
    final requestHeaders = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2',
      'content-type': 'application/grpc+proto',
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        requestHeaders, (error, _) => fail(error.toString()));
    final data = List<int>.filled(10, 224);
    when(connection.latestRequest.responseHeaders).thenReturn(requestHeaders);
    when(connection.latestRequest.response)
        .thenReturn(String.fromCharCodes(frame(data)));

    // Set expectation for request readyState and generate events, so that
    // incomingMessages stream completes.
    final readyStates = [HttpRequest.HEADERS_RECEIVED, HttpRequest.DONE];
    when(connection.latestRequest.readyState)
        .thenAnswer((_) => readyStates.removeAt(0));
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    connection.latestRequest.progressController.add(progressEvent);
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);

    // Expect a single data message.
    final message = await stream.incomingMessages.whereType<GrpcData>().single;
    expect(message.data, data);
  });

  test('GrpcError with error details in response', () async {
    final connection = MockXhrClientConnection(code: 400);
    final errors = <GrpcError>[];
    // The incoming messages stream never completes when there's an error, so
    // using completer.
    final errorReceived = Completer<void>();
    connection.makeRequest('test_path', Duration(seconds: 10), {}, (e, _) {
      errorReceived.complete();
      errors.add(e as GrpcError);
    });
    const errorDetails = 'error details';
    when(connection.latestRequest.responseHeaders)
        .thenReturn({'content-type': 'application/grpc+proto'});
    when(connection.latestRequest.readyState).thenReturn(HttpRequest.DONE);
    when(connection.latestRequest.responseText).thenReturn(errorDetails);
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    await errorReceived.future;
    expect(errors.single.rawResponse, errorDetails);
  });

  test('Stream receives multiple messages', () async {
    final metadata = <String, String>{
      'parameter_1': 'value_1',
      'parameter_2': 'value_2',
      'content-type': 'application/grpc+proto',
    };

    final connection = MockXhrClientConnection();

    final stream = connection.makeRequest('test_path', Duration(seconds: 10),
        metadata, (error, _) => fail(error.toString()));

    final data = <List<int>>[
      List<int>.filled(10, 224),
      List<int>.filled(5, 124)
    ];
    final encodedStrings =
        data.map((d) => String.fromCharCodes(frame(d))).toList();

    when(connection.latestRequest.responseHeaders).thenReturn(metadata);
    when(connection.latestRequest.readyState)
        .thenReturn(HttpRequest.HEADERS_RECEIVED);

    // At first invocation the response should be the the first message, after
    // that first + last messages.
    var first = true;
    when(connection.latestRequest.response).thenAnswer((_) {
      if (first) {
        first = false;
        return encodedStrings[0];
      }
      return encodedStrings[0] + encodedStrings[1];
    });

    final readyStates = [HttpRequest.HEADERS_RECEIVED, HttpRequest.DONE];
    when(connection.latestRequest.readyState)
        .thenAnswer((_) => readyStates.removeAt(0));

    final queue = StreamQueue(stream.incomingMessages);
    // Headers.
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    expect(((await queue.next) as GrpcMetadata).metadata, metadata);
    // Data 1.
    connection.latestRequest.progressController.add(progressEvent);
    expect(((await queue.next) as GrpcData).data, data[0]);
    // Data 2.
    connection.latestRequest.progressController.add(progressEvent);
    expect(((await queue.next) as GrpcData).data, data[1]);
    // Done.
    connection.latestRequest.readyStateChangeController
        .add(readyStateChangeEvent);
    expect(await queue.hasNext, isFalse);
  });
}
