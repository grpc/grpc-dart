// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'generated/metadata.pbgrpc.dart';

class Client {
  ClientChannel channel;
  MetadataClient stub;

  Future<Null> main(List<String> args) async {
    channel = new ClientChannel('127.0.0.1',
        port: 8080, options: new ChannelOptions.insecure());
    stub = new MetadataClient(channel);
    // Run all of the demos in order.
    await runEcho();
    await runEchoDelayCancel();
    await runAddOneCancel();
    await runFibonacciCancel();
    await runFibonacciTimeout();
    await channel.close();
  }

  // Run the echo demo. ...
  Future<Null> runEcho() async {
    final request = new Record()..value = 'Kaj';
    final call = stub.echo(request,
        options: new CallOptions(metadata: {'peer': 'Verner'}));
    call.headers.then((headers) {
      print('Received header metadata: $headers');
    });
    call.trailers.then((trailers) {
      print('Received trailer metadata: $trailers');
    });
    final response = await call;
    print('Echo response: ${response.value}');
  }

  // Run the echo with delay cancel demo. ...
  Future<Null> runEchoDelayCancel() async {
    final stubWithCustomOptions = new MetadataClient(channel,
        options: new CallOptions(metadata: {'peer': 'Verner'}));
    final request = new Record()..value = 'Kaj';
    final call = stubWithCustomOptions.echo(request,
        options: new CallOptions(metadata: {'delay': '1'}));
    call.headers.then((headers) {
      print('Received header metadata: $headers');
    });
    call.trailers.then((trailers) {
      print('Received trailer metadata: $trailers');
    });
    await new Future.delayed(new Duration(milliseconds: 10));
    call.cancel();
    try {
      final response = await call;
      print('Unexpected echo response: ${response.value}');
    } catch (error) {
      print('Expected error: $error');
    }
  }

  // Run the addOne cancel demo.
  Future<Null> runAddOneCancel() async {
    final numbers = new StreamController<int>();
    final call =
        stub.addOne(numbers.stream.map((value) => new Number()..value = value));
    final receivedThree = new Completer<bool>();
    final sub = call.listen((number) {
      print('AddOneCancel: Received ${number.value}');
      if (number.value == 3) {
        receivedThree.complete(true);
      }
    });
    numbers.add(1);
    numbers.add(2);
    numbers.add(3);
    numbers.add(4);
    await receivedThree.future;
    await call.cancel();
    await Future.wait([sub.cancel(), numbers.close()]);
  }

  /// Call an RPC that returns a stream of Fibonacci numbers. Cancel the call
  /// after receiving more than 5 responses.
  Future<Null> runFibonacciCancel() async {
    final call = stub.fibonacci(new Empty());
    int count = 0;
    await for (var number in call) {
      count++;
      print('Received ${number.value} (count=$count)');
      if (count > 5) {
        await call.cancel();
      }
    }
    print('Final count: $count');
  }

  // Run the timeout demo. ...
  Future<Null> runFibonacciTimeout() async {
    // TODO(jakobr): Implement timeouts.
  }
}
