///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library helloworld_helloworld_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'helloworld.pb.dart';
export 'helloworld.pb.dart';

class GreeterClient extends Client {
  static final _$sayHello = ClientMethod<HelloRequest, HelloReply>(
      '/helloworld.Greeter/SayHello',
      (HelloRequest value) => value.writeToBuffer(),
      (List<int> value) => HelloReply.fromBuffer(value));

  GreeterClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  Future<HelloReply> sayHello(HelloRequest request, {CallOptions options}) {
    final call = $createCall(_$sayHello, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }
}

abstract class GreeterServiceBase extends Service {
  String get $name => 'helloworld.Greeter';

  GreeterServiceBase() {
    $addMethod(ServiceMethod<HelloRequest, HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        (List<int> value) => HelloRequest.fromBuffer(value),
        (HelloReply value) => value.writeToBuffer()));
  }

  Future<HelloReply> sayHello_Pre(ServiceCall call, Future request) async {
    return sayHello(call, await request);
  }

  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request);
}
