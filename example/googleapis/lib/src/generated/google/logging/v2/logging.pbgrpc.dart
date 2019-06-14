///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core show int, String, List;

import 'package:grpc/service_api.dart' as $grpc;
import 'logging.pb.dart' as $0;
import '../../protobuf/empty.pb.dart' as $1;
export 'logging.pb.dart';

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

  LoggingServiceV2Client($grpc.ClientChannel channel,
      {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$1.Empty> deleteLog($0.DeleteLogRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$deleteLog, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.WriteLogEntriesResponse> writeLogEntries(
      $0.WriteLogEntriesRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$writeLogEntries, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.ListLogEntriesResponse> listLogEntries(
      $0.ListLogEntriesRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$listLogEntries, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          $0.ListMonitoredResourceDescriptorsRequest request,
          {$grpc.CallOptions options}) {
    final call = $createCall(_$listMonitoredResourceDescriptors,
        $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.ListLogsResponse> listLogs($0.ListLogsRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$listLogs, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

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
  }

  $async.Future<$1.Empty> deleteLog_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return deleteLog(call, await request);
  }

  $async.Future<$0.WriteLogEntriesResponse> writeLogEntries_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return writeLogEntries(call, await request);
  }

  $async.Future<$0.ListLogEntriesResponse> listLogEntries_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return listLogEntries(call, await request);
  }

  $async.Future<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(
          $grpc.ServiceCall call, $async.Future request) async {
    return listMonitoredResourceDescriptors(call, await request);
  }

  $async.Future<$0.ListLogsResponse> listLogs_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
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
}
