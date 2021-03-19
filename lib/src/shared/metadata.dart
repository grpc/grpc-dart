// Copyright (c) 2021, the gRPC project authors. Please see the AUTHORS file
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

import 'package:grpc/src/generated/google/rpc/status.pb.dart';
import 'package:meta/meta.dart';
import 'package:protobuf/protobuf.dart';

import 'status.dart';

void validateHttpStatusAndContentType(
    int? httpStatus, Map<String, String> headers,
    {Object? rawResponse}) {
  if (httpStatus == null) {
    throw GrpcError.unknown(
        'HTTP response status is unknown', null, rawResponse);
  }

  if (httpStatus == 0) {
    throw GrpcError.unknown(
        'HTTP request completed without a status (potential CORS issue)',
        null,
        rawResponse);
  }

  final status = StatusCode.fromHttpStatus(httpStatus);
  if (status != StatusCode.ok) {
    final error = grpcErrorFromTrailers(headers);
    if (error == null || error.code == StatusCode.unknown) {
      throw GrpcError.custom(
          status,
          error?.message ??
              'HTTP connection completed with ${httpStatus} instead of 200',
          error?.details,
          rawResponse);
    }
    throw error;
  }

  final contentType = headers['content-type'];
  if (contentType == null) {
    throw GrpcError.unknown('missing content-type header', null, rawResponse);
  }

  // Check if content-type header indicates a supported format.
  if (!_validContentTypePrefix.any(contentType.startsWith)) {
    throw GrpcError.unknown(
        'unsupported content-type (${contentType})', null, rawResponse);
  }
}

GrpcError? grpcErrorFromTrailers(Map<String, String> trailers) {
  final status = trailers['grpc-status'];
  final statusCode = status != null ? int.parse(status) : StatusCode.unknown;

  if (statusCode != StatusCode.ok) {
    final messageMetadata = trailers['grpc-message'];
    final message =
        messageMetadata == null ? null : Uri.decodeFull(messageMetadata);

    final statusDetails = trailers[_statusDetailsHeader];
    return GrpcError.custom(
        statusCode,
        message,
        statusDetails == null
            ? const <GeneratedMessage>[]
            : decodeStatusDetails(statusDetails));
  }

  return null;
}

const _statusDetailsHeader = 'grpc-status-details-bin';

/// All accepted content-type header's prefix. We are being more permissive
/// then gRPC and gRPC-Web specifications because some of the services
/// return slightly different content-types.
const _validContentTypePrefix = [
  'application/grpc',
  'application/json+protobuf',
  'application/x-protobuf'
];

/// Given a string of base64url data, attempt to parse a Status object from it.
/// Once parsed, it will then map each detail item and attempt to parse it into
/// its respective GeneratedMessage type, returning the list of parsed detail items
/// as a `List<GeneratedMessage>`.
///
/// Prior to creating the Status object we pad the data to ensure its length is
/// an even multiple of 4, which is a requirement in Dart when decoding base64url data.
///
/// If any errors are thrown during decoding/parsing, it will return an empty list.
@visibleForTesting
List<GeneratedMessage> decodeStatusDetails(String data) {
  try {
    final parsedStatus = Status.fromBuffer(
        base64Url.decode(data.padRight((data.length + 3) & ~3, '=')));
    return parsedStatus.details.map(parseErrorDetailsFromAny).toList();
  } catch (e) {
    return <GeneratedMessage>[];
  }
}
