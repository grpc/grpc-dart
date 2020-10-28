///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/monitored_resource.pb.dart' as $3;
import 'log_entry.pb.dart' as $4;
import '../../rpc/status.pb.dart' as $5;

class DeleteLogRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeleteLogRequest',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, 'logName')
    ..hasRequiredFields = false;

  DeleteLogRequest._() : super();
  factory DeleteLogRequest() => create();
  factory DeleteLogRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteLogRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DeleteLogRequest clone() => DeleteLogRequest()..mergeFromMessage(this);
  DeleteLogRequest copyWith(void Function(DeleteLogRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteLogRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest create() => DeleteLogRequest._();
  DeleteLogRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteLogRequest> createRepeated() =>
      $pb.PbList<DeleteLogRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteLogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLogRequest>(create);
  static DeleteLogRequest _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WriteLogEntriesRequest',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, 'logName')
    ..aOM<$3.MonitoredResource>(2, 'resource',
        subBuilder: $3.MonitoredResource.create)
    ..m<$core.String, $core.String>(3, 'labels',
        entryClassName: 'WriteLogEntriesRequest.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..pc<$4.LogEntry>(4, 'entries', $pb.PbFieldType.PM,
        subBuilder: $4.LogEntry.create)
    ..aOB(5, 'partialSuccess')
    ..aOB(6, 'dryRun')
    ..hasRequiredFields = false;

  WriteLogEntriesRequest._() : super();
  factory WriteLogEntriesRequest() => create();
  factory WriteLogEntriesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WriteLogEntriesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  WriteLogEntriesRequest clone() =>
      WriteLogEntriesRequest()..mergeFromMessage(this);
  WriteLogEntriesRequest copyWith(
          void Function(WriteLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest create() => WriteLogEntriesRequest._();
  WriteLogEntriesRequest createEmptyInstance() => create();
  static $pb.PbList<WriteLogEntriesRequest> createRepeated() =>
      $pb.PbList<WriteLogEntriesRequest>();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesRequest>(create);
  static WriteLogEntriesRequest _defaultInstance;

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
  $3.MonitoredResource get resource => $_getN(1);
  @$pb.TagNumber(2)
  set resource($3.MonitoredResource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResource() => $_has(1);
  @$pb.TagNumber(2)
  void clearResource() => clearField(2);
  @$pb.TagNumber(2)
  $3.MonitoredResource ensureResource() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get labels => $_getMap(2);

  @$pb.TagNumber(4)
  $core.List<$4.LogEntry> get entries => $_getList(3);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WriteLogEntriesResponse',
      package: const $pb.PackageName('google.logging.v2'),
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
  WriteLogEntriesResponse clone() =>
      WriteLogEntriesResponse()..mergeFromMessage(this);
  WriteLogEntriesResponse copyWith(
          void Function(WriteLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as WriteLogEntriesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse create() => WriteLogEntriesResponse._();
  WriteLogEntriesResponse createEmptyInstance() => create();
  static $pb.PbList<WriteLogEntriesResponse> createRepeated() =>
      $pb.PbList<WriteLogEntriesResponse>();
  @$core.pragma('dart2js:noInline')
  static WriteLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WriteLogEntriesResponse>(create);
  static WriteLogEntriesResponse _defaultInstance;
}

class WriteLogEntriesPartialErrors extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'WriteLogEntriesPartialErrors',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..m<$core.int, $5.Status>(1, 'logEntryErrors',
        entryClassName: 'WriteLogEntriesPartialErrors.LogEntryErrorsEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $5.Status.create,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..hasRequiredFields = false;

  WriteLogEntriesPartialErrors._() : super();
  factory WriteLogEntriesPartialErrors() => create();
  factory WriteLogEntriesPartialErrors.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WriteLogEntriesPartialErrors.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  WriteLogEntriesPartialErrors clone() =>
      WriteLogEntriesPartialErrors()..mergeFromMessage(this);
  WriteLogEntriesPartialErrors copyWith(
          void Function(WriteLogEntriesPartialErrors) updates) =>
      super.copyWith(
          (message) => updates(message as WriteLogEntriesPartialErrors));
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
  static WriteLogEntriesPartialErrors _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, $5.Status> get logEntryErrors => $_getMap(0);
}

class ListLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogEntriesRequest',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(2, 'filter')
    ..aOS(3, 'orderBy')
    ..a<$core.int>(4, 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, 'pageToken')
    ..pPS(8, 'resourceNames')
    ..hasRequiredFields = false;

  ListLogEntriesRequest._() : super();
  factory ListLogEntriesRequest() => create();
  factory ListLogEntriesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogEntriesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListLogEntriesRequest clone() =>
      ListLogEntriesRequest()..mergeFromMessage(this);
  ListLogEntriesRequest copyWith(
          void Function(ListLogEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest create() => ListLogEntriesRequest._();
  ListLogEntriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListLogEntriesRequest> createRepeated() =>
      $pb.PbList<ListLogEntriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesRequest>(create);
  static ListLogEntriesRequest _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogEntriesResponse',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..pc<$4.LogEntry>(1, 'entries', $pb.PbFieldType.PM,
        subBuilder: $4.LogEntry.create)
    ..aOS(2, 'nextPageToken')
    ..hasRequiredFields = false;

  ListLogEntriesResponse._() : super();
  factory ListLogEntriesResponse() => create();
  factory ListLogEntriesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogEntriesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListLogEntriesResponse clone() =>
      ListLogEntriesResponse()..mergeFromMessage(this);
  ListLogEntriesResponse copyWith(
          void Function(ListLogEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogEntriesResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse create() => ListLogEntriesResponse._();
  ListLogEntriesResponse createEmptyInstance() => create();
  static $pb.PbList<ListLogEntriesResponse> createRepeated() =>
      $pb.PbList<ListLogEntriesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListLogEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogEntriesResponse>(create);
  static ListLogEntriesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$4.LogEntry> get entries => $_getList(0);

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
      'ListMonitoredResourceDescriptorsRequest',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, 'pageSize', $pb.PbFieldType.O3)
    ..aOS(2, 'pageToken')
    ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsRequest._() : super();
  factory ListMonitoredResourceDescriptorsRequest() => create();
  factory ListMonitoredResourceDescriptorsRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListMonitoredResourceDescriptorsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListMonitoredResourceDescriptorsRequest clone() =>
      ListMonitoredResourceDescriptorsRequest()..mergeFromMessage(this);
  ListMonitoredResourceDescriptorsRequest copyWith(
          void Function(ListMonitoredResourceDescriptorsRequest) updates) =>
      super.copyWith((message) =>
          updates(message as ListMonitoredResourceDescriptorsRequest));
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
  static ListMonitoredResourceDescriptorsRequest _defaultInstance;

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
      'ListMonitoredResourceDescriptorsResponse',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..pc<$3.MonitoredResourceDescriptor>(
        1, 'resourceDescriptors', $pb.PbFieldType.PM,
        subBuilder: $3.MonitoredResourceDescriptor.create)
    ..aOS(2, 'nextPageToken')
    ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsResponse._() : super();
  factory ListMonitoredResourceDescriptorsResponse() => create();
  factory ListMonitoredResourceDescriptorsResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListMonitoredResourceDescriptorsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListMonitoredResourceDescriptorsResponse clone() =>
      ListMonitoredResourceDescriptorsResponse()..mergeFromMessage(this);
  ListMonitoredResourceDescriptorsResponse copyWith(
          void Function(ListMonitoredResourceDescriptorsResponse) updates) =>
      super.copyWith((message) =>
          updates(message as ListMonitoredResourceDescriptorsResponse));
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
  static ListMonitoredResourceDescriptorsResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.MonitoredResourceDescriptor> get resourceDescriptors =>
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogsRequest',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, 'parent')
    ..a<$core.int>(2, 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, 'pageToken')
    ..hasRequiredFields = false;

  ListLogsRequest._() : super();
  factory ListLogsRequest() => create();
  factory ListLogsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListLogsRequest clone() => ListLogsRequest()..mergeFromMessage(this);
  ListLogsRequest copyWith(void Function(ListLogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogsRequest create() => ListLogsRequest._();
  ListLogsRequest createEmptyInstance() => create();
  static $pb.PbList<ListLogsRequest> createRepeated() =>
      $pb.PbList<ListLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsRequest>(create);
  static ListLogsRequest _defaultInstance;

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
}

class ListLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogsResponse',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(2, 'nextPageToken')
    ..pPS(3, 'logNames')
    ..hasRequiredFields = false;

  ListLogsResponse._() : super();
  factory ListLogsResponse() => create();
  factory ListLogsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListLogsResponse clone() => ListLogsResponse()..mergeFromMessage(this);
  ListLogsResponse copyWith(void Function(ListLogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogsResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLogsResponse create() => ListLogsResponse._();
  ListLogsResponse createEmptyInstance() => create();
  static $pb.PbList<ListLogsResponse> createRepeated() =>
      $pb.PbList<ListLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListLogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogsResponse>(create);
  static ListLogsResponse _defaultInstance;

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
