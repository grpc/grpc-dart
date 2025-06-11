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

import 'dart:convert';

import 'package:grpc/src/shared/message.dart';
import 'package:grpc/src/shared/streams.dart';
import 'package:http2/transport.dart';
import 'package:test/test.dart';

typedef MessageHandler = void Function(StreamMessage message);

List<int> mockEncode(int value) => List.filled(value, 0);

int mockDecode(List<int> value) => value.length;

Map<String, String> headersToMap(List<Header> headers) => {
  for (var h in headers) ascii.decode(h.name): ascii.decode(h.value),
};

void validateRequestHeaders(
  Map<String, String> headers, {
  String? path,
  String authority = 'test',
  String? timeout,
  Map<String, String>? customHeaders,
}) {
  expect(headers[':method'], 'POST');
  expect(headers[':scheme'], 'https');
  if (path != null) {
    expect(headers[':path'], path);
  }
  expect(headers[':authority'], authority);
  expect(headers['grpc-timeout'], timeout);
  expect(headers['content-type'], 'application/grpc');
  expect(headers['te'], 'trailers');
  expect(headers['user-agent'], startsWith('dart-grpc/'));

  customHeaders?.forEach((key, value) {
    expect(headers[key], value);
  });
}

void validateResponseHeaders(
  Map<String, String> headers, {
  int status = 200,
  bool allowTrailers = false,
  Map<String, String>? customHeaders,
}) {
  expect(headers[':status'], '200');
  expect(headers['content-type'], startsWith('application/grpc'));
  if (!allowTrailers) {
    expect(headers.containsKey('grpc-status'), isFalse);
    expect(headers.containsKey('grpc-message'), isFalse);
  }
  customHeaders?.forEach((key, value) {
    expect(headers[key], value);
  });
}

void validateResponseTrailers(
  Map<String, String> trailers, {
  int status = 0,
  String? message,
  Map<String, String>? customTrailers,
}) {
  expect(trailers['grpc-status'], '$status');
  if (message != null) {
    expect(trailers['grpc-message'], message);
  }
  customTrailers?.forEach((key, value) {
    expect(trailers[key], value);
  });
}

GrpcMetadata validateMetadataMessage(
  StreamMessage message, {
  bool endStream = false,
}) {
  expect(message, TypeMatcher<HeadersStreamMessage>());
  expect(message.endStream, endStream);

  final decoded = GrpcHttpDecoder().convert(message);
  expect(decoded, TypeMatcher<GrpcMetadata>());
  return decoded as GrpcMetadata;
}

GrpcData validateDataMessage(StreamMessage message, {bool endStream = false}) {
  expect(message, TypeMatcher<DataStreamMessage>());
  expect(message.endStream, endStream);

  final decoded = GrpcHttpDecoder().convert(message);
  expect(decoded, TypeMatcher<GrpcData>());
  return decoded as GrpcData;
}

void Function(StreamMessage message) headerValidator() {
  return (StreamMessage message) {
    final header = validateMetadataMessage(message, endStream: false);
    validateResponseHeaders(header.metadata, allowTrailers: true);
  };
}

void Function(StreamMessage message) errorTrailerValidator(
  int status,
  String statusMessage, {
  bool validateHeader = false,
}) {
  return (StreamMessage message) {
    final trailer = validateMetadataMessage(message, endStream: true);
    if (validateHeader) {
      validateResponseHeaders(trailer.metadata, allowTrailers: true);
    }
    validateResponseTrailers(
      trailer.metadata,
      status: status,
      message: statusMessage,
    );
  };
}
