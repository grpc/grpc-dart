///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/monitored_resource.pb.dart' as $2;
import 'log_entry.pb.dart' as $3;
import '../../rpc/status.pb.dart' as $4;

class DeleteLogRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeleteLogRequest',
      package: const $pb.PackageName('google.logging.v2'))
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
  static DeleteLogRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static DeleteLogRequest _defaultInstance;

  $core.String get logName => $_getS(0, '');
  set logName($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasLogName() => $_has(0);
  void clearLogName() => clearField(1);
}

class WriteLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WriteLogEntriesRequest',
      package: const $pb.PackageName('google.logging.v2'))
    ..aOS(1, 'logName')
    ..a<$2.MonitoredResource>(2, 'resource', $pb.PbFieldType.OM,
        $2.MonitoredResource.getDefault, $2.MonitoredResource.create)
    ..m<$core.String, $core.String>(
        3,
        'labels',
        'WriteLogEntriesRequest.LabelsEntry',
        $pb.PbFieldType.OS,
        $pb.PbFieldType.OS,
        null,
        null,
        null,
        const $pb.PackageName('google.logging.v2'))
    ..pc<$3.LogEntry>(4, 'entries', $pb.PbFieldType.PM, $3.LogEntry.create)
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
  static WriteLogEntriesRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static WriteLogEntriesRequest _defaultInstance;

  $core.String get logName => $_getS(0, '');
  set logName($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasLogName() => $_has(0);
  void clearLogName() => clearField(1);

  $2.MonitoredResource get resource => $_getN(1);
  set resource($2.MonitoredResource v) {
    setField(2, v);
  }

  $core.bool hasResource() => $_has(1);
  void clearResource() => clearField(2);

  $core.Map<$core.String, $core.String> get labels => $_getMap(2);

  $core.List<$3.LogEntry> get entries => $_getList(3);

  $core.bool get partialSuccess => $_get(4, false);
  set partialSuccess($core.bool v) {
    $_setBool(4, v);
  }

  $core.bool hasPartialSuccess() => $_has(4);
  void clearPartialSuccess() => clearField(5);

  $core.bool get dryRun => $_get(5, false);
  set dryRun($core.bool v) {
    $_setBool(5, v);
  }

  $core.bool hasDryRun() => $_has(5);
  void clearDryRun() => clearField(6);
}

class WriteLogEntriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WriteLogEntriesResponse',
      package: const $pb.PackageName('google.logging.v2'))
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
  static WriteLogEntriesResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static WriteLogEntriesResponse _defaultInstance;
}

class WriteLogEntriesPartialErrors extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'WriteLogEntriesPartialErrors',
      package: const $pb.PackageName('google.logging.v2'))
    ..m<$core.int, $4.Status>(
        1,
        'logEntryErrors',
        'WriteLogEntriesPartialErrors.LogEntryErrorsEntry',
        $pb.PbFieldType.O3,
        $pb.PbFieldType.OM,
        $4.Status.create,
        null,
        null,
        const $pb.PackageName('google.logging.v2'))
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
  static WriteLogEntriesPartialErrors getDefault() =>
      _defaultInstance ??= create()..freeze();
  static WriteLogEntriesPartialErrors _defaultInstance;

  $core.Map<$core.int, $4.Status> get logEntryErrors => $_getMap(0);
}

class ListLogEntriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogEntriesRequest',
      package: const $pb.PackageName('google.logging.v2'))
    ..pPS(1, 'projectIds')
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
  static ListLogEntriesRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListLogEntriesRequest _defaultInstance;

  @$core.Deprecated('This field is deprecated.')
  $core.List<$core.String> get projectIds => $_getList(0);

  $core.String get filter => $_getS(1, '');
  set filter($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasFilter() => $_has(1);
  void clearFilter() => clearField(2);

  $core.String get orderBy => $_getS(2, '');
  set orderBy($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasOrderBy() => $_has(2);
  void clearOrderBy() => clearField(3);

  $core.int get pageSize => $_get(3, 0);
  set pageSize($core.int v) {
    $_setSignedInt32(3, v);
  }

  $core.bool hasPageSize() => $_has(3);
  void clearPageSize() => clearField(4);

  $core.String get pageToken => $_getS(4, '');
  set pageToken($core.String v) {
    $_setString(4, v);
  }

  $core.bool hasPageToken() => $_has(4);
  void clearPageToken() => clearField(5);

  $core.List<$core.String> get resourceNames => $_getList(5);
}

class ListLogEntriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogEntriesResponse',
      package: const $pb.PackageName('google.logging.v2'))
    ..pc<$3.LogEntry>(1, 'entries', $pb.PbFieldType.PM, $3.LogEntry.create)
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
  static ListLogEntriesResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListLogEntriesResponse _defaultInstance;

  $core.List<$3.LogEntry> get entries => $_getList(0);

  $core.String get nextPageToken => $_getS(1, '');
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasNextPageToken() => $_has(1);
  void clearNextPageToken() => clearField(2);
}

class ListMonitoredResourceDescriptorsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'ListMonitoredResourceDescriptorsRequest',
      package: const $pb.PackageName('google.logging.v2'))
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
  static ListMonitoredResourceDescriptorsRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListMonitoredResourceDescriptorsRequest _defaultInstance;

  $core.int get pageSize => $_get(0, 0);
  set pageSize($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasPageSize() => $_has(0);
  void clearPageSize() => clearField(1);

  $core.String get pageToken => $_getS(1, '');
  set pageToken($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasPageToken() => $_has(1);
  void clearPageToken() => clearField(2);
}

class ListMonitoredResourceDescriptorsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'ListMonitoredResourceDescriptorsResponse',
      package: const $pb.PackageName('google.logging.v2'))
    ..pc<$2.MonitoredResourceDescriptor>(1, 'resourceDescriptors',
        $pb.PbFieldType.PM, $2.MonitoredResourceDescriptor.create)
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
  static ListMonitoredResourceDescriptorsResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListMonitoredResourceDescriptorsResponse _defaultInstance;

  $core.List<$2.MonitoredResourceDescriptor> get resourceDescriptors =>
      $_getList(0);

  $core.String get nextPageToken => $_getS(1, '');
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasNextPageToken() => $_has(1);
  void clearNextPageToken() => clearField(2);
}

class ListLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogsRequest',
      package: const $pb.PackageName('google.logging.v2'))
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
  static ListLogsRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListLogsRequest _defaultInstance;

  $core.String get parent => $_getS(0, '');
  set parent($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasParent() => $_has(0);
  void clearParent() => clearField(1);

  $core.int get pageSize => $_get(1, 0);
  set pageSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasPageSize() => $_has(1);
  void clearPageSize() => clearField(2);

  $core.String get pageToken => $_getS(2, '');
  set pageToken($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasPageToken() => $_has(2);
  void clearPageToken() => clearField(3);
}

class ListLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListLogsResponse',
      package: const $pb.PackageName('google.logging.v2'))
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
  static ListLogsResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ListLogsResponse _defaultInstance;

  $core.String get nextPageToken => $_getS(0, '');
  set nextPageToken($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasNextPageToken() => $_has(0);
  void clearNextPageToken() => clearField(2);

  $core.List<$core.String> get logNames => $_getList(1);
}
