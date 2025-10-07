// This is a generated file - do not edit.
//
// Generated from echo.proto.

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

import 'echo.pb.dart' as $0;

export 'echo.pb.dart';

@$pb.GrpcServiceName('grpc.gateway.testing.EchoService')
class EchoServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  EchoServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.EchoResponse> echo(
    $0.EchoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$echo, request, options: options);
  }

  $grpc.ResponseStream<$0.ServerStreamingEchoResponse> serverStreamingEcho(
    $0.ServerStreamingEchoRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$serverStreamingEcho, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$echo = $grpc.ClientMethod<$0.EchoRequest, $0.EchoResponse>(
      '/grpc.gateway.testing.EchoService/Echo',
      ($0.EchoRequest value) => value.writeToBuffer(),
      $0.EchoResponse.fromBuffer);
  static final _$serverStreamingEcho = $grpc.ClientMethod<
          $0.ServerStreamingEchoRequest, $0.ServerStreamingEchoResponse>(
      '/grpc.gateway.testing.EchoService/ServerStreamingEcho',
      ($0.ServerStreamingEchoRequest value) => value.writeToBuffer(),
      $0.ServerStreamingEchoResponse.fromBuffer);
}

@$pb.GrpcServiceName('grpc.gateway.testing.EchoService')
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
      $grpc.ServiceCall $call, $async.Future<$0.EchoRequest> $request) async {
    return echo($call, await $request);
  }

  $async.Future<$0.EchoResponse> echo(
      $grpc.ServiceCall call, $0.EchoRequest request);

  $async.Stream<$0.ServerStreamingEchoResponse> serverStreamingEcho_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ServerStreamingEchoRequest> $request) async* {
    yield* serverStreamingEcho($call, await $request);
  }

  $async.Stream<$0.ServerStreamingEchoResponse> serverStreamingEcho(
      $grpc.ServiceCall call, $0.ServerStreamingEchoRequest request);
}
