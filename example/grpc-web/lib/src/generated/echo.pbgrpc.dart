///
//  Generated code. Do not modify.
//  source: echo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'echo.pb.dart' as $0;
export 'echo.pb.dart';

class EchoServiceClient extends $grpc.Client {
  static final _$echo = $grpc.ClientMethod<$0.EchoRequest, $0.EchoResponse>(
      '/grpc.gateway.testing.EchoService/Echo',
      ($0.EchoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.EchoResponse.fromBuffer(value));
  static final _$serverStreamingEcho = $grpc.ClientMethod<
          $0.ServerStreamingEchoRequest, $0.ServerStreamingEchoResponse>(
      '/grpc.gateway.testing.EchoService/ServerStreamingEcho',
      ($0.ServerStreamingEchoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ServerStreamingEchoResponse.fromBuffer(value));

  EchoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.EchoResponse> echo($0.EchoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$echo, request, options: options);
  }

  $grpc.ResponseStream<$0.ServerStreamingEchoResponse> serverStreamingEcho(
      $0.ServerStreamingEchoRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$serverStreamingEcho, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class EchoServiceBase extends $grpc.Service {
  $core.String get $name => 'grpc.gateway.testing.EchoService';

  EchoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.EchoRequest, $0.EchoResponse>(
        'Echo',
        echo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EchoRequest.fromBuffer(value),
        ($0.EchoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ServerStreamingEchoRequest,
            $0.ServerStreamingEchoResponse>(
        'ServerStreamingEcho',
        serverStreamingEcho_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ServerStreamingEchoRequest.fromBuffer(value),
        ($0.ServerStreamingEchoResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.EchoResponse> echo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.EchoRequest> request) async {
    return echo(call, await request);
  }

  $async.Stream<$0.ServerStreamingEchoResponse> serverStreamingEcho_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ServerStreamingEchoRequest> request) async* {
    yield* serverStreamingEcho(call, await request);
  }

  $async.Future<$0.EchoResponse> echo(
      $grpc.ServiceCall call, $0.EchoRequest request);
  $async.Stream<$0.ServerStreamingEchoResponse> serverStreamingEcho(
      $grpc.ServiceCall call, $0.ServerStreamingEchoRequest request);
}
