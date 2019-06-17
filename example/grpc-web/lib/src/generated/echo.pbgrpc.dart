///
//  Generated code. Do not modify.
//  source: echo.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;
import 'echo.pb.dart';
export 'echo.pb.dart';

class EchoServiceClient extends $grpc.Client {
  static final _$echo = $grpc.ClientMethod<EchoRequest, EchoResponse>(
      '/grpc.gateway.testing.EchoService/Echo',
      (EchoRequest value) => value.writeToBuffer(),
      (List<int> value) => EchoResponse.fromBuffer(value));
  static final _$serverStreamingEcho = $grpc.ClientMethod<
          ServerStreamingEchoRequest, ServerStreamingEchoResponse>(
      '/grpc.gateway.testing.EchoService/ServerStreamingEcho',
      (ServerStreamingEchoRequest value) => value.writeToBuffer(),
      (List<int> value) => ServerStreamingEchoResponse.fromBuffer(value));

  EchoServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<EchoResponse> echo(EchoRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$echo, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServerStreamingEchoRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$serverStreamingEcho, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class EchoServiceBase extends $grpc.Service {
  String get $name => 'grpc.gateway.testing.EchoService';

  EchoServiceBase() {
    $addMethod($grpc.ServiceMethod<EchoRequest, EchoResponse>(
        'Echo',
        echo_Pre,
        false,
        false,
        (List<int> value) => EchoRequest.fromBuffer(value),
        (EchoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<ServerStreamingEchoRequest,
            ServerStreamingEchoResponse>(
        'ServerStreamingEcho',
        serverStreamingEcho_Pre,
        false,
        true,
        (List<int> value) => ServerStreamingEchoRequest.fromBuffer(value),
        (ServerStreamingEchoResponse value) => value.writeToBuffer()));
  }

  $async.Future<EchoResponse> echo_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return echo(call, await request);
  }

  $async.Stream<ServerStreamingEchoResponse> serverStreamingEcho_Pre(
      $grpc.ServiceCall call, $async.Future request) async* {
    yield* serverStreamingEcho(
        call, (await request) as ServerStreamingEchoRequest);
  }

  $async.Future<EchoResponse> echo($grpc.ServiceCall call, EchoRequest request);
  $async.Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      $grpc.ServiceCall call, ServerStreamingEchoRequest request);
}
