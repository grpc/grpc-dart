// This is a generated file - do not edit.
//
// Generated from metadata.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'metadata.pb.dart' as $0;

export 'metadata.pb.dart';

/// Interface exported by the server.
@$pb.GrpcServiceName('grpc.Metadata')
class MetadataClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MetadataClient(super.channel, {super.options, super.interceptors});

  /// Echo metadata.
  ///
  /// Echoes the given input as trailer metadata. Sets a call counter as header
  /// metadata, and returns the value of the 'hello' key in the client metadata
  /// as the result.
  $grpc.ResponseFuture<$0.Record> echo(
    $0.Record request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$echo, request, options: options);
  }

  /// Adds 1 to the numbers in the request stream.
  ///
  /// Uses bidirectional streaming.
  $grpc.ResponseStream<$0.Number> addOne(
    $async.Stream<$0.Number> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$addOne, request, options: options);
  }

  /// Fibonacci.
  ///
  /// Streams Fibonacci numbers until the call is canceled or times out.
  $grpc.ResponseStream<$0.Number> fibonacci(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$fibonacci, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$echo = $grpc.ClientMethod<$0.Record, $0.Record>(
      '/grpc.Metadata/Echo',
      ($0.Record value) => value.writeToBuffer(),
      $0.Record.fromBuffer);
  static final _$addOne = $grpc.ClientMethod<$0.Number, $0.Number>(
      '/grpc.Metadata/AddOne',
      ($0.Number value) => value.writeToBuffer(),
      $0.Number.fromBuffer);
  static final _$fibonacci = $grpc.ClientMethod<$0.Empty, $0.Number>(
      '/grpc.Metadata/Fibonacci',
      ($0.Empty value) => value.writeToBuffer(),
      $0.Number.fromBuffer);
}

@$pb.GrpcServiceName('grpc.Metadata')
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
      $grpc.ServiceCall $call, $async.Future<$0.Record> $request) async {
    return echo($call, await $request);
  }

  $async.Future<$0.Record> echo($grpc.ServiceCall call, $0.Record request);

  $async.Stream<$0.Number> addOne(
      $grpc.ServiceCall call, $async.Stream<$0.Number> request);

  $async.Stream<$0.Number> fibonacci_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async* {
    yield* fibonacci($call, await $request);
  }

  $async.Stream<$0.Number> fibonacci($grpc.ServiceCall call, $0.Empty request);
}
