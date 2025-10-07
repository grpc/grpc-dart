// This is a generated file - do not edit.
//
// Generated from google/logging/v2/logging.proto.

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

import '../../protobuf/empty.pb.dart' as $1;
import 'logging.pb.dart' as $0;

export 'logging.pb.dart';

/// Service for ingesting and querying logs.
@$pb.GrpcServiceName('google.logging.v2.LoggingServiceV2')
class LoggingServiceV2Client extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = 'logging.googleapis.com';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/cloud-platform.read-only',
    'https://www.googleapis.com/auth/logging.admin',
    'https://www.googleapis.com/auth/logging.read',
    'https://www.googleapis.com/auth/logging.write',
  ];

  LoggingServiceV2Client(super.channel, {super.options, super.interceptors});

  /// Deletes all the log entries in a log for the _Default Log Bucket. The log
  /// reappears if it receives new entries. Log entries written shortly before
  /// the delete operation might not be deleted. Entries received after the
  /// delete operation with a timestamp before the operation will be deleted.
  $grpc.ResponseFuture<$1.Empty> deleteLog(
    $0.DeleteLogRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteLog, request, options: options);
  }

  /// Writes log entries to Logging. This API method is the
  /// only way to send log entries to Logging. This method
  /// is used, directly or indirectly, by the Logging agent
  /// (fluentd) and all logging libraries configured to use Logging.
  /// A single request may contain log entries for a maximum of 1000
  /// different resources (projects, organizations, billing accounts or
  /// folders)
  $grpc.ResponseFuture<$0.WriteLogEntriesResponse> writeLogEntries(
    $0.WriteLogEntriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$writeLogEntries, request, options: options);
  }

  /// Lists log entries.  Use this method to retrieve log entries that originated
  /// from a project/folder/organization/billing account.  For ways to export log
  /// entries, see [Exporting
  /// Logs](https://cloud.google.com/logging/docs/export).
  $grpc.ResponseFuture<$0.ListLogEntriesResponse> listLogEntries(
    $0.ListLogEntriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listLogEntries, request, options: options);
  }

  /// Lists the descriptors for monitored resource types used by Logging.
  $grpc.ResponseFuture<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
    $0.ListMonitoredResourceDescriptorsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMonitoredResourceDescriptors, request,
        options: options);
  }

  /// Lists the logs in projects, organizations, folders, or billing accounts.
  /// Only logs that have entries are listed.
  $grpc.ResponseFuture<$0.ListLogsResponse> listLogs(
    $0.ListLogsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listLogs, request, options: options);
  }

  /// Streaming read of log entries as they are ingested. Until the stream is
  /// terminated, it will continue reading logs.
  $grpc.ResponseStream<$0.TailLogEntriesResponse> tailLogEntries(
    $async.Stream<$0.TailLogEntriesRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$tailLogEntries, request, options: options);
  }

  // method descriptors

  static final _$deleteLog = $grpc.ClientMethod<$0.DeleteLogRequest, $1.Empty>(
      '/google.logging.v2.LoggingServiceV2/DeleteLog',
      ($0.DeleteLogRequest value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$writeLogEntries =
      $grpc.ClientMethod<$0.WriteLogEntriesRequest, $0.WriteLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/WriteLogEntries',
          ($0.WriteLogEntriesRequest value) => value.writeToBuffer(),
          $0.WriteLogEntriesResponse.fromBuffer);
  static final _$listLogEntries =
      $grpc.ClientMethod<$0.ListLogEntriesRequest, $0.ListLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogEntries',
          ($0.ListLogEntriesRequest value) => value.writeToBuffer(),
          $0.ListLogEntriesResponse.fromBuffer);
  static final _$listMonitoredResourceDescriptors = $grpc.ClientMethod<
          $0.ListMonitoredResourceDescriptorsRequest,
          $0.ListMonitoredResourceDescriptorsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListMonitoredResourceDescriptors',
      ($0.ListMonitoredResourceDescriptorsRequest value) =>
          value.writeToBuffer(),
      $0.ListMonitoredResourceDescriptorsResponse.fromBuffer);
  static final _$listLogs =
      $grpc.ClientMethod<$0.ListLogsRequest, $0.ListLogsResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogs',
          ($0.ListLogsRequest value) => value.writeToBuffer(),
          $0.ListLogsResponse.fromBuffer);
  static final _$tailLogEntries =
      $grpc.ClientMethod<$0.TailLogEntriesRequest, $0.TailLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/TailLogEntries',
          ($0.TailLogEntriesRequest value) => value.writeToBuffer(),
          $0.TailLogEntriesResponse.fromBuffer);
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

  $async.Future<$1.Empty> deleteLog_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteLogRequest> $request) async {
    return deleteLog($call, await $request);
  }

  $async.Future<$1.Empty> deleteLog(
      $grpc.ServiceCall call, $0.DeleteLogRequest request);

  $async.Future<$0.WriteLogEntriesResponse> writeLogEntries_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.WriteLogEntriesRequest> $request) async {
    return writeLogEntries($call, await $request);
  }

  $async.Future<$0.WriteLogEntriesResponse> writeLogEntries(
      $grpc.ServiceCall call, $0.WriteLogEntriesRequest request);

  $async.Future<$0.ListLogEntriesResponse> listLogEntries_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListLogEntriesRequest> $request) async {
    return listLogEntries($call, await $request);
  }

  $async.Future<$0.ListLogEntriesResponse> listLogEntries(
      $grpc.ServiceCall call, $0.ListLogEntriesRequest request);

  $async.Future<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.ListMonitoredResourceDescriptorsRequest>
              $request) async {
    return listMonitoredResourceDescriptors($call, await $request);
  }

  $async.Future<$0.ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors($grpc.ServiceCall call,
          $0.ListMonitoredResourceDescriptorsRequest request);

  $async.Future<$0.ListLogsResponse> listLogs_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListLogsRequest> $request) async {
    return listLogs($call, await $request);
  }

  $async.Future<$0.ListLogsResponse> listLogs(
      $grpc.ServiceCall call, $0.ListLogsRequest request);

  $async.Stream<$0.TailLogEntriesResponse> tailLogEntries(
      $grpc.ServiceCall call, $async.Stream<$0.TailLogEntriesRequest> request);
}
