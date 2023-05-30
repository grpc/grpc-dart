///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/discuss_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'discuss_service.pb.dart' as $0;
export 'discuss_service.pb.dart';

class DiscussServiceClient extends $grpc.Client {
  static final _$generateMessage = $grpc.ClientMethod<$0.GenerateMessageRequest,
          $0.GenerateMessageResponse>(
      '/google.ai.generativelanguage.v1beta2.DiscussService/GenerateMessage',
      ($0.GenerateMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GenerateMessageResponse.fromBuffer(value));
  static final _$countMessageTokens = $grpc.ClientMethod<
          $0.CountMessageTokensRequest, $0.CountMessageTokensResponse>(
      '/google.ai.generativelanguage.v1beta2.DiscussService/CountMessageTokens',
      ($0.CountMessageTokensRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CountMessageTokensResponse.fromBuffer(value));

  DiscussServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GenerateMessageResponse> generateMessage(
      $0.GenerateMessageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.CountMessageTokensResponse> countMessageTokens(
      $0.CountMessageTokensRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$countMessageTokens, request, options: options);
  }
}

abstract class DiscussServiceBase extends $grpc.Service {
  $core.String get $name =>
      'google.ai.generativelanguage.v1beta2.DiscussService';

  DiscussServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GenerateMessageRequest,
            $0.GenerateMessageResponse>(
        'GenerateMessage',
        generateMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateMessageRequest.fromBuffer(value),
        ($0.GenerateMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CountMessageTokensRequest,
            $0.CountMessageTokensResponse>(
        'CountMessageTokens',
        countMessageTokens_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CountMessageTokensRequest.fromBuffer(value),
        ($0.CountMessageTokensResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GenerateMessageResponse> generateMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GenerateMessageRequest> request) async {
    return generateMessage(call, await request);
  }

  $async.Future<$0.CountMessageTokensResponse> countMessageTokens_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CountMessageTokensRequest> request) async {
    return countMessageTokens(call, await request);
  }

  $async.Future<$0.GenerateMessageResponse> generateMessage(
      $grpc.ServiceCall call, $0.GenerateMessageRequest request);
  $async.Future<$0.CountMessageTokensResponse> countMessageTokens(
      $grpc.ServiceCall call, $0.CountMessageTokensRequest request);
}
