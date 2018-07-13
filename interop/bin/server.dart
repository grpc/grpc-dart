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
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:grpc/grpc.dart';

import 'package:interop/src/generated/empty.pb.dart';
import 'package:interop/src/generated/messages.pb.dart';
import 'package:interop/src/generated/test.pbgrpc.dart';

const _headerEchoKey = 'x-grpc-test-echo-initial';
const _trailerEchoKey = 'x-grpc-test-echo-trailing-bin';

class TestService extends TestServiceBase {
  @override
  void $onMetadata(ServiceCall context) {
    final headerEcho = context.clientMetadata[_headerEchoKey];
    if (headerEcho != null) {
      context.headers[_headerEchoKey] = headerEcho;
    }
    final trailerEcho = context.clientMetadata[_trailerEchoKey];
    if (trailerEcho != null) {
      context.trailers[_trailerEchoKey] = trailerEcho;
    }
  }

  @override
  Future<Empty> emptyCall(ServiceCall call, Empty request) async {
    return new Empty();
  }

  @override
  Future<SimpleResponse> unaryCall(
      ServiceCall call, SimpleRequest request) async {
    if (request.responseStatus.code != 0) {
      throw new GrpcError.custom(
          request.responseStatus.code, request.responseStatus.message);
    }
    final payload = new Payload()
      ..body = new List.filled(request.responseSize, 0);
    return new SimpleResponse()..payload = payload;
  }

  @override
  Future<SimpleResponse> cacheableUnaryCall(
      ServiceCall call, SimpleRequest request) async {
    final timestamp = new DateTime.now().microsecond * 1000;
    final responsePayload = new Payload()..body = ascii.encode('$timestamp');
    return new SimpleResponse()..payload = responsePayload;
  }

  @override
  Future<StreamingInputCallResponse> streamingInputCall(
      ServiceCall call, Stream<StreamingInputCallRequest> request) async {
    final aggregatedPayloadSize = await request.fold(
        0, (size, message) => size + message.payload.body.length);
    return new StreamingInputCallResponse()
      ..aggregatedPayloadSize = aggregatedPayloadSize;
  }

  Payload _payloadForRequest(ResponseParameters entry) =>
      new Payload()..body = new List.filled(entry.size, 0);

  @override
  Stream<StreamingOutputCallResponse> streamingOutputCall(
      ServiceCall call, StreamingOutputCallRequest request) async* {
    for (final entry in request.responseParameters) {
      if (entry.intervalUs > 0) {
        await new Future.delayed(new Duration(microseconds: entry.intervalUs));
      }
      yield new StreamingOutputCallResponse()
        ..payload = _payloadForRequest(entry);
    }
  }

  StreamingOutputCallResponse _responseForRequest(
      StreamingOutputCallRequest request) {
    if (request.responseStatus.code != 0) {
      throw new GrpcError.custom(
          request.responseStatus.code, request.responseStatus.message);
    }
    final response = new StreamingOutputCallResponse();
    if (request.responseParameters.isNotEmpty) {
      response.payload = _payloadForRequest(request.responseParameters[0]);
    }
    return response;
  }

  @override
  Stream<StreamingOutputCallResponse> fullDuplexCall(
      ServiceCall call, Stream<StreamingOutputCallRequest> request) async* {
    yield* request.map(_responseForRequest);
  }

  @override
  Stream<StreamingOutputCallResponse> halfDuplexCall(
      ServiceCall call, Stream<StreamingOutputCallRequest> request) async* {
    final bufferedResponses = await request.map(_responseForRequest).toList();
    yield* new Stream.fromIterable(bufferedResponses);
  }
}

Future<Null> main(List<String> args) async {
  final argumentParser = new ArgParser();
  argumentParser.addOption('port', defaultsTo: '8080');
  argumentParser.addOption('use_tls', defaultsTo: 'false');
  argumentParser.addOption('tls_cert_file', defaultsTo: 'server1.pem');
  argumentParser.addOption('tls_key_file', defaultsTo: 'server1.key');
  final arguments = argumentParser.parse(args);
  final port = int.parse(arguments['port']);

  final services = [new TestService()];

  final server = new Server(services);

  ServerTlsCredentials tlsCredentials;
  if (arguments['use_tls'] == 'true') {
    final certificate = new File(arguments['tls_cert_file']).readAsBytes();
    final privateKey = new File(arguments['tls_key_file']).readAsBytes();
    tlsCredentials = new ServerTlsCredentials(
        certificate: await certificate, privateKey: await privateKey);
  }
  await server.serve(port: port, security: tlsCredentials);
  print('Server listening on port ${server.port}...');
}
