// This is a generated file - do not edit.
//
// Generated from google/logging/v2/logging.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/monitored_resource.pb.dart' as $2;
import '../../protobuf/duration.pb.dart' as $5;
import '../../rpc/status.pb.dart' as $4;
import 'log_entry.pb.dart' as $3;
import 'logging.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'logging.pbenum.dart';

/// The parameters to DeleteLog.
class DeleteLogRequest extends $pb.GeneratedMessage {
  factory DeleteLogRequest({
    $core.String? logName,
  }) {
    final result = create();
    if (logName != null) result.logName = logName;
    return result;
  }

  DeleteLogRequest._();

  factory DeleteLogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteLogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteLogRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'logName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteLogRequest copyWith(void Function(DeleteLogRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteLogRequest))
          as DeleteLogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest create() => DeleteLogRequest._();
  @$core.override
  DeleteLogRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLogRequest>(create);
  static DeleteLogRequest? _defaultInstance;

  /// Required. The resource name of the log to delete:
  ///
  /// * `projects/[PROJECT_ID]/logs/[LOG_ID]`
  /// * `organizations/[ORGANIZATION_ID]/logs/[LOG_ID]`
  /// * `billingAccounts/[BILLING_ACCOUNT_ID]/logs/[LOG_ID]`
  /// * `folders/[FOLDER_ID]/logs/[LOG_ID]`
  ///
  /// `[LOG_ID]` must be URL-encoded. For example,
  /// `"projects/my-project-id/logs/syslog"`,
  /// `"organizations/123/logs/cloudaudit.googleapis.com%2Factivity"`.
  ///
  /// For more information about log names, see
  /// [LogEntry][google.logging.v2.LogEntry].
  @$pb.TagNumber(1)
  $core.String get logName => $_getSZ(0);
  @$pb.TagNumber(1)
  set logName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLogName() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogName() => $_clearField(1);
}

/// The parameters to WriteLogEntries.
class WriteLogEntriesRequest extends $pb.GeneratedMessage {
  factory WriteLogEntriesRequest({
    $core.String? logName,
    $2.MonitoredResource? resource,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.Iterable<$3.LogEntry>? entries,
    $core.bool? partialSuccess,
    $core.bool? dryRun,
  }) {
    final result = create();
    if (logName != null) result.logName = logName;
    if (resource != null) result.resource = resource;
    if (labels != null) result.labels.addEntries(labels);
    if (entries != null) result.entries.addAll(entries);
    if (partialSuccess != null) result.partialSuccess = partialSuccess;
    if (dryRun != null) result.dryRun = dryRun;
    return result;
  }

  WriteLogEntriesRequest._();

