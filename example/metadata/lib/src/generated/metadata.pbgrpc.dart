///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library grpc_metadata_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'metadata.pb.dart';
export 'metadata.pb.dart';

class MetadataClient extends Client {
  static final _$echo = new ClientMethod<Record, Record>(
      '/grpc.Metadata/Echo',
      (Record value) => value.writeToBuffer(),
      (List<int> value) => new Record.fromBuffer(value));
  static final _$addOne = new ClientMethod<Number, Number>(
      '/grpc.Metadata/AddOne',
      (Number value) => value.writeToBuffer(),
      (List<int> value) => new Number.fromBuffer(value));
  static final _$fibonacci = new ClientMethod<Empty, Number>(
      '/grpc.Metadata/Fibonacci',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new Number.fromBuffer(value));

  MetadataClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Record> echo(Record request, {CallOptions options}) {
    final call = $createCall(_$echo, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseFuture(call);
  }

  ResponseStream<Number> addOne(Stream<Number> request, {CallOptions options}) {
    final call = $createCall(_$addOne, options: options);
    request.pipe(call.request);
    return new ResponseStream(call);
  }

  ResponseStream<Number> fibonacci(Empty request, {CallOptions options}) {
    final call = $createCall(_$fibonacci, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseStream(call);
  }
}

abstract class MetadataServiceBase extends Service {
  String get $name => 'grpc.Metadata';

  MetadataServiceBase() {
    $addMethod(new ServiceMethod(
        'Echo',
        echo_Pre,
        false,
        false,
        (List<int> value) => new Record.fromBuffer(value),
        (Record value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod(
        'AddOne',
        addOne,
        true,
        true,
        (List<int> value) => new Number.fromBuffer(value),
        (Number value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod(
        'Fibonacci',
        fibonacci_Pre,
        false,
        true,
        (List<int> value) => new Empty.fromBuffer(value),
        (Number value) => value.writeToBuffer()));
  }

  Future<Record> echo_Pre(ServiceCall call, Future<Record> request) async {
    return echo(call, await request);
  }

  Stream<Number> fibonacci_Pre(ServiceCall call, Future<Empty> request) async* {
    yield* fibonacci(call, await request);
  }

  Future<Record> echo(ServiceCall call, Record request);
  Stream<Number> addOne(ServiceCall call, Stream<Number> request);
  Stream<Number> fibonacci(ServiceCall call, Empty request);
}
