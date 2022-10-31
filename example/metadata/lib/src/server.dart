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

import 'package:grpc/grpc.dart' as grpc;

import 'generated/metadata.pbgrpc.dart';

class MetadataService extends MetadataServiceBase {
  int callCount = 0;

  @override
  Future<Record> echo(grpc.ServiceCall call, Record request) async {
    final peer = call.clientMetadata!['peer']!;
    final count = callCount++;
    print('Echo: Call #$count: Peer: $peer, request: ${request.value}');
    call.headers!['count'] = '$count';
    call.trailers!['hello'] = request.value;

    final delay = call.clientMetadata!['delay'];
    if (delay != null) {
      await Future.delayed(Duration(seconds: int.parse(delay)));
    }

    return Record()..value = peer;
  }

  @override
  Stream<Number> addOne(grpc.ServiceCall call, Stream<Number> request) async* {
    var lastNumber = -1;
    try {
      await for (var number in request) {
        lastNumber = number.value;
        yield Number()..value = number.value + 1;
      }
    } catch (error) {
      print('Caught: $error, last number = $lastNumber');
    } finally {
      if (call.isCanceled) {
        print('AddOne: Call canceled');
      }
    }
  }

  /// Streams a Fibonacci number every 500ms until the call is canceled.
  @override
  Stream<Number> fibonacci(grpc.ServiceCall call, Empty request) async* {
    var previous = 0;
    var current = 1;
    try {
      while (true) {
        await Future.delayed(Duration(milliseconds: 500));
        yield Number()..value = current;
        final next = current + previous;
        previous = current;
        current = next;
      }
    } finally {
      if (call.isCanceled) {
        print('Fibonacci: Canceled.');
      }
    }
  }
}

class Server {
  Future<void> main(List<String> args) async {
    final server = grpc.Server([MetadataService()]);
    await server.serve(port: 8080);
    print('Server listening on port ${server.port}...');
  }
}
