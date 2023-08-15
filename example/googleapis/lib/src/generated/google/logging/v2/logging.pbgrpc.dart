//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/empty.pb.dart' as $1;
import 'logging.pb.dart' as $0;

export 'logging.pb.dart';

@$pb.GrpcServiceName('google.logging.v2.LoggingServiceV2')
class LoggingServiceV2Client extends $grpc.Client {
  static final _$deleteLog = $grpc.ClientMethod<$0.DeleteLogRequest, $1.Empty>(
      '/google.logging.v2.LoggingServiceV2/DeleteLog',
      ($0.DeleteLogRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$writeLogEntries =
      $grpc.ClientMethod<$0.WriteLogEntriesRequest, $0.WriteLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/WriteLogEntries',
          ($0.WriteLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.WriteLogEntriesResponse.fromBuffer(value));
  static final _$listLogEntries =
      $grpc.ClientMethod<$0.ListLogEntriesRequest, $0.ListLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogEntries',
          ($0.ListLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListLogEntriesResponse.fromBuffer(value));
  static final _$listMonitoredResourceDescriptors = $grpc.ClientMethod<
          $0.ListMonitoredResourceDescriptorsRequest,
          $0.ListMonitoredResourceDescriptorsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListMonitoredResourceDescriptors',
      ($0.ListMonitoredResourceDescriptorsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListMonitoredResourceDescriptorsResponse.fromBuffer(value));
  static final _$listLogs =
      $grpc.ClientMethod<$0.ListLogsRequest, $0.ListLogsResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogs',
          ($0.ListLogsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListLogsResponse.fromBuffer(value));
  static final _$tailLogEntries =
      $grpc.ClientMethod<$0.TailLogEntriesRequest, $0.TailLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/TailLogEntries',
          ($0.TailLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TailLogEntriesResponse.fromBuffer(value));

  LoggingServiceV2Client($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> deleteLog($0.DeleteLogRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLog, request, options: options);
  }

  $grpc.ResponseFuture<$0.WriteLogEntriesResponse> writeLogEntries(
      $0.WriteLogEntriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeLogEntries, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListLogEntriesResponse> listLogEntries(
      $0.ListLogEntriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLogEntries, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          $0.ListMonitoredResourceDescriptorsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMonitoredResourceDescriptors, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ListLogsResponse> listLogs($0.ListLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLogs, request, options: options);
  }

  $grpc.ResponseStream<$0.TailLogEntriesResponse> tailLogEntries(
      $async.Stream<$0.TailLogEntriesRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$tailLogEntries, request, options: options);
  }
}

@$pb.GrpcServiceName('google.logging.v2.LoggingServiceV2')
abstract class LoggingServiceV2ServiceBase extends $grpc.Service {
  $core.String get $name => 'google.logging.v2.LoggingServiceV2';

  LoggingServiceV2ServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DeleteLogRequest, $1.Empty>(
        'DeleteLog',
        deleteLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteLogRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WriteLogEntriesRequest,
            $0.WriteLogEntriesResponse>(
        'WriteLogEntries',
        writeLogEntries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WriteLogEntriesRequest.fromBuffer(value),
        ($0.WriteLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListLogEntriesRequest,
            $0.ListLogEntriesResponse>(
        'ListLogEntries',
        listLogEntries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListLogEntriesRequest.fromBuffer(value),
        ($0.ListLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListMonitoredResourceDescriptorsRequest,
            $0.ListMonitoredResourceDescriptorsResponse>(
        'ListMonitoredResourceDescriptors',
        listMonitoredResourceDescriptors_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListMonitoredResourceDescriptorsRequest.fromBuffer(value),
        ($0.ListMonitoredResourceDescriptorsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListLogsRequest, $0.ListLogsResponse>(
        'ListLogs',
        listLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListLogsRequest.fromBuffer(value),
        ($0.ListLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TailLogEntriesRequest,
            $0.TailLogEntriesResponse>(
        'TailLogEntries',
        tailLogEntries,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.TailLogEntriesRequest.fromBuffer(value),
        ($0.TailLogEntriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> deleteLog_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeleteLogRequest> request) async {
    return deleteLog(call, await request);
  }

  $async.Future<$0.WriteLogEntriesResponse> writeLogEntries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.WriteLogEntriesRequest> request) async {
    return writeLogEntries(call, await request);
  }

  $async.Future<$0.ListLogEntriesResponse> listLogEntries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListLogEntriesRequest> request) async {
    return listLogEntries(call, await request);
  }

  $async.Future<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(
          $grpc.ServiceCall call,
          $async.Future<$0.ListMonitoredResourceDescriptorsRequest>
              request) async {
    return listMonitoredResourceDescriptors(call, await request);
  }

  $async.Future<$0.ListLogsResponse> listLogs_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ListLogsRequest> request) async {
    return listLogs(call, await request);
  }

  $async.Future<$1.Empty> deleteLog(
      $grpc.ServiceCall call, $0.DeleteLogRequest request);
  $async.Future<$0.WriteLogEntriesResponse> writeLogEntries(
      $grpc.ServiceCall call, $0.WriteLogEntriesRequest request);
  $async.Future<$0.ListLogEntriesResponse> listLogEntries(
      $grpc.ServiceCall call, $0.ListLogEntriesRequest request);
  $async.Future<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors($grpc.ServiceCall call,
          $0.ListMonitoredResourceDescriptorsRequest request);
  $async.Future<$0.ListLogsResponse> listLogs(
      $grpc.ServiceCall call, $0.ListLogsRequest request);
  $async.Stream<$0.TailLogEntriesResponse> tailLogEntries(
      $grpc.ServiceCall call, $async.Stream<$0.TailLogEntriesRequest> request);
}
