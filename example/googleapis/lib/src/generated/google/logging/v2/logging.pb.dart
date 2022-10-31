///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/monitored_resource.pb.dart' as $2;
import 'log_entry.pb.dart' as $3;
import '../../rpc/status.pb.dart' as $4;
import '../../protobuf/duration.pb.dart' as $5;

import 'logging.pbenum.dart';

export 'logging.pbenum.dart';

class DeleteLogRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DeleteLogRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'logName')
    ..hasRequiredFields = false;

  DeleteLogRequest._() : super();
  factory DeleteLogRequest({
    $core.String? logName,
  }) {
    final _result = create();
    if (logName != null) {
      _result.logName = logName;
    }
    return _result;
  }
  factory DeleteLogRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteLogRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteLogRequest clone() => DeleteLogRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteLogRequest copyWith(void Function(DeleteLogRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteLogRequest))
          as DeleteLogRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest create() => DeleteLogRequest._();
  DeleteLogRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteLogRequest> createRepeated() =>
      $pb.PbList<DeleteLogRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLogRequest>(create);
  static DeleteLogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get logName => $_getSZ(0);
  @$pb.TagNumber(1)
  set logName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLogName() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogName() => clearField(1);
}

class WriteLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'WriteLogEntriesRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'logName')
    ..aOM<$2.MonitoredResource>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resource',
        subBuilder: $2.MonitoredResource.create)
    ..m<$core.String, $core.String>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'labels',
        entryClassName: 'WriteLogEntriesRequest.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..pc<$3.LogEntry>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'entries',
        $pb.PbFieldType.PM,
        subBuilder: $3.LogEntry.create)
    ..aOB(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'partialSuccess')
    ..aOB(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'dryRun')
    ..hasRequiredFields = false;

  WriteLogEntriesRequest._() : super();
  factory WriteLogEntriesRequest({
    $core.String? logName,
    $2.MonitoredResource? resource,
    $core.Map<$core.String, $core.String>? labels,
    $core.Iterable<$3.LogEntry>? entries,
    $core.bool? partialSuccess,
    $core.bool? dryRun,
  }) {
    final _result = create();
    if (logName != null) {
      _result.logName = logName;
    }
    if (resource != null) {
      _result.resource = resource;
    }
    if (labels != null) {
      _result.labels.addAll(labels);
    }
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (partialSuccess != null) {
      _result.partialSuccess = partialSuccess;
    }
    if (dryRun != null) {
      _result.dryRun = dryRun;
    }
    return _result;
  }
  factory WriteLogEntriesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WriteLogEntriesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WriteLogEntriesRequest clone() =>
      WriteLogEntriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WriteLogEntriesRequest copyWith(
          void Function(WriteLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesRequest))
          as WriteLogEntriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest create() => WriteLogEntriesRequest._();
  WriteLogEntriesRequest createEmptyInstance() => create();
  static $pb.PbList<WriteLogEntriesRequest> createRepeated() =>
      $pb.PbList<WriteLogEntriesRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesRequest>(create);
  static WriteLogEntriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get logName => $_getSZ(0);
  @$pb.TagNumber(1)
  set logName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLogName() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogName() => clearField(1);

  @$pb.TagNumber(2)
  $2.MonitoredResource get resource => $_getN(1);
  @$pb.TagNumber(2)
  set resource($2.MonitoredResource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResource() => $_has(1);
  @$pb.TagNumber(2)
  void clearResource() => clearField(2);
  @$pb.TagNumber(2)
  $2.MonitoredResource ensureResource() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get labels => $_getMap(2);

  @$pb.TagNumber(4)
  $core.List<$3.LogEntry> get entries => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get partialSuccess => $_getBF(4);
  @$pb.TagNumber(5)
  set partialSuccess($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPartialSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearPartialSuccess() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get dryRun => $_getBF(5);
  @$pb.TagNumber(6)
  set dryRun($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDryRun() => $_has(5);
  @$pb.TagNumber(6)
  void clearDryRun() => clearField(6);
}

class WriteLogEntriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'WriteLogEntriesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  WriteLogEntriesResponse._() : super();
  factory WriteLogEntriesResponse() => create();
  factory WriteLogEntriesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WriteLogEntriesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WriteLogEntriesResponse clone() =>
      WriteLogEntriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WriteLogEntriesResponse copyWith(
          void Function(WriteLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesResponse))
          as WriteLogEntriesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse create() => WriteLogEntriesResponse._();
  WriteLogEntriesResponse createEmptyInstance() => create();
  static $pb.PbList<WriteLogEntriesResponse> createRepeated() =>
      $pb.PbList<WriteLogEntriesResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesResponse>(create);
  static WriteLogEntriesResponse? _defaultInstance;
}

class WriteLogEntriesPartialErrors extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'WriteLogEntriesPartialErrors',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..m<$core.int, $4.Status>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'logEntryErrors',
        entryClassName: 'WriteLogEntriesPartialErrors.LogEntryErrorsEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $4.Status.create,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..hasRequiredFields = false;

  WriteLogEntriesPartialErrors._() : super();
  factory WriteLogEntriesPartialErrors({
    $core.Map<$core.int, $4.Status>? logEntryErrors,
  }) {
    final _result = create();
    if (logEntryErrors != null) {
      _result.logEntryErrors.addAll(logEntryErrors);
    }
    return _result;
  }
  factory WriteLogEntriesPartialErrors.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WriteLogEntriesPartialErrors.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WriteLogEntriesPartialErrors clone() =>
      WriteLogEntriesPartialErrors()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WriteLogEntriesPartialErrors copyWith(
          void Function(WriteLogEntriesPartialErrors) updates) =>
      super.copyWith(
              (message) => updates(message as WriteLogEntriesPartialErrors))
          as WriteLogEntriesPartialErrors; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesPartialErrors create() =>
      WriteLogEntriesPartialErrors._();
  WriteLogEntriesPartialErrors createEmptyInstance() => create();
  static $pb.PbList<WriteLogEntriesPartialErrors> createRepeated() =>
      $pb.PbList<WriteLogEntriesPartialErrors>();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesPartialErrors getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesPartialErrors>(create);
  static WriteLogEntriesPartialErrors? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, $4.Status> get logEntryErrors => $_getMap(0);
}

class ListLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListLogEntriesRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'filter')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'orderBy')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageSize',
        $pb.PbFieldType.O3)
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageToken')
    ..pPS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceNames')
    ..hasRequiredFields = false;

  ListLogEntriesRequest._() : super();
  factory ListLogEntriesRequest({
    $core.String? filter,
    $core.String? orderBy,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$core.String>? resourceNames,
  }) {
    final _result = create();
    if (filter != null) {
      _result.filter = filter;
    }
    if (orderBy != null) {
      _result.orderBy = orderBy;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (pageToken != null) {
      _result.pageToken = pageToken;
    }
    if (resourceNames != null) {
      _result.resourceNames.addAll(resourceNames);
    }
    return _result;
  }
  factory ListLogEntriesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogEntriesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogEntriesRequest clone() =>
      ListLogEntriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogEntriesRequest copyWith(
          void Function(ListLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesRequest))
          as ListLogEntriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest create() => ListLogEntriesRequest._();
  ListLogEntriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListLogEntriesRequest> createRepeated() =>
      $pb.PbList<ListLogEntriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesRequest>(create);
  static ListLogEntriesRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get filter => $_getSZ(0);
  @$pb.TagNumber(2)
  set filter($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(2)
  void clearFilter() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get orderBy => $_getSZ(1);
  @$pb.TagNumber(3)
  set orderBy($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOrderBy() => $_has(1);
  @$pb.TagNumber(3)
  void clearOrderBy() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(4)
  set pageSize($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(5)
  set pageToken($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(5)
  void clearPageToken() => clearField(5);

  @$pb.TagNumber(8)
  $core.List<$core.String> get resourceNames => $_getList(4);
}

class ListLogEntriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListLogEntriesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pc<$3.LogEntry>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'entries',
        $pb.PbFieldType.PM,
        subBuilder: $3.LogEntry.create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'nextPageToken')
    ..hasRequiredFields = false;

  ListLogEntriesResponse._() : super();
  factory ListLogEntriesResponse({
    $core.Iterable<$3.LogEntry>? entries,
    $core.String? nextPageToken,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (nextPageToken != null) {
      _result.nextPageToken = nextPageToken;
    }
    return _result;
  }
  factory ListLogEntriesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogEntriesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogEntriesResponse clone() =>
      ListLogEntriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogEntriesResponse copyWith(
          void Function(ListLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesResponse))
          as ListLogEntriesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse create() => ListLogEntriesResponse._();
  ListLogEntriesResponse createEmptyInstance() => create();
  static $pb.PbList<ListLogEntriesResponse> createRepeated() =>
      $pb.PbList<ListLogEntriesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesResponse>(create);
  static ListLogEntriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.LogEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

class ListMonitoredResourceDescriptorsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListMonitoredResourceDescriptorsRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageSize',
        $pb.PbFieldType.O3)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageToken')
    ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsRequest._() : super();
  factory ListMonitoredResourceDescriptorsRequest({
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final _result = create();
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (pageToken != null) {
      _result.pageToken = pageToken;
    }
    return _result;
  }
  factory ListMonitoredResourceDescriptorsRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListMonitoredResourceDescriptorsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListMonitoredResourceDescriptorsRequest clone() =>
      ListMonitoredResourceDescriptorsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListMonitoredResourceDescriptorsRequest copyWith(
          void Function(ListMonitoredResourceDescriptorsRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListMonitoredResourceDescriptorsRequest))
          as ListMonitoredResourceDescriptorsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsRequest create() =>
      ListMonitoredResourceDescriptorsRequest._();
  ListMonitoredResourceDescriptorsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMonitoredResourceDescriptorsRequest> createRepeated() =>
      $pb.PbList<ListMonitoredResourceDescriptorsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListMonitoredResourceDescriptorsRequest>(create);
  static ListMonitoredResourceDescriptorsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pageSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set pageSize($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPageSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);
}

class ListMonitoredResourceDescriptorsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListMonitoredResourceDescriptorsResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pc<$2.MonitoredResourceDescriptor>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceDescriptors',
        $pb.PbFieldType.PM,
        subBuilder: $2.MonitoredResourceDescriptor.create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'nextPageToken')
    ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsResponse._() : super();
  factory ListMonitoredResourceDescriptorsResponse({
    $core.Iterable<$2.MonitoredResourceDescriptor>? resourceDescriptors,
    $core.String? nextPageToken,
  }) {
    final _result = create();
    if (resourceDescriptors != null) {
      _result.resourceDescriptors.addAll(resourceDescriptors);
    }
    if (nextPageToken != null) {
      _result.nextPageToken = nextPageToken;
    }
    return _result;
  }
  factory ListMonitoredResourceDescriptorsResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListMonitoredResourceDescriptorsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListMonitoredResourceDescriptorsResponse clone() =>
      ListMonitoredResourceDescriptorsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListMonitoredResourceDescriptorsResponse copyWith(
          void Function(ListMonitoredResourceDescriptorsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListMonitoredResourceDescriptorsResponse))
          as ListMonitoredResourceDescriptorsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsResponse create() =>
      ListMonitoredResourceDescriptorsResponse._();
  ListMonitoredResourceDescriptorsResponse createEmptyInstance() => create();
  static $pb.PbList<ListMonitoredResourceDescriptorsResponse>
      createRepeated() =>
          $pb.PbList<ListMonitoredResourceDescriptorsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListMonitoredResourceDescriptorsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListMonitoredResourceDescriptorsResponse>(create);
  static ListMonitoredResourceDescriptorsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$2.MonitoredResourceDescriptor> get resourceDescriptors =>
      $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

class ListLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListLogsRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'parent')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageSize',
        $pb.PbFieldType.O3)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pageToken')
    ..pPS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceNames')
    ..hasRequiredFields = false;

  ListLogsRequest._() : super();
  factory ListLogsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.Iterable<$core.String>? resourceNames,
  }) {
    final _result = create();
    if (parent != null) {
      _result.parent = parent;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (pageToken != null) {
      _result.pageToken = pageToken;
    }
    if (resourceNames != null) {
      _result.resourceNames.addAll(resourceNames);
    }
    return _result;
  }
  factory ListLogsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogsRequest clone() => ListLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogsRequest copyWith(void Function(ListLogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogsRequest))
          as ListLogsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogsRequest create() => ListLogsRequest._();
  ListLogsRequest createEmptyInstance() => create();
  static $pb.PbList<ListLogsRequest> createRepeated() =>
      $pb.PbList<ListLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsRequest>(create);
  static ListLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => clearField(3);

  @$pb.TagNumber(8)
  $core.List<$core.String> get resourceNames => $_getList(3);
}

class ListLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListLogsResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'nextPageToken')
    ..pPS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'logNames')
    ..hasRequiredFields = false;

  ListLogsResponse._() : super();
  factory ListLogsResponse({
    $core.String? nextPageToken,
    $core.Iterable<$core.String>? logNames,
  }) {
    final _result = create();
    if (nextPageToken != null) {
      _result.nextPageToken = nextPageToken;
    }
    if (logNames != null) {
      _result.logNames.addAll(logNames);
    }
    return _result;
  }
  factory ListLogsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogsResponse clone() => ListLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogsResponse copyWith(void Function(ListLogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogsResponse))
          as ListLogsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogsResponse create() => ListLogsResponse._();
  ListLogsResponse createEmptyInstance() => create();
  static $pb.PbList<ListLogsResponse> createRepeated() =>
      $pb.PbList<ListLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListLogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsResponse>(create);
  static ListLogsResponse? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(0);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(0);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get logNames => $_getList(1);
}

class TailLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TailLogEntriesRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pPS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceNames')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'filter')
    ..aOM<$5.Duration>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'bufferWindow',
        subBuilder: $5.Duration.create)
    ..hasRequiredFields = false;

  TailLogEntriesRequest._() : super();
  factory TailLogEntriesRequest({
    $core.Iterable<$core.String>? resourceNames,
    $core.String? filter,
    $5.Duration? bufferWindow,
  }) {
    final _result = create();
    if (resourceNames != null) {
      _result.resourceNames.addAll(resourceNames);
    }
    if (filter != null) {
      _result.filter = filter;
    }
    if (bufferWindow != null) {
      _result.bufferWindow = bufferWindow;
    }
    return _result;
  }
  factory TailLogEntriesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TailLogEntriesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TailLogEntriesRequest clone() =>
      TailLogEntriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TailLogEntriesRequest copyWith(
          void Function(TailLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as TailLogEntriesRequest))
          as TailLogEntriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesRequest create() => TailLogEntriesRequest._();
  TailLogEntriesRequest createEmptyInstance() => create();
  static $pb.PbList<TailLogEntriesRequest> createRepeated() =>
      $pb.PbList<TailLogEntriesRequest>();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TailLogEntriesRequest>(create);
  static TailLogEntriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get resourceNames => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get filter => $_getSZ(1);
  @$pb.TagNumber(2)
  set filter($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilter() => clearField(2);

  @$pb.TagNumber(3)
  $5.Duration get bufferWindow => $_getN(2);
  @$pb.TagNumber(3)
  set bufferWindow($5.Duration v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBufferWindow() => $_has(2);
  @$pb.TagNumber(3)
  void clearBufferWindow() => clearField(3);
  @$pb.TagNumber(3)
  $5.Duration ensureBufferWindow() => $_ensure(2);
}

class TailLogEntriesResponse_SuppressionInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TailLogEntriesResponse.SuppressionInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..e<TailLogEntriesResponse_SuppressionInfo_Reason>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'reason',
        $pb.PbFieldType.OE,
        defaultOrMaker:
            TailLogEntriesResponse_SuppressionInfo_Reason.REASON_UNSPECIFIED,
        valueOf: TailLogEntriesResponse_SuppressionInfo_Reason.valueOf,
        enumValues: TailLogEntriesResponse_SuppressionInfo_Reason.values)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'suppressedCount',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  TailLogEntriesResponse_SuppressionInfo._() : super();
  factory TailLogEntriesResponse_SuppressionInfo({
    TailLogEntriesResponse_SuppressionInfo_Reason? reason,
    $core.int? suppressedCount,
  }) {
    final _result = create();
    if (reason != null) {
      _result.reason = reason;
    }
    if (suppressedCount != null) {
      _result.suppressedCount = suppressedCount;
    }
    return _result;
  }
  factory TailLogEntriesResponse_SuppressionInfo.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TailLogEntriesResponse_SuppressionInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TailLogEntriesResponse_SuppressionInfo clone() =>
      TailLogEntriesResponse_SuppressionInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TailLogEntriesResponse_SuppressionInfo copyWith(
          void Function(TailLogEntriesResponse_SuppressionInfo) updates) =>
      super.copyWith((message) =>
              updates(message as TailLogEntriesResponse_SuppressionInfo))
          as TailLogEntriesResponse_SuppressionInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse_SuppressionInfo create() =>
      TailLogEntriesResponse_SuppressionInfo._();
  TailLogEntriesResponse_SuppressionInfo createEmptyInstance() => create();
  static $pb.PbList<TailLogEntriesResponse_SuppressionInfo> createRepeated() =>
      $pb.PbList<TailLogEntriesResponse_SuppressionInfo>();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse_SuppressionInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TailLogEntriesResponse_SuppressionInfo>(create);
  static TailLogEntriesResponse_SuppressionInfo? _defaultInstance;

  @$pb.TagNumber(1)
  TailLogEntriesResponse_SuppressionInfo_Reason get reason => $_getN(0);
  @$pb.TagNumber(1)
  set reason(TailLogEntriesResponse_SuppressionInfo_Reason v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get suppressedCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set suppressedCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSuppressedCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuppressedCount() => clearField(2);
}

class TailLogEntriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TailLogEntriesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pc<$3.LogEntry>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'entries',
        $pb.PbFieldType.PM,
        subBuilder: $3.LogEntry.create)
    ..pc<TailLogEntriesResponse_SuppressionInfo>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'suppressionInfo',
        $pb.PbFieldType.PM,
        subBuilder: TailLogEntriesResponse_SuppressionInfo.create)
    ..hasRequiredFields = false;

  TailLogEntriesResponse._() : super();
  factory TailLogEntriesResponse({
    $core.Iterable<$3.LogEntry>? entries,
    $core.Iterable<TailLogEntriesResponse_SuppressionInfo>? suppressionInfo,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (suppressionInfo != null) {
      _result.suppressionInfo.addAll(suppressionInfo);
    }
    return _result;
  }
  factory TailLogEntriesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TailLogEntriesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TailLogEntriesResponse clone() =>
      TailLogEntriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TailLogEntriesResponse copyWith(
          void Function(TailLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as TailLogEntriesResponse))
          as TailLogEntriesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse create() => TailLogEntriesResponse._();
  TailLogEntriesResponse createEmptyInstance() => create();
  static $pb.PbList<TailLogEntriesResponse> createRepeated() =>
      $pb.PbList<TailLogEntriesResponse>();
  @$core.pragma('dart2js:noInline')
  static TailLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TailLogEntriesResponse>(create);
  static TailLogEntriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.LogEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<TailLogEntriesResponse_SuppressionInfo> get suppressionInfo =>
      $_getList(1);
}
