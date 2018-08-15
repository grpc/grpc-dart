///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'echo.pb.dart';
export 'echo.pb.dart';

class EchoServiceClient extends Client {
  static final _$echo = new ClientMethod<EchoRequest, EchoResponse>(
      '/grpc.gateway.testing.EchoService/Echo',
      (EchoRequest value) => value.writeToBuffer(),
      (List<int> value) => new EchoResponse.fromBuffer(value));
  static final _$echoAbort = new ClientMethod<EchoRequest, EchoResponse>(
      '/grpc.gateway.testing.EchoService/EchoAbort',
      (EchoRequest value) => value.writeToBuffer(),
      (List<int> value) => new EchoResponse.fromBuffer(value));
  static final _$noOp = new ClientMethod<Empty, Empty>(
      '/grpc.gateway.testing.EchoService/NoOp',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));
  static final _$serverStreamingEcho =
      new ClientMethod<ServerStreamingEchoRequest, ServerStreamingEchoResponse>(
          '/grpc.gateway.testing.EchoService/ServerStreamingEcho',
          (ServerStreamingEchoRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new ServerStreamingEchoResponse.fromBuffer(value));
  static final _$serverStreamingEchoAbort =
      new ClientMethod<ServerStreamingEchoRequest, ServerStreamingEchoResponse>(
          '/grpc.gateway.testing.EchoService/ServerStreamingEchoAbort',
          (ServerStreamingEchoRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new ServerStreamingEchoResponse.fromBuffer(value));
  static final _$clientStreamingEcho =
      new ClientMethod<ClientStreamingEchoRequest, ClientStreamingEchoResponse>(
          '/grpc.gateway.testing.EchoService/ClientStreamingEcho',
          (ClientStreamingEchoRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new ClientStreamingEchoResponse.fromBuffer(value));
  static final _$fullDuplexEcho = new ClientMethod<EchoRequest, EchoResponse>(
      '/grpc.gateway.testing.EchoService/FullDuplexEcho',
      (EchoRequest value) => value.writeToBuffer(),
      (List<int> value) => new EchoResponse.fromBuffer(value));
  static final _$halfDuplexEcho = new ClientMethod<EchoRequest, EchoResponse>(
      '/grpc.gateway.testing.EchoService/HalfDuplexEcho',
      (EchoRequest value) => value.writeToBuffer(),
      (List<int> value) => new EchoResponse.fromBuffer(value));

  EchoServiceClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<EchoResponse> echo(EchoRequest request,
      {CallOptions options}) {
    final call = $createCall(_$echo, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<EchoResponse> echoAbort(EchoRequest request,
      {CallOptions options}) {
    final call = $createCall(_$echoAbort, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<Empty> noOp(Empty request, {CallOptions options}) {
    final call = $createCall(_$noOp, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServerStreamingEchoRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$serverStreamingEcho, new Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
  }

  ResponseStream<ServerStreamingEchoResponse> serverStreamingEchoAbort(
      ServerStreamingEchoRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$serverStreamingEchoAbort, new Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
  }

  ResponseFuture<ClientStreamingEchoResponse> clientStreamingEcho(
      Stream<ClientStreamingEchoRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$clientStreamingEcho, request, options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<EchoResponse> fullDuplexEcho(Stream<EchoRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$fullDuplexEcho, request, options: options);
    return new ResponseStream(call);
  }

  ResponseStream<EchoResponse> halfDuplexEcho(Stream<EchoRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$halfDuplexEcho, request, options: options);
    return new ResponseStream(call);
  }
}

abstract class EchoServiceBase extends Service {
  String get $name => 'grpc.gateway.testing.EchoService';

  EchoServiceBase() {
    $addMethod(new ServiceMethod<EchoRequest, EchoResponse>(
        'Echo',
        echo_Pre,
        false,
        false,
        (List<int> value) => new EchoRequest.fromBuffer(value),
        (EchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<EchoRequest, EchoResponse>(
        'EchoAbort',
        echoAbort_Pre,
        false,
        false,
        (List<int> value) => new EchoRequest.fromBuffer(value),
        (EchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Empty, Empty>(
        'NoOp',
        noOp_Pre,
        false,
        false,
        (List<int> value) => new Empty.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ServerStreamingEchoRequest,
            ServerStreamingEchoResponse>(
        'ServerStreamingEcho',
        serverStreamingEcho_Pre,
        false,
        true,
        (List<int> value) => new ServerStreamingEchoRequest.fromBuffer(value),
        (ServerStreamingEchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ServerStreamingEchoRequest,
            ServerStreamingEchoResponse>(
        'ServerStreamingEchoAbort',
        serverStreamingEchoAbort_Pre,
        false,
        true,
        (List<int> value) => new ServerStreamingEchoRequest.fromBuffer(value),
        (ServerStreamingEchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ClientStreamingEchoRequest,
            ClientStreamingEchoResponse>(
        'ClientStreamingEcho',
        clientStreamingEcho,
        true,
        false,
        (List<int> value) => new ClientStreamingEchoRequest.fromBuffer(value),
        (ClientStreamingEchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<EchoRequest, EchoResponse>(
        'FullDuplexEcho',
        fullDuplexEcho,
        true,
        true,
        (List<int> value) => new EchoRequest.fromBuffer(value),
        (EchoResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<EchoRequest, EchoResponse>(
        'HalfDuplexEcho',
        halfDuplexEcho,
        true,
        true,
        (List<int> value) => new EchoRequest.fromBuffer(value),
        (EchoResponse value) => value.writeToBuffer()));
  }

  Future<EchoResponse> echo_Pre(ServiceCall call, Future request) async {
    return echo(call, await request);
  }

  Future<EchoResponse> echoAbort_Pre(ServiceCall call, Future request) async {
    return echoAbort(call, await request);
  }

  Future<Empty> noOp_Pre(ServiceCall call, Future request) async {
    return noOp(call, await request);
  }

  Stream<ServerStreamingEchoResponse> serverStreamingEcho_Pre(
      ServiceCall call, Future request) async* {
    yield* serverStreamingEcho(
        call, (await request) as ServerStreamingEchoRequest);
  }

  Stream<ServerStreamingEchoResponse> serverStreamingEchoAbort_Pre(
      ServiceCall call, Future request) async* {
    yield* serverStreamingEchoAbort(
        call, (await request) as ServerStreamingEchoRequest);
  }

  Future<EchoResponse> echo(ServiceCall call, EchoRequest request);
  Future<EchoResponse> echoAbort(ServiceCall call, EchoRequest request);
  Future<Empty> noOp(ServiceCall call, Empty request);
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request);
  Stream<ServerStreamingEchoResponse> serverStreamingEchoAbort(
      ServiceCall call, ServerStreamingEchoRequest request);
  Future<ClientStreamingEchoResponse> clientStreamingEcho(
      ServiceCall call, Stream<ClientStreamingEchoRequest> request);
  Stream<EchoResponse> fullDuplexEcho(
      ServiceCall call, Stream<EchoRequest> request);
  Stream<EchoResponse> halfDuplexEcho(
      ServiceCall call, Stream<EchoRequest> request);
}
