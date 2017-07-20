// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:grpc/grpc.dart' as grpc;

import 'generated/metadata.pbgrpc.dart';

class MetadataService extends MetadataServiceBase {
  int callCount = 0;

  @override
  Future<Record> echo(grpc.ServiceCall call, Record request) async {
    final peer = call.clientMetadata['peer'];
    final count = callCount++;
    print('Echo: Call #$count: Peer: $peer, request: ${request.value}');
    call.headers['count'] = '${count}';
    call.trailers['hello'] = request.value;

    final delay = call.clientMetadata['delay'];
    if (delay != null) {
      await new Future.delayed(new Duration(seconds: int.parse(delay)));
    }

    return new Record()..value = peer;
  }

  @override
  Stream<Number> addOne(grpc.ServiceCall call, Stream<Number> request) async* {
    int lastNumber = -1;
    try {
      await for (var number in request) {
        lastNumber = number.value;
        yield new Number()..value = number.value + 1;
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
  Stream<Number> fibonacci(grpc.ServiceCall call, Empty request) async* {
    int previous = 0;
    int current = 1;
    try {
      while (true) {
        await new Future.delayed(new Duration(milliseconds: 500));
        yield new Number()..value = current;
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
  Future<Null> main(List<String> args) async {
    final server =
        new grpc.Server.insecure([new MetadataService()], port: 8080);
    await server.serve();
    print('Server listening...');
  }
}
