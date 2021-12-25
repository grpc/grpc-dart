///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'logging.pb.dart' as $2;
import '../../protobuf/empty.pb.dart' as $1;
export 'logging.pb.dart';

class LoggingServiceV2Client extends $grpc.Client {
  static final _$deleteLog = $grpc.ClientMethod<$2.DeleteLogRequest, $1.Empty>(
      '/google.logging.v2.LoggingServiceV2/DeleteLog',
      ($2.DeleteLogRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$writeLogEntries =
      $grpc.ClientMethod<$2.WriteLogEntriesRequest, $2.WriteLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/WriteLogEntries',
          ($2.WriteLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.WriteLogEntriesResponse.fromBuffer(value));
  static final _$listLogEntries =
      $grpc.ClientMethod<$2.ListLogEntriesRequest, $2.ListLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogEntries',
          ($2.ListLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ListLogEntriesResponse.fromBuffer(value));
  static final _$listMonitoredResourceDescriptors = $grpc.ClientMethod<
          $2.ListMonitoredResourceDescriptorsRequest,
          $2.ListMonitoredResourceDescriptorsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListMonitoredResourceDescriptors',
      ($2.ListMonitoredResourceDescriptorsRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.ListMonitoredResourceDescriptorsResponse.fromBuffer(value));
  static final _$listLogs =
      $grpc.ClientMethod<$2.ListLogsRequest, $2.ListLogsResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogs',
          ($2.ListLogsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ListLogsResponse.fromBuffer(value));
  static final _$tailLogEntries =
      $grpc.ClientMethod<$2.TailLogEntriesRequest, $2.TailLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/TailLogEntries',
          ($2.TailLogEntriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.TailLogEntriesResponse.fromBuffer(value));

  LoggingServiceV2Client($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> deleteLog($2.DeleteLogRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLog, request, options: options);
  }

  $grpc.ResponseFuture<$2.WriteLogEntriesResponse> writeLogEntries(
      $2.WriteLogEntriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeLogEntries, request, options: options);
  }

  $grpc.ResponseFuture<$2.ListLogEntriesResponse> listLogEntries(
      $2.ListLogEntriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLogEntries, request, options: options);
  }

  $grpc.ResponseFuture<$2.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          $2.ListMonitoredResourceDescriptorsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMonitoredResourceDescriptors, request,
        options: options);
  }

  $grpc.ResponseFuture<$2.ListLogsResponse> listLogs($2.ListLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLogs, request, options: options);
  }

  $grpc.ResponseStream<$2.TailLogEntriesResponse> tailLogEntries(
      $async.Stream<$2.TailLogEntriesRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$tailLogEntries, request, options: options);
  }
}

abstract class LoggingServiceV2ServiceBase extends $grpc.Service {
  $core.String get $name => 'google.logging.v2.LoggingServiceV2';

  LoggingServiceV2ServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.DeleteLogRequest, $1.Empty>(
        'DeleteLog',
        deleteLog_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteLogRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.WriteLogEntriesRequest,
            $2.WriteLogEntriesResponse>(
        'WriteLogEntries',
        writeLogEntries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.WriteLogEntriesRequest.fromBuffer(value),
        ($2.WriteLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListLogEntriesRequest,
            $2.ListLogEntriesResponse>(
        'ListLogEntries',
        listLogEntries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListLogEntriesRequest.fromBuffer(value),
        ($2.ListLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListMonitoredResourceDescriptorsRequest,
            $2.ListMonitoredResourceDescriptorsResponse>(
        'ListMonitoredResourceDescriptors',
        listMonitoredResourceDescriptors_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.ListMonitoredResourceDescriptorsRequest.fromBuffer(value),
        ($2.ListMonitoredResourceDescriptorsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ListLogsRequest, $2.ListLogsResponse>(
        'ListLogs',
        listLogs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ListLogsRequest.fromBuffer(value),
        ($2.ListLogsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.TailLogEntriesRequest,
            $2.TailLogEntriesResponse>(
        'TailLogEntries',
        tailLogEntries,
        true,
        true,
        ($core.List<$core.int> value) =>
            $2.TailLogEntriesRequest.fromBuffer(value),
        ($2.TailLogEntriesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> deleteLog_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteLogRequest> request) async {
    return deleteLog(call, await request);
  }

  $async.Future<$2.WriteLogEntriesResponse> writeLogEntries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.WriteLogEntriesRequest> request) async {
    return writeLogEntries(call, await request);
  }

  $async.Future<$2.ListLogEntriesResponse> listLogEntries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.ListLogEntriesRequest> request) async {
    return listLogEntries(call, await request);
  }

  $async.Future<$2.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(
          $grpc.ServiceCall call,
          $async.Future<$2.ListMonitoredResourceDescriptorsRequest>
              request) async {
    return listMonitoredResourceDescriptors(call, await request);
  }

  $async.Future<$2.ListLogsResponse> listLogs_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ListLogsRequest> request) async {
    return listLogs(call, await request);
  }

  $async.Future<$1.Empty> deleteLog(
      $grpc.ServiceCall call, $2.DeleteLogRequest request);
  $async.Future<$2.WriteLogEntriesResponse> writeLogEntries(
      $grpc.ServiceCall call, $2.WriteLogEntriesRequest request);
  $async.Future<$2.ListLogEntriesResponse> listLogEntries(
      $grpc.ServiceCall call, $2.ListLogEntriesRequest request);
  $async.Future<$2.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors($grpc.ServiceCall call,
          $2.ListMonitoredResourceDescriptorsRequest request);
  $async.Future<$2.ListLogsResponse> listLogs(
      $grpc.ServiceCall call, $2.ListLogsRequest request);
  $async.Stream<$2.TailLogEntriesResponse> tailLogEntries(
      $grpc.ServiceCall call, $async.Stream<$2.TailLogEntriesRequest> request);
}
