///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.v2_logging_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'logging.pb.dart';
import '../../protobuf/empty.pb.dart' as $google$protobuf;
export 'logging.pb.dart';

class LoggingServiceV2Client extends Client {
  static final _$deleteLog =
      ClientMethod<DeleteLogRequest, $google$protobuf.Empty>(
          '/google.logging.v2.LoggingServiceV2/DeleteLog',
          (DeleteLogRequest value) => value.writeToBuffer(),
          (List<int> value) => $google$protobuf.Empty.fromBuffer(value));
  static final _$writeLogEntries =
      ClientMethod<WriteLogEntriesRequest, WriteLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/WriteLogEntries',
          (WriteLogEntriesRequest value) => value.writeToBuffer(),
          (List<int> value) => WriteLogEntriesResponse.fromBuffer(value));
  static final _$listLogEntries =
      ClientMethod<ListLogEntriesRequest, ListLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogEntries',
          (ListLogEntriesRequest value) => value.writeToBuffer(),
          (List<int> value) => ListLogEntriesResponse.fromBuffer(value));
  static final _$listMonitoredResourceDescriptors = ClientMethod<
          ListMonitoredResourceDescriptorsRequest,
          ListMonitoredResourceDescriptorsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListMonitoredResourceDescriptors',
      (ListMonitoredResourceDescriptorsRequest value) => value.writeToBuffer(),
      (List<int> value) =>
          ListMonitoredResourceDescriptorsResponse.fromBuffer(value));
  static final _$listLogs = ClientMethod<ListLogsRequest, ListLogsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListLogs',
      (ListLogsRequest value) => value.writeToBuffer(),
      (List<int> value) => ListLogsResponse.fromBuffer(value));

  LoggingServiceV2Client(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<$google$protobuf.Empty> deleteLog(DeleteLogRequest request,
      {CallOptions options}) {
    final call = $createCall(_$deleteLog, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }

  ResponseFuture<WriteLogEntriesResponse> writeLogEntries(
      WriteLogEntriesRequest request,
      {CallOptions options}) {
    final call = $createCall(_$writeLogEntries, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }

  ResponseFuture<ListLogEntriesResponse> listLogEntries(
      ListLogEntriesRequest request,
      {CallOptions options}) {
    final call = $createCall(_$listLogEntries, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }

  ResponseFuture<ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          ListMonitoredResourceDescriptorsRequest request,
          {CallOptions options}) {
    final call = $createCall(
        _$listMonitoredResourceDescriptors, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }

  ResponseFuture<ListLogsResponse> listLogs(ListLogsRequest request,
      {CallOptions options}) {
    final call = $createCall(_$listLogs, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }
}

abstract class LoggingServiceV2ServiceBase extends Service {
  String get $name => 'google.logging.v2.LoggingServiceV2';

  LoggingServiceV2ServiceBase() {
    $addMethod(ServiceMethod<DeleteLogRequest, $google$protobuf.Empty>(
        'DeleteLog',
        deleteLog_Pre,
        false,
        false,
        (List<int> value) => DeleteLogRequest.fromBuffer(value),
        ($google$protobuf.Empty value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<WriteLogEntriesRequest, WriteLogEntriesResponse>(
        'WriteLogEntries',
        writeLogEntries_Pre,
        false,
        false,
        (List<int> value) => WriteLogEntriesRequest.fromBuffer(value),
        (WriteLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<ListLogEntriesRequest, ListLogEntriesResponse>(
        'ListLogEntries',
        listLogEntries_Pre,
        false,
        false,
        (List<int> value) => ListLogEntriesRequest.fromBuffer(value),
        (ListLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<ListMonitoredResourceDescriptorsRequest,
            ListMonitoredResourceDescriptorsResponse>(
        'ListMonitoredResourceDescriptors',
        listMonitoredResourceDescriptors_Pre,
        false,
        false,
        (List<int> value) =>
            ListMonitoredResourceDescriptorsRequest.fromBuffer(value),
        (ListMonitoredResourceDescriptorsResponse value) =>
            value.writeToBuffer()));
    $addMethod(ServiceMethod<ListLogsRequest, ListLogsResponse>(
        'ListLogs',
        listLogs_Pre,
        false,
        false,
        (List<int> value) => ListLogsRequest.fromBuffer(value),
        (ListLogsResponse value) => value.writeToBuffer()));
  }

  Future<$google$protobuf.Empty> deleteLog_Pre(
      ServiceCall call, Future request) async {
    return deleteLog(call, await request);
  }

  Future<WriteLogEntriesResponse> writeLogEntries_Pre(
      ServiceCall call, Future request) async {
    return writeLogEntries(call, await request);
  }

  Future<ListLogEntriesResponse> listLogEntries_Pre(
      ServiceCall call, Future request) async {
    return listLogEntries(call, await request);
  }

  Future<ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(
          ServiceCall call, Future request) async {
    return listMonitoredResourceDescriptors(call, await request);
  }

  Future<ListLogsResponse> listLogs_Pre(
      ServiceCall call, Future request) async {
    return listLogs(call, await request);
  }

  Future<$google$protobuf.Empty> deleteLog(
      ServiceCall call, DeleteLogRequest request);
  Future<WriteLogEntriesResponse> writeLogEntries(
      ServiceCall call, WriteLogEntriesRequest request);
  Future<ListLogEntriesResponse> listLogEntries(
      ServiceCall call, ListLogEntriesRequest request);
  Future<ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          ServiceCall call, ListMonitoredResourceDescriptorsRequest request);
  Future<ListLogsResponse> listLogs(ServiceCall call, ListLogsRequest request);
}