  factory WriteLogEntriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WriteLogEntriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WriteLogEntriesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'logName')
    ..aOM<$2.MonitoredResource>(2, _omitFieldNames ? '' : 'resource',
        subBuilder: $2.MonitoredResource.create)
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'labels',
        entryClassName: 'WriteLogEntriesRequest.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..pPM<$3.LogEntry>(4, _omitFieldNames ? '' : 'entries',
        subBuilder: $3.LogEntry.create)
    ..aOB(5, _omitFieldNames ? '' : 'partialSuccess')
    ..aOB(6, _omitFieldNames ? '' : 'dryRun')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesRequest copyWith(
          void Function(WriteLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesRequest))
          as WriteLogEntriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest create() => WriteLogEntriesRequest._();
  @$core.override
  WriteLogEntriesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesRequest>(create);
  static WriteLogEntriesRequest? _defaultInstance;

  /// Optional. A default log resource name that is assigned to all log entries
  /// in `entries` that do not specify a value for `log_name`:
  ///
  /// * `projects/[PROJECT_ID]/logs/[LOG_ID]`
  /// * `organizations/[ORGANIZATION_ID]/logs/[LOG_ID]`
  /// * `billingAccounts/[BILLING_ACCOUNT_ID]/logs/[LOG_ID]`
  /// * `folders/[FOLDER_ID]/logs/[LOG_ID]`
  ///
  /// `[LOG_ID]` must be URL-encoded. For example:
  ///
  ///     "projects/my-project-id/logs/syslog"
  ///     "organizations/123/logs/cloudaudit.googleapis.com%2Factivity"
  ///
  /// The permission `logging.logEntries.create` is needed on each project,
  /// organization, billing account, or folder that is receiving new log
  /// entries, whether the resource is specified in `logName` or in an
  /// individual log entry.
  @$pb.TagNumber(1)
  $core.String get logName => $_getSZ(0);
  @$pb.TagNumber(1)
  set logName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLogName() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogName() => $_clearField(1);

  /// Optional. A default monitored resource object that is assigned to all log
  /// entries in `entries` that do not specify a value for `resource`. Example:
  ///
  ///     { "type": "gce_instance",
  ///       "labels": {
  ///         "zone": "us-central1-a", "instance_id": "00000000000000000000" }}
  ///
  /// See [LogEntry][google.logging.v2.LogEntry].
  @$pb.TagNumber(2)
  $2.MonitoredResource get resource => $_getN(1);
  @$pb.TagNumber(2)
  set resource($2.MonitoredResource value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResource() => $_has(1);
  @$pb.TagNumber(2)
  void clearResource() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.MonitoredResource ensureResource() => $_ensure(1);

  /// Optional. Default labels that are added to the `labels` field of all log
  /// entries in `entries`. If a log entry already has a label with the same key
  /// as a label in this parameter, then the log entry's label is not changed.
  /// See [LogEntry][google.logging.v2.LogEntry].
  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(2);

  /// Required. The log entries to send to Logging. The order of log
  /// entries in this list does not matter. Values supplied in this method's
  /// `log_name`, `resource`, and `labels` fields are copied into those log
  /// entries in this list that do not include values for their corresponding
  /// fields. For more information, see the
  /// [LogEntry][google.logging.v2.LogEntry] type.
  ///
  /// If the `timestamp` or `insert_id` fields are missing in log entries, then
  /// this method supplies the current time or a unique identifier, respectively.
  /// The supplied values are chosen so that, among the log entries that did not
  /// supply their own values, the entries earlier in the list will sort before
  /// the entries later in the list. See the `entries.list` method.
  ///
  /// Log entries with timestamps that are more than the
  /// [logs retention period](https://cloud.google.com/logging/quotas) in
  /// the past or more than 24 hours in the future will not be available when
  /// calling `entries.list`. However, those log entries can still be [exported
  /// with
  /// LogSinks](https://cloud.google.com/logging/docs/api/tasks/exporting-logs).
  ///
  /// To improve throughput and to avoid exceeding the
  /// [quota limit](https://cloud.google.com/logging/quotas) for calls to
  /// `entries.write`, you should try to include several log entries in this
  /// list, rather than calling this method for each individual log entry.
  @$pb.TagNumber(4)
  $pb.PbList<$3.LogEntry> get entries => $_getList(3);

  /// Optional. Whether a batch's valid entries should be written even if some
  /// other entry failed due to a permanent error such as INVALID_ARGUMENT or
  /// PERMISSION_DENIED. If any entry failed, then the response status is the
  /// response status of one of the failed entries. The response will include
  /// error details in `WriteLogEntriesPartialErrors.log_entry_errors` keyed by
  /// the entries' zero-based index in the `entries`. Failed requests for which
  /// no entries are written will not include per-entry errors.
  @$pb.TagNumber(5)
  $core.bool get partialSuccess => $_getBF(4);
  @$pb.TagNumber(5)
  set partialSuccess($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPartialSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearPartialSuccess() => $_clearField(5);

  /// Optional. If true, the request should expect normal response, but the
  /// entries won't be persisted nor exported. Useful for checking whether the
  /// logging API endpoints are working properly before sending valuable data.
  @$pb.TagNumber(6)
  $core.bool get dryRun => $_getBF(5);
  @$pb.TagNumber(6)
  set dryRun($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDryRun() => $_has(5);
  @$pb.TagNumber(6)
  void clearDryRun() => $_clearField(6);
}

/// Result returned from WriteLogEntries.
class WriteLogEntriesResponse extends $pb.GeneratedMessage {
  factory WriteLogEntriesResponse() => create();

  WriteLogEntriesResponse._();

  factory WriteLogEntriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WriteLogEntriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WriteLogEntriesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesResponse copyWith(
          void Function(WriteLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesResponse))
          as WriteLogEntriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse create() => WriteLogEntriesResponse._();
  @$core.override
  WriteLogEntriesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesResponse>(create);
  static WriteLogEntriesResponse? _defaultInstance;
}

/// Error details for WriteLogEntries with partial success.
class WriteLogEntriesPartialErrors extends $pb.GeneratedMessage {
  factory WriteLogEntriesPartialErrors({
    $core.Iterable<$core.MapEntry<$core.int, $4.Status>>? logEntryErrors,
  }) {
    final result = create();
    if (logEntryErrors != null)
      result.logEntryErrors.addEntries(logEntryErrors);
    return result;
  }

  WriteLogEntriesPartialErrors._();

  factory WriteLogEntriesPartialErrors.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WriteLogEntriesPartialErrors.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WriteLogEntriesPartialErrors',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..m<$core.int, $4.Status>(1, _omitFieldNames ? '' : 'logEntryErrors',
        entryClassName: 'WriteLogEntriesPartialErrors.LogEntryErrorsEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Status.create,
        valueDefaultOrMaker: $4.Status.getDefault,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesPartialErrors clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WriteLogEntriesPartialErrors copyWith(
          void Function(WriteLogEntriesPartialErrors) updates) =>
      super.copyWith(
              (message) => updates(message as WriteLogEntriesPartialErrors))
          as WriteLogEntriesPartialErrors;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesPartialErrors create() =>
      WriteLogEntriesPartialErrors._();
  @$core.override
  WriteLogEntriesPartialErrors createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesPartialErrors getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesPartialErrors>(create);
  static WriteLogEntriesPartialErrors? _defaultInstance;

  /// When `WriteLogEntriesRequest.partial_success` is true, records the error
  /// status for entries that were not written due to a permanent error, keyed
  /// by the entry's zero-based index in `WriteLogEntriesRequest.entries`.
  ///
  /// Failed requests for which no entries are written will not include
  /// per-entry errors.
  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $4.Status> get logEntryErrors => $_getMap(0);
}

/// The parameters to `ListLogEntries`.
class ListLogEntriesRequest extends $pb.GeneratedMessage {
  factory ListLogEntriesRequest({
    $core.String? filter,
    $core.String? orderBy,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$core.String>? resourceNames,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    if (orderBy != null) result.orderBy = orderBy;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (resourceNames != null) result.resourceNames.addAll(resourceNames);
    return result;
  }

  ListLogEntriesRequest._();

  factory ListLogEntriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListLogEntriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogEntriesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'filter')
    ..aOS(3, _omitFieldNames ? '' : 'orderBy')
    ..aI(4, _omitFieldNames ? '' : 'pageSize')
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..pPS(8, _omitFieldNames ? '' : 'resourceNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogEntriesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogEntriesRequest copyWith(
          void Function(ListLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesRequest))
          as ListLogEntriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest create() => ListLogEntriesRequest._();
  @$core.override
  ListLogEntriesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesRequest>(create);
  static ListLogEntriesRequest? _defaultInstance;

  /// Optional. Only log entries that match the filter are returned.  An empty
  /// filter matches all log entries in the resources listed in `resource_names`.
  /// Referencing a parent resource that is not listed in `resource_names` will
  /// cause the filter to return no results. The maximum length of a filter is
  /// 20,000 characters.
  @$pb.TagNumber(2)
  $core.String get filter => $_getSZ(0);
  @$pb.TagNumber(2)
  set filter($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(2)
  void clearFilter() => $_clearField(2);

  /// Optional. How the results should be sorted.  Presently, the only permitted
  /// values are `"timestamp asc"` (default) and `"timestamp desc"`. The first
  /// option returns entries in order of increasing values of
  /// `LogEntry.timestamp` (oldest first), and the second option returns entries
  /// in order of decreasing timestamps (newest first).  Entries with equal
  /// timestamps are returned in order of their `insert_id` values.
  @$pb.TagNumber(3)
  $core.String get orderBy => $_getSZ(1);
  @$pb.TagNumber(3)
  set orderBy($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasOrderBy() => $_has(1);
  @$pb.TagNumber(3)
  void clearOrderBy() => $_clearField(3);

  /// Optional. The maximum number of results to return from this request.
  /// Default is 50. If the value is negative or exceeds 1000, the request is
  /// rejected. The presence of `next_page_token` in the response indicates that
  /// more results might be available.
  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);

  /// Optional. If present, then retrieve the next batch of results from the
  /// preceding call to this method.  `page_token` must be the value of
  /// `next_page_token` from the previous response.  The values of other method
  /// parameters should be identical to those in the previous call.
  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(5)
  set pageToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(5)
  void clearPageToken() => $_clearField(5);

  /// Required. Names of one or more parent resources from which to
  /// retrieve log entries:
  ///
  /// *  `projects/[PROJECT_ID]`
  /// *  `organizations/[ORGANIZATION_ID]`
  /// *  `billingAccounts/[BILLING_ACCOUNT_ID]`
  /// *  `folders/[FOLDER_ID]`
  ///
  /// May alternatively be one or more views:
  ///
  ///  * `projects/[PROJECT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `organizations/[ORGANIZATION_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `billingAccounts/[BILLING_ACCOUNT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `folders/[FOLDER_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///
  /// Projects listed in the `project_ids` field are added to this list.
  /// A maximum of 100 resources may be specified in a single request.
  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get resourceNames => $_getList(4);
}

/// Result returned from `ListLogEntries`.
class ListLogEntriesResponse extends $pb.GeneratedMessage {
  factory ListLogEntriesResponse({
    $core.Iterable<$3.LogEntry>? entries,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListLogEntriesResponse._();

  factory ListLogEntriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListLogEntriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogEntriesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pPM<$3.LogEntry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: $3.LogEntry.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogEntriesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogEntriesResponse copyWith(
          void Function(ListLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesResponse))
          as ListLogEntriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse create() => ListLogEntriesResponse._();
  @$core.override
  ListLogEntriesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesResponse>(create);
  static ListLogEntriesResponse? _defaultInstance;

  /// A list of log entries.  If `entries` is empty, `nextPageToken` may still be
  /// returned, indicating that more entries may exist.  See `nextPageToken` for
  /// more information.
  @$pb.TagNumber(1)
  $pb.PbList<$3.LogEntry> get entries => $_getList(0);

  /// If there might be more results than those appearing in this response, then
  /// `nextPageToken` is included.  To get the next set of results, call this
  /// method again using the value of `nextPageToken` as `pageToken`.
  ///
  /// If a value for `next_page_token` appears and the `entries` field is empty,
  /// it means that the search found no log entries so far but it did not have
  /// time to search all the possible log entries.  Retry the method with this
  /// value for `page_token` to continue the search.  Alternatively, consider
  /// speeding up the search by changing your filter to specify a single log name
  /// or resource type, or to narrow the time range of the search.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

/// The parameters to ListMonitoredResourceDescriptors
class ListMonitoredResourceDescriptorsRequest extends $pb.GeneratedMessage {
  factory ListMonitoredResourceDescriptorsRequest({
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  ListMonitoredResourceDescriptorsRequest._();

  factory ListMonitoredResourceDescriptorsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMonitoredResourceDescriptorsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMonitoredResourceDescriptorsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pageSize')
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMonitoredResourceDescriptorsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMonitoredResourceDescriptorsRequest copyWith(
          void Function(ListMonitoredResourceDescriptorsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListMonitoredResourceDescriptorsRequest))
          as ListMonitoredResourceDescriptorsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsRequest create() =>
      ListMonitoredResourceDescriptorsRequest._();
  @$core.override
  ListMonitoredResourceDescriptorsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListMonitoredResourceDescriptorsRequest>(create);
  static ListMonitoredResourceDescriptorsRequest? _defaultInstance;

  /// Optional. The maximum number of results to return from this request.
  /// Non-positive values are ignored.  The presence of `nextPageToken` in the
  /// response indicates that more results might be available.
  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => $_clearField(1);

  /// Optional. If present, then retrieve the next batch of results from the
  /// preceding call to this method.  `pageToken` must be the value of
  /// `nextPageToken` from the previous response.  The values of other method
  /// parameters should be identical to those in the previous call.
  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => $_clearField(2);
}

/// Result returned from ListMonitoredResourceDescriptors.
class ListMonitoredResourceDescriptorsResponse extends $pb.GeneratedMessage {
  factory ListMonitoredResourceDescriptorsResponse({
    $core.Iterable<$2.MonitoredResourceDescriptor>? resourceDescriptors,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (resourceDescriptors != null)
      result.resourceDescriptors.addAll(resourceDescriptors);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListMonitoredResourceDescriptorsResponse._();

  factory ListMonitoredResourceDescriptorsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMonitoredResourceDescriptorsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMonitoredResourceDescriptorsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pPM<$2.MonitoredResourceDescriptor>(
        1, _omitFieldNames ? '' : 'resourceDescriptors',
        subBuilder: $2.MonitoredResourceDescriptor.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMonitoredResourceDescriptorsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMonitoredResourceDescriptorsResponse copyWith(
          void Function(ListMonitoredResourceDescriptorsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListMonitoredResourceDescriptorsResponse))
          as ListMonitoredResourceDescriptorsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsResponse create() =>
      ListMonitoredResourceDescriptorsResponse._();
  @$core.override
  ListMonitoredResourceDescriptorsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListMonitoredResourceDescriptorsResponse>(create);
  static ListMonitoredResourceDescriptorsResponse? _defaultInstance;

  /// A list of resource descriptors.
  @$pb.TagNumber(1)
  $pb.PbList<$2.MonitoredResourceDescriptor> get resourceDescriptors =>
      $_getList(0);

  /// If there might be more results than those appearing in this response, then
  /// `nextPageToken` is included.  To get the next set of results, call this
  /// method again using the value of `nextPageToken` as `pageToken`.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

/// The parameters to ListLogs.
class ListLogsRequest extends $pb.GeneratedMessage {
  factory ListLogsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$core.String>? resourceNames,
  }) {
    final result = create();
    if (parent != null) result.parent = parent;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    if (resourceNames != null) result.resourceNames.addAll(resourceNames);
    return result;
  }

  ListLogsRequest._();

  factory ListLogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListLogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aI(2, _omitFieldNames ? '' : 'pageSize')
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..pPS(8, _omitFieldNames ? '' : 'resourceNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogsRequest copyWith(void Function(ListLogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogsRequest))
          as ListLogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogsRequest create() => ListLogsRequest._();
  @$core.override
  ListLogsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsRequest>(create);
  static ListLogsRequest? _defaultInstance;

  /// Required. The resource name to list logs for:
  ///
  /// *  `projects/[PROJECT_ID]`
  /// *  `organizations/[ORGANIZATION_ID]`
  /// *  `billingAccounts/[BILLING_ACCOUNT_ID]`
  /// *  `folders/[FOLDER_ID]`
  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => $_clearField(1);

  /// Optional. The maximum number of results to return from this request.
  /// Non-positive values are ignored.  The presence of `nextPageToken` in the
  /// response indicates that more results might be available.
  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  /// Optional. If present, then retrieve the next batch of results from the
  /// preceding call to this method.  `pageToken` must be the value of
  /// `nextPageToken` from the previous response.  The values of other method
  /// parameters should be identical to those in the previous call.
  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => $_clearField(3);

  /// Optional. List of resource names to list logs for:
  ///
  ///  * `projects/[PROJECT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `organizations/[ORGANIZATION_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `billingAccounts/[BILLING_ACCOUNT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `folders/[FOLDER_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///
  /// To support legacy queries, it could also be:
  ///
  /// *  `projects/[PROJECT_ID]`
  /// *  `organizations/[ORGANIZATION_ID]`
  /// *  `billingAccounts/[BILLING_ACCOUNT_ID]`
  /// *  `folders/[FOLDER_ID]`
  ///
  /// The resource name in the `parent` field is added to this list.
  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get resourceNames => $_getList(3);
}

/// Result returned from ListLogs.
class ListLogsResponse extends $pb.GeneratedMessage {
  factory ListLogsResponse({
    $core.String? nextPageToken,
    $core.Iterable<$core.String>? logNames,
  }) {
    final result = create();
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    if (logNames != null) result.logNames.addAll(logNames);
    return result;
  }

  ListLogsResponse._();

  factory ListLogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListLogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..pPS(3, _omitFieldNames ? '' : 'logNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListLogsResponse copyWith(void Function(ListLogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogsResponse))
          as ListLogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogsResponse create() => ListLogsResponse._();
  @$core.override
  ListLogsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListLogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsResponse>(create);
  static ListLogsResponse? _defaultInstance;

  /// If there might be more results than those appearing in this response, then
  /// `nextPageToken` is included.  To get the next set of results, call this
  /// method again using the value of `nextPageToken` as `pageToken`.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(0);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(0);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);

  /// A list of log names. For example,
  /// `"projects/my-project/logs/syslog"` or
  /// `"organizations/123/logs/cloudresourcemanager.googleapis.com%2Factivity"`.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get logNames => $_getList(1);
}

/// The parameters to `TailLogEntries`.
class TailLogEntriesRequest extends $pb.GeneratedMessage {
  factory TailLogEntriesRequest({
    $core.Iterable<$core.String>? resourceNames,
    $core.String? filter,
    $5.Duration? bufferWindow,
  }) {
    final result = create();
    if (resourceNames != null) result.resourceNames.addAll(resourceNames);
    if (filter != null) result.filter = filter;
    if (bufferWindow != null) result.bufferWindow = bufferWindow;
    return result;
  }

  TailLogEntriesRequest._();

  factory TailLogEntriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TailLogEntriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TailLogEntriesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'resourceNames')
    ..aOS(2, _omitFieldNames ? '' : 'filter')
    ..aOM<$5.Duration>(3, _omitFieldNames ? '' : 'bufferWindow',
        subBuilder: $5.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesRequest copyWith(
          void Function(TailLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as TailLogEntriesRequest))
          as TailLogEntriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TailLogEntriesRequest create() => TailLogEntriesRequest._();
  @$core.override
  TailLogEntriesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TailLogEntriesRequest>(create);
  static TailLogEntriesRequest? _defaultInstance;

  /// Required. Name of a parent resource from which to retrieve log entries:
  ///
  /// *  `projects/[PROJECT_ID]`
  /// *  `organizations/[ORGANIZATION_ID]`
  /// *  `billingAccounts/[BILLING_ACCOUNT_ID]`
  /// *  `folders/[FOLDER_ID]`
  ///
  /// May alternatively be one or more views:
  ///
  ///  * `projects/[PROJECT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `organizations/[ORGANIZATION_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `billingAccounts/[BILLING_ACCOUNT_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  ///  * `folders/[FOLDER_ID]/locations/[LOCATION_ID]/buckets/[BUCKET_ID]/views/[VIEW_ID]`
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get resourceNames => $_getList(0);

  /// Optional. Only log entries that match the filter are returned.  An empty
  /// filter matches all log entries in the resources listed in `resource_names`.
  /// Referencing a parent resource that is not listed in `resource_names` will
  /// cause the filter to return no results. The maximum length of a filter is
  /// 20,000 characters.
  @$pb.TagNumber(2)
  $core.String get filter => $_getSZ(1);
  @$pb.TagNumber(2)
  set filter($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => $_clearField(2);

  /// Optional. The amount of time to buffer log entries at the server before
  /// being returned to prevent out of order results due to late arriving log
  /// entries. Valid values are between 0-60000 milliseconds. Defaults to 2000
  /// milliseconds.
  @$pb.TagNumber(3)
  $5.Duration get bufferWindow => $_getN(2);
  @$pb.TagNumber(3)
  set bufferWindow($5.Duration value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBufferWindow() => $_has(2);
  @$pb.TagNumber(3)
  void clearBufferWindow() => $_clearField(3);
  @$pb.TagNumber(3)
  $5.Duration ensureBufferWindow() => $_ensure(2);
}

/// Information about entries that were omitted from the session.
class TailLogEntriesResponse_SuppressionInfo extends $pb.GeneratedMessage {
  factory TailLogEntriesResponse_SuppressionInfo({
    TailLogEntriesResponse_SuppressionInfo_Reason? reason,
    $core.int? suppressedCount,
  }) {
    final result = create();
    if (reason != null) result.reason = reason;
    if (suppressedCount != null) result.suppressedCount = suppressedCount;
    return result;
  }

  TailLogEntriesResponse_SuppressionInfo._();

  factory TailLogEntriesResponse_SuppressionInfo.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TailLogEntriesResponse_SuppressionInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TailLogEntriesResponse.SuppressionInfo',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aE<TailLogEntriesResponse_SuppressionInfo_Reason>(
        1, _omitFieldNames ? '' : 'reason',
        enumValues: TailLogEntriesResponse_SuppressionInfo_Reason.values)
    ..aI(2, _omitFieldNames ? '' : 'suppressedCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesResponse_SuppressionInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesResponse_SuppressionInfo copyWith(
          void Function(TailLogEntriesResponse_SuppressionInfo) updates) =>
      super.copyWith((message) =>
              updates(message as TailLogEntriesResponse_SuppressionInfo))
          as TailLogEntriesResponse_SuppressionInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse_SuppressionInfo create() =>
      TailLogEntriesResponse_SuppressionInfo._();
  @$core.override
  TailLogEntriesResponse_SuppressionInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse_SuppressionInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TailLogEntriesResponse_SuppressionInfo>(create);
  static TailLogEntriesResponse_SuppressionInfo? _defaultInstance;

  /// The reason that entries were omitted from the session.
  @$pb.TagNumber(1)
  TailLogEntriesResponse_SuppressionInfo_Reason get reason => $_getN(0);
  @$pb.TagNumber(1)
  set reason(TailLogEntriesResponse_SuppressionInfo_Reason value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => $_clearField(1);

  /// A lower bound on the count of entries omitted due to `reason`.
  @$pb.TagNumber(2)
  $core.int get suppressedCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set suppressedCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuppressedCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuppressedCount() => $_clearField(2);
}

/// Result returned from `TailLogEntries`.
class TailLogEntriesResponse extends $pb.GeneratedMessage {
  factory TailLogEntriesResponse({
    $core.Iterable<$3.LogEntry>? entries,
    $core.Iterable<TailLogEntriesResponse_SuppressionInfo>? suppressionInfo,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (suppressionInfo != null) result.suppressionInfo.addAll(suppressionInfo);
    return result;
  }

  TailLogEntriesResponse._();

  factory TailLogEntriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TailLogEntriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TailLogEntriesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pPM<$3.LogEntry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: $3.LogEntry.create)
    ..pPM<TailLogEntriesResponse_SuppressionInfo>(
        2, _omitFieldNames ? '' : 'suppressionInfo',
        subBuilder: TailLogEntriesResponse_SuppressionInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TailLogEntriesResponse copyWith(
          void Function(TailLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as TailLogEntriesResponse))
          as TailLogEntriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse create() => TailLogEntriesResponse._();
  @$core.override
  TailLogEntriesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TailLogEntriesResponse>(create);
  static TailLogEntriesResponse? _defaultInstance;

  /// A list of log entries. Each response in the stream will order entries with
  /// increasing values of `LogEntry.timestamp`. Ordering is not guaranteed
  /// between separate responses.
  @$pb.TagNumber(1)
  $pb.PbList<$3.LogEntry> get entries => $_getList(0);

  /// If entries that otherwise would have been included in the session were not
  /// sent back to the client, counts of relevant entries omitted from the
  /// session with the reason that they were not included. There will be at most
  /// one of each reason per response. The counts represent the number of
  /// suppressed entries since the last streamed response.
  @$pb.TagNumber(2)
  $pb.PbList<TailLogEntriesResponse_SuppressionInfo> get suppressionInfo =>
      $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
