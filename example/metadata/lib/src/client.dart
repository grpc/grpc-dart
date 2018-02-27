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

import 'package:grpc/grpc.dart';

import 'generated/metadata.pbgrpc.dart';

class Client {
  ClientChannel channel;
  MetadataClient stub;

  Future<Null> main(List<String> args) async {
    channel = new ClientChannel('127.0.0.1',
        port: 8080,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    stub = new MetadataClient(channel);
    // Run all of the demos in order.
    await runEcho();
    await runEchoDelayCancel();
    await runAddOneCancel();
    await runFibonacciCancel();
    await runFibonacciTimeout();
    await channel.shutdown();
  }

  /// Run the echo demo.
  ///
  /// Send custom metadata with a RPC, and print out the received response and
  /// metadata.
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

  /// Run the echo with delay cancel demo.
  ///
  /// Same as the echo demo, but demonstrating per-client custom metadata, as
  /// well as a per-call metadata. The server will delay the response for the
  /// requested duration, during which the client will cancel the RPC.
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

  /// Run the addOne cancel demo.
  ///
  /// Makes a bi-directional RPC, sends 4 requests, and cancels the RPC after
  /// receiving 3 responses.
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
    }, onError: (e) => print('Caught: $e'));
    numbers.add(1);
    numbers.add(2);
    numbers.add(3);
    numbers.add(4);
    await receivedThree.future;
    await call.cancel();
    await Future.wait([sub.cancel(), numbers.close()]);
  }

  /// Run the Fibonacci demo.
  ///
  /// Call an RPC that returns a stream of Fibonacci numbers. Cancel the call
  /// after receiving more than 5 responses.
  Future<Null> runFibonacciCancel() async {
    final call = stub.fibonacci(new Empty());
    int count = 0;
    try {
      await for (var number in call) {
        count++;
        print('Received ${number.value} (count=$count)');
        if (count > 5) {
          await call.cancel();
        }
      }
    } on GrpcError catch (e) {
      print('Caught: $e');
    }
    print('Final count: $count');
  }

  /// Run the timeout demo.
  ///
  /// Call an RPC that returns a stream of Fibonacci numbers, and specify an RPC
  /// timeout of 2 seconds.
  Future<Null> runFibonacciTimeout() async {
    final call = stub.fibonacci(new Empty(),
        options: new CallOptions(timeout: new Duration(seconds: 2)));
    int count = 0;
    try {
      await for (var number in call) {
        count++;
        print('Received ${number.value} (count=$count)');
      }
    } on GrpcError catch (e) {
      print('Caught: $e');
    }
    print('Final count: $count');
  }
}
