///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library grpc_metadata_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'metadata.pb.dart';
export 'metadata.pb.dart';

class MetadataClient extends Client {
  static final _$echo = ClientMethod<Record, Record>(
      '/grpc.Metadata/Echo',
      (Record value) => value.writeToBuffer(),
      (List<int> value) => Record.fromBuffer(value));
  static final _$addOne = ClientMethod<Number, Number>(
      '/grpc.Metadata/AddOne',
      (Number value) => value.writeToBuffer(),
      (List<int> value) => Number.fromBuffer(value));
  static final _$fibonacci = ClientMethod<Empty, Number>(
      '/grpc.Metadata/Fibonacci',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => Number.fromBuffer(value));

  MetadataClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Record> echo(Record request, {CallOptions options}) {
    final call =
        $createCall(_$echo, Stream.fromIterable([request]), options: options);
    return ResponseFuture(call);
  }

  ResponseStream<Number> addOne(Stream<Number> request, {CallOptions options}) {
    final call = $createCall(_$addOne, request, options: options);
    return ResponseStream(call);
  }

  ResponseStream<Number> fibonacci(Empty request, {CallOptions options}) {
    final call = $createCall(_$fibonacci, Stream.fromIterable([request]),
        options: options);
    return ResponseStream(call);
  }
}

abstract class MetadataServiceBase extends Service {
  String get $name => 'grpc.Metadata';

  MetadataServiceBase() {
    $addMethod(ServiceMethod<Record, Record>(
        'Echo',
        echo_Pre,
        false,
        false,
        (List<int> value) => Record.fromBuffer(value),
        (Record value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<Number, Number>(
        'AddOne',
        addOne,
        true,
        true,
        (List<int> value) => Number.fromBuffer(value),
        (Number value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<Empty, Number>(
        'Fibonacci',
        fibonacci_Pre,
        false,
        true,
        (List<int> value) => Empty.fromBuffer(value),
        (Number value) => value.writeToBuffer()));
  }

  Future<Record> echo_Pre(ServiceCall call, Future request) async {
    return echo(call, await request);
  }

  Stream<Number> fibonacci_Pre(ServiceCall call, Future request) async* {
    yield* fibonacci(call, (await request) as Empty);
  }

  Future<Record> echo(ServiceCall call, Record request);
  Stream<Number> addOne(ServiceCall call, Stream<Number> request);
  Stream<Number> fibonacci(ServiceCall call, Empty request);
}
