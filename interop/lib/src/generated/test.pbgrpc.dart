///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library grpc.testing_test_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'empty.pb.dart';
import 'messages.pb.dart';
export 'test.pb.dart';

class TestServiceClient extends Client {
  static final _$emptyCall = new ClientMethod<Empty, Empty>(
      '/grpc.testing.TestService/EmptyCall',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));
  static final _$unaryCall = new ClientMethod<SimpleRequest, SimpleResponse>(
      '/grpc.testing.TestService/UnaryCall',
      (SimpleRequest value) => value.writeToBuffer(),
      (List<int> value) => new SimpleResponse.fromBuffer(value));
  static final _$cacheableUnaryCall =
      new ClientMethod<SimpleRequest, SimpleResponse>(
          '/grpc.testing.TestService/CacheableUnaryCall',
          (SimpleRequest value) => value.writeToBuffer(),
          (List<int> value) => new SimpleResponse.fromBuffer(value));
  static final _$streamingOutputCall =
      new ClientMethod<StreamingOutputCallRequest, StreamingOutputCallResponse>(
          '/grpc.testing.TestService/StreamingOutputCall',
          (StreamingOutputCallRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new StreamingOutputCallResponse.fromBuffer(value));
  static final _$streamingInputCall =
      new ClientMethod<StreamingInputCallRequest, StreamingInputCallResponse>(
          '/grpc.testing.TestService/StreamingInputCall',
          (StreamingInputCallRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new StreamingInputCallResponse.fromBuffer(value));
  static final _$fullDuplexCall =
      new ClientMethod<StreamingOutputCallRequest, StreamingOutputCallResponse>(
          '/grpc.testing.TestService/FullDuplexCall',
          (StreamingOutputCallRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new StreamingOutputCallResponse.fromBuffer(value));
  static final _$halfDuplexCall =
      new ClientMethod<StreamingOutputCallRequest, StreamingOutputCallResponse>(
          '/grpc.testing.TestService/HalfDuplexCall',
          (StreamingOutputCallRequest value) => value.writeToBuffer(),
          (List<int> value) =>
              new StreamingOutputCallResponse.fromBuffer(value));
  static final _$unimplementedCall = new ClientMethod<Empty, Empty>(
      '/grpc.testing.TestService/UnimplementedCall',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));

  TestServiceClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Empty> emptyCall(Empty request, {CallOptions options}) {
    final call = $createCall(_$emptyCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<SimpleResponse> unaryCall(SimpleRequest request,
      {CallOptions options}) {
    final call = $createCall(_$unaryCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<SimpleResponse> cacheableUnaryCall(SimpleRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$cacheableUnaryCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<StreamingOutputCallResponse> streamingOutputCall(
      StreamingOutputCallRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$streamingOutputCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
  }

  ResponseFuture<StreamingInputCallResponse> streamingInputCall(
      Stream<StreamingInputCallRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$streamingInputCall, request, options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<StreamingOutputCallResponse> fullDuplexCall(
      Stream<StreamingOutputCallRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$fullDuplexCall, request, options: options);
    return new ResponseStream(call);
  }

  ResponseStream<StreamingOutputCallResponse> halfDuplexCall(
      Stream<StreamingOutputCallRequest> request,
      {CallOptions options}) {
    final call = $createCall(_$halfDuplexCall, request, options: options);
    return new ResponseStream(call);
  }

  ResponseFuture<Empty> unimplementedCall(Empty request,
      {CallOptions options}) {
    final call = $createCall(
        _$unimplementedCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class TestServiceBase extends Service {
  String get $name => 'grpc.testing.TestService';

  TestServiceBase() {
    $addMethod(new ServiceMethod<Empty, Empty>(
        'EmptyCall',
        emptyCall_Pre,
        false,
        false,
        (List<int> value) => new Empty.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<SimpleRequest, SimpleResponse>(
        'UnaryCall',
        unaryCall_Pre,
        false,
        false,
        (List<int> value) => new SimpleRequest.fromBuffer(value),
        (SimpleResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<SimpleRequest, SimpleResponse>(
        'CacheableUnaryCall',
        cacheableUnaryCall_Pre,
        false,
        false,
        (List<int> value) => new SimpleRequest.fromBuffer(value),
        (SimpleResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<StreamingOutputCallRequest,
            StreamingOutputCallResponse>(
        'StreamingOutputCall',
        streamingOutputCall_Pre,
        false,
        true,
        (List<int> value) => new StreamingOutputCallRequest.fromBuffer(value),
        (StreamingOutputCallResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<StreamingInputCallRequest,
            StreamingInputCallResponse>(
        'StreamingInputCall',
        streamingInputCall,
        true,
        false,
        (List<int> value) => new StreamingInputCallRequest.fromBuffer(value),
        (StreamingInputCallResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<StreamingOutputCallRequest,
            StreamingOutputCallResponse>(
        'FullDuplexCall',
        fullDuplexCall,
        true,
        true,
        (List<int> value) => new StreamingOutputCallRequest.fromBuffer(value),
        (StreamingOutputCallResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<StreamingOutputCallRequest,
            StreamingOutputCallResponse>(
        'HalfDuplexCall',
        halfDuplexCall,
        true,
        true,
        (List<int> value) => new StreamingOutputCallRequest.fromBuffer(value),
        (StreamingOutputCallResponse value) => value.writeToBuffer()));
  }

  Future<Empty> emptyCall_Pre(ServiceCall call, Future request) async {
    return emptyCall(call, await request);
  }

  Future<SimpleResponse> unaryCall_Pre(ServiceCall call, Future request) async {
    return unaryCall(call, await request);
  }

  Future<SimpleResponse> cacheableUnaryCall_Pre(
      ServiceCall call, Future request) async {
    return cacheableUnaryCall(call, await request);
  }

  Stream<StreamingOutputCallResponse> streamingOutputCall_Pre(
      ServiceCall call, Future request) async* {
    yield* streamingOutputCall(
        call, (await request) as StreamingOutputCallRequest);
  }

  Future<Empty> emptyCall(ServiceCall call, Empty request);
  Future<SimpleResponse> unaryCall(ServiceCall call, SimpleRequest request);
  Future<SimpleResponse> cacheableUnaryCall(
      ServiceCall call, SimpleRequest request);
  Stream<StreamingOutputCallResponse> streamingOutputCall(
      ServiceCall call, StreamingOutputCallRequest request);
  Future<StreamingInputCallResponse> streamingInputCall(
      ServiceCall call, Stream<StreamingInputCallRequest> request);
  Stream<StreamingOutputCallResponse> fullDuplexCall(
      ServiceCall call, Stream<StreamingOutputCallRequest> request);
  Stream<StreamingOutputCallResponse> halfDuplexCall(
      ServiceCall call, Stream<StreamingOutputCallRequest> request);
}

class UnimplementedServiceClient extends Client {
  static final _$unimplementedCall = new ClientMethod<Empty, Empty>(
      '/grpc.testing.UnimplementedService/UnimplementedCall',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));

  UnimplementedServiceClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Empty> unimplementedCall(Empty request,
      {CallOptions options}) {
    final call = $createCall(
        _$unimplementedCall, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class UnimplementedServiceBase extends Service {
  String get $name => 'grpc.testing.UnimplementedService';

  UnimplementedServiceBase() {
    $addMethod(new ServiceMethod<Empty, Empty>(
        'UnimplementedCall',
        unimplementedCall_Pre,
        false,
        false,
        (List<int> value) => new Empty.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
  }

  Future<Empty> unimplementedCall_Pre(ServiceCall call, Future request) async {
    return unimplementedCall(call, await request);
  }

  Future<Empty> unimplementedCall(ServiceCall call, Empty request);
}

class ReconnectServiceClient extends Client {
  static final _$start = new ClientMethod<ReconnectParams, Empty>(
      '/grpc.testing.ReconnectService/Start',
      (ReconnectParams value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));
  static final _$stop = new ClientMethod<Empty, ReconnectInfo>(
      '/grpc.testing.ReconnectService/Stop',
      (Empty value) => value.writeToBuffer(),
      (List<int> value) => new ReconnectInfo.fromBuffer(value));

  ReconnectServiceClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Empty> start(ReconnectParams request, {CallOptions options}) {
    final call = $createCall(_$start, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<ReconnectInfo> stop(Empty request, {CallOptions options}) {
    final call = $createCall(_$stop, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class ReconnectServiceBase extends Service {
  String get $name => 'grpc.testing.ReconnectService';

  ReconnectServiceBase() {
    $addMethod(new ServiceMethod<ReconnectParams, Empty>(
        'Start',
        start_Pre,
        false,
        false,
        (List<int> value) => new ReconnectParams.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Empty, ReconnectInfo>(
        'Stop',
        stop_Pre,
        false,
        false,
        (List<int> value) => new Empty.fromBuffer(value),
        (ReconnectInfo value) => value.writeToBuffer()));
  }

  Future<Empty> start_Pre(ServiceCall call, Future request) async {
    return start(call, await request);
  }

  Future<ReconnectInfo> stop_Pre(ServiceCall call, Future request) async {
    return stop(call, await request);
  }

  Future<Empty> start(ServiceCall call, ReconnectParams request);
  Future<ReconnectInfo> stop(ServiceCall call, Empty request);
}
