///
//  Generated code. Do not modify.
//  source: metadata.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'metadata.pb.dart' as $0;
export 'metadata.pb.dart';

class MetadataClient extends $grpc.Client {
  static final _$echo = $grpc.ClientMethod<$0.Record, $0.Record>(
      '/grpc.Metadata/Echo',
      ($0.Record value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Record.fromBuffer(value));
  static final _$addOne = $grpc.ClientMethod<$0.Number, $0.Number>(
      '/grpc.Metadata/AddOne',
      ($0.Number value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Number.fromBuffer(value));
  static final _$fibonacci = $grpc.ClientMethod<$0.Empty, $0.Number>(
      '/grpc.Metadata/Fibonacci',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Number.fromBuffer(value));

  MetadataClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Record> echo($0.Record request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$echo, request, options: options);
  }

  $grpc.ResponseStream<$0.Number> addOne($async.Stream<$0.Number> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$addOne, request, options: options);
  }

  $grpc.ResponseStream<$0.Number> fibonacci($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$fibonacci, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class MetadataServiceBase extends $grpc.Service {
  $core.String get $name => 'grpc.Metadata';

  MetadataServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Record, $0.Record>(
        'Echo',
        echo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Record.fromBuffer(value),
        ($0.Record value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Number, $0.Number>(
        'AddOne',
        addOne,
        true,
        true,
        ($core.List<$core.int> value) => $0.Number.fromBuffer(value),
        ($0.Number value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Number>(
        'Fibonacci',
        fibonacci_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Number value) => value.writeToBuffer()));
  }

  $async.Future<$0.Record> echo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Record> request) async {
    return echo(call, await request);
  }

  $async.Stream<$0.Number> fibonacci_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* fibonacci(call, await request);
  }

  $async.Future<$0.Record> echo($grpc.ServiceCall call, $0.Record request);
  $async.Stream<$0.Number> addOne(
      $grpc.ServiceCall call, $async.Stream<$0.Number> request);
  $async.Stream<$0.Number> fibonacci($grpc.ServiceCall call, $0.Empty request);
}
