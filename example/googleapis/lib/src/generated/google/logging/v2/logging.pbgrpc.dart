///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.v2_logging_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import '../../protobuf/empty.pb.dart' as $google$protobuf;
import 'logging.pb.dart';
export 'logging.pb.dart';

class LoggingServiceV2Client extends Client {
  static final _$deleteLog =
      new ClientMethod<DeleteLogRequest, $google$protobuf.Empty>(
          '/google.logging.v2.LoggingServiceV2/DeleteLog',
          (DeleteLogRequest value) => value.writeToBuffer(),
          (List<int> value) => new $google$protobuf.Empty.fromBuffer(value));
  static final _$writeLogEntries =
      new ClientMethod<WriteLogEntriesRequest, WriteLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/WriteLogEntries',
          (WriteLogEntriesRequest value) => value.writeToBuffer(),
          (List<int> value) => new WriteLogEntriesResponse.fromBuffer(value));
  static final _$listLogEntries =
      new ClientMethod<ListLogEntriesRequest, ListLogEntriesResponse>(
          '/google.logging.v2.LoggingServiceV2/ListLogEntries',
          (ListLogEntriesRequest value) => value.writeToBuffer(),
          (List<int> value) => new ListLogEntriesResponse.fromBuffer(value));
  static final _$listMonitoredResourceDescriptors = new ClientMethod<
          ListMonitoredResourceDescriptorsRequest,
          ListMonitoredResourceDescriptorsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListMonitoredResourceDescriptors',
      (ListMonitoredResourceDescriptorsRequest value) => value.writeToBuffer(),
      (List<int> value) =>
          new ListMonitoredResourceDescriptorsResponse.fromBuffer(value));
  static final _$listLogs = new ClientMethod<ListLogsRequest, ListLogsResponse>(
      '/google.logging.v2.LoggingServiceV2/ListLogs',
      (ListLogsRequest value) => value.writeToBuffer(),
      (List<int> value) => new ListLogsResponse.fromBuffer(value));

  LoggingServiceV2Client(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<$google$protobuf.Empty> deleteLog(DeleteLogRequest request,
      {CallOptions options}) {
    final call = $createCall(_$deleteLog, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<WriteLogEntriesResponse> writeLogEntries(
      WriteLogEntriesRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$writeLogEntries, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<ListLogEntriesResponse> listLogEntries(
      ListLogEntriesRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$listLogEntries, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors(
          ListMonitoredResourceDescriptorsRequest request,
          {CallOptions options}) {
    final call = $createCall(
        _$listMonitoredResourceDescriptors, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<ListLogsResponse> listLogs(ListLogsRequest request,
      {CallOptions options}) {
    final call = $createCall(_$listLogs, new Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class LoggingServiceV2ServiceBase extends Service {
  String get $name => 'google.logging.v2.LoggingServiceV2';

  LoggingServiceV2ServiceBase() {
    $addMethod(new ServiceMethod<DeleteLogRequest, $google$protobuf.Empty>(
        'DeleteLog',
        deleteLog_Pre,
        false,
        false,
        (List<int> value) => new DeleteLogRequest.fromBuffer(value),
        ($google$protobuf.Empty value) => value.writeToBuffer()));
    $addMethod(
        new ServiceMethod<WriteLogEntriesRequest, WriteLogEntriesResponse>(
            'WriteLogEntries',
            writeLogEntries_Pre,
            false,
            false,
            (List<int> value) => new WriteLogEntriesRequest.fromBuffer(value),
            (WriteLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ListLogEntriesRequest, ListLogEntriesResponse>(
        'ListLogEntries',
        listLogEntries_Pre,
        false,
        false,
        (List<int> value) => new ListLogEntriesRequest.fromBuffer(value),
        (ListLogEntriesResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ListMonitoredResourceDescriptorsRequest,
            ListMonitoredResourceDescriptorsResponse>(
        'ListMonitoredResourceDescriptors',
        listMonitoredResourceDescriptors_Pre,
        false,
        false,
        (List<int> value) =>
            new ListMonitoredResourceDescriptorsRequest.fromBuffer(value),
        (ListMonitoredResourceDescriptorsResponse value) =>
            value.writeToBuffer()));
    $addMethod(new ServiceMethod<ListLogsRequest, ListLogsResponse>(
        'ListLogs',
        listLogs_Pre,
        false,
        false,
        (List<int> value) => new ListLogsRequest.fromBuffer(value),
        (ListLogsResponse value) => value.writeToBuffer()));
  }

  Future<$google$protobuf.Empty> deleteLog_Pre(
      ServiceCall call, Future<DeleteLogRequest> request) async {
    return deleteLog(call, await request);
  }

  Future<WriteLogEntriesResponse> writeLogEntries_Pre(
      ServiceCall call, Future<WriteLogEntriesRequest> request) async {
    return writeLogEntries(call, await request);
  }

  Future<ListLogEntriesResponse> listLogEntries_Pre(
      ServiceCall call, Future<ListLogEntriesRequest> request) async {
    return listLogEntries(call, await request);
  }

  Future<ListMonitoredResourceDescriptorsResponse>
      listMonitoredResourceDescriptors_Pre(ServiceCall call,
          Future<ListMonitoredResourceDescriptorsRequest> request) async {
    return listMonitoredResourceDescriptors(call, await request);
  }

  Future<ListLogsResponse> listLogs_Pre(
      ServiceCall call, Future<ListLogsRequest> request) async {
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
