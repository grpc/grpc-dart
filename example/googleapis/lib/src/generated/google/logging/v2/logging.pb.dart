///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.v2_logging;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import '../../api/monitored_resource.pb.dart' as $google$api;
import 'log_entry.pb.dart';
import '../../rpc/status.pb.dart' as $google$rpc;

class DeleteLogRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('DeleteLogRequest')
    ..aOS(1, 'logName')
    ..hasRequiredFields = false;

  DeleteLogRequest() : super();
  DeleteLogRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  DeleteLogRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  DeleteLogRequest clone() => DeleteLogRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteLogRequest create() => DeleteLogRequest();
  static PbList<DeleteLogRequest> createRepeated() =>
      PbList<DeleteLogRequest>();
  static DeleteLogRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyDeleteLogRequest();
    return _defaultInstance;
  }

  static DeleteLogRequest _defaultInstance;
  static void $checkItem(DeleteLogRequest v) {
    if (v is! DeleteLogRequest) checkItemFailed(v, 'DeleteLogRequest');
  }

  String get logName => $_getS(0, '');
  set logName(String v) {
    $_setString(0, v);
  }

  bool hasLogName() => $_has(0);
  void clearLogName() => clearField(1);
}

class _ReadonlyDeleteLogRequest extends DeleteLogRequest
    with ReadonlyMessageMixin {}

class WriteLogEntriesRequest_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i =
      BuilderInfo('WriteLogEntriesRequest_LabelsEntry')
        ..aOS(1, 'key')
        ..aOS(2, 'value')
        ..hasRequiredFields = false;

  WriteLogEntriesRequest_LabelsEntry() : super();
  WriteLogEntriesRequest_LabelsEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  WriteLogEntriesRequest_LabelsEntry.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  WriteLogEntriesRequest_LabelsEntry clone() =>
      WriteLogEntriesRequest_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesRequest_LabelsEntry create() =>
      WriteLogEntriesRequest_LabelsEntry();
  static PbList<WriteLogEntriesRequest_LabelsEntry> createRepeated() =>
      PbList<WriteLogEntriesRequest_LabelsEntry>();
  static WriteLogEntriesRequest_LabelsEntry getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyWriteLogEntriesRequest_LabelsEntry();
    return _defaultInstance;
  }

  static WriteLogEntriesRequest_LabelsEntry _defaultInstance;
  static void $checkItem(WriteLogEntriesRequest_LabelsEntry v) {
    if (v is! WriteLogEntriesRequest_LabelsEntry)
      checkItemFailed(v, 'WriteLogEntriesRequest_LabelsEntry');
  }

  String get key => $_getS(0, '');
  set key(String v) {
    $_setString(0, v);
  }

  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  String get value => $_getS(1, '');
  set value(String v) {
    $_setString(1, v);
  }

  bool hasValue() => $_has(1);
  void clearValue() => clearField(2);
}

class _ReadonlyWriteLogEntriesRequest_LabelsEntry
    extends WriteLogEntriesRequest_LabelsEntry with ReadonlyMessageMixin {}

class WriteLogEntriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('WriteLogEntriesRequest')
    ..aOS(1, 'logName')
    ..a<$google$api.MonitoredResource>(
        2,
        'resource',
        PbFieldType.OM,
        $google$api.MonitoredResource.getDefault,
        $google$api.MonitoredResource.create)
    ..pp<WriteLogEntriesRequest_LabelsEntry>(
        3,
        'labels',
        PbFieldType.PM,
        WriteLogEntriesRequest_LabelsEntry.$checkItem,
        WriteLogEntriesRequest_LabelsEntry.create)
    ..pp<LogEntry>(
        4, 'entries', PbFieldType.PM, LogEntry.$checkItem, LogEntry.create)
    ..aOB(5, 'partialSuccess')
    ..hasRequiredFields = false;

  WriteLogEntriesRequest() : super();
  WriteLogEntriesRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  WriteLogEntriesRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  WriteLogEntriesRequest clone() =>
      WriteLogEntriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesRequest create() => WriteLogEntriesRequest();
  static PbList<WriteLogEntriesRequest> createRepeated() =>
      PbList<WriteLogEntriesRequest>();
  static WriteLogEntriesRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyWriteLogEntriesRequest();
    return _defaultInstance;
  }

  static WriteLogEntriesRequest _defaultInstance;
  static void $checkItem(WriteLogEntriesRequest v) {
    if (v is! WriteLogEntriesRequest)
      checkItemFailed(v, 'WriteLogEntriesRequest');
  }

  String get logName => $_getS(0, '');
  set logName(String v) {
    $_setString(0, v);
  }

  bool hasLogName() => $_has(0);
  void clearLogName() => clearField(1);

  $google$api.MonitoredResource get resource => $_getN(1);
  set resource($google$api.MonitoredResource v) {
    setField(2, v);
  }

  bool hasResource() => $_has(1);
  void clearResource() => clearField(2);

  List<WriteLogEntriesRequest_LabelsEntry> get labels => $_getList(2);

  List<LogEntry> get entries => $_getList(3);

  bool get partialSuccess => $_get(4, false);
  set partialSuccess(bool v) {
    $_setBool(4, v);
  }

  bool hasPartialSuccess() => $_has(4);
  void clearPartialSuccess() => clearField(5);
}

class _ReadonlyWriteLogEntriesRequest extends WriteLogEntriesRequest
    with ReadonlyMessageMixin {}

class WriteLogEntriesResponse extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('WriteLogEntriesResponse')
    ..hasRequiredFields = false;

  WriteLogEntriesResponse() : super();
  WriteLogEntriesResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  WriteLogEntriesResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  WriteLogEntriesResponse clone() =>
      WriteLogEntriesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesResponse create() => WriteLogEntriesResponse();
  static PbList<WriteLogEntriesResponse> createRepeated() =>
      PbList<WriteLogEntriesResponse>();
  static WriteLogEntriesResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyWriteLogEntriesResponse();
    return _defaultInstance;
  }

  static WriteLogEntriesResponse _defaultInstance;
  static void $checkItem(WriteLogEntriesResponse v) {
    if (v is! WriteLogEntriesResponse)
      checkItemFailed(v, 'WriteLogEntriesResponse');
  }
}

class _ReadonlyWriteLogEntriesResponse extends WriteLogEntriesResponse
    with ReadonlyMessageMixin {}

class WriteLogEntriesPartialErrors_LogEntryErrorsEntry
    extends GeneratedMessage {
  static final BuilderInfo _i =
      BuilderInfo('WriteLogEntriesPartialErrors_LogEntryErrorsEntry')
        ..a<int>(1, 'key', PbFieldType.O3)
        ..a<$google$rpc.Status>(2, 'value', PbFieldType.OM,
            $google$rpc.Status.getDefault, $google$rpc.Status.create)
        ..hasRequiredFields = false;

  WriteLogEntriesPartialErrors_LogEntryErrorsEntry() : super();
  WriteLogEntriesPartialErrors_LogEntryErrorsEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  WriteLogEntriesPartialErrors_LogEntryErrorsEntry.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  WriteLogEntriesPartialErrors_LogEntryErrorsEntry clone() =>
      WriteLogEntriesPartialErrors_LogEntryErrorsEntry()
        ..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesPartialErrors_LogEntryErrorsEntry create() =>
      WriteLogEntriesPartialErrors_LogEntryErrorsEntry();
  static PbList<WriteLogEntriesPartialErrors_LogEntryErrorsEntry>
      createRepeated() =>
          PbList<WriteLogEntriesPartialErrors_LogEntryErrorsEntry>();
  static WriteLogEntriesPartialErrors_LogEntryErrorsEntry getDefault() {
    if (_defaultInstance == null)
      _defaultInstance =
          _ReadonlyWriteLogEntriesPartialErrors_LogEntryErrorsEntry();
    return _defaultInstance;
  }

  static WriteLogEntriesPartialErrors_LogEntryErrorsEntry _defaultInstance;
  static void $checkItem(WriteLogEntriesPartialErrors_LogEntryErrorsEntry v) {
    if (v is! WriteLogEntriesPartialErrors_LogEntryErrorsEntry)
      checkItemFailed(v, 'WriteLogEntriesPartialErrors_LogEntryErrorsEntry');
  }

  int get key => $_get(0, 0);
  set key(int v) {
    $_setUnsignedInt32(0, v);
  }

  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  $google$rpc.Status get value => $_getN(1);
  set value($google$rpc.Status v) {
    setField(2, v);
  }

  bool hasValue() => $_has(1);
  void clearValue() => clearField(2);
}

class _ReadonlyWriteLogEntriesPartialErrors_LogEntryErrorsEntry
    extends WriteLogEntriesPartialErrors_LogEntryErrorsEntry
    with ReadonlyMessageMixin {}

class WriteLogEntriesPartialErrors extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('WriteLogEntriesPartialErrors')
    ..pp<WriteLogEntriesPartialErrors_LogEntryErrorsEntry>(
        1,
        'logEntryErrors',
        PbFieldType.PM,
        WriteLogEntriesPartialErrors_LogEntryErrorsEntry.$checkItem,
        WriteLogEntriesPartialErrors_LogEntryErrorsEntry.create)
    ..hasRequiredFields = false;

  WriteLogEntriesPartialErrors() : super();
  WriteLogEntriesPartialErrors.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  WriteLogEntriesPartialErrors.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  WriteLogEntriesPartialErrors clone() =>
      WriteLogEntriesPartialErrors()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesPartialErrors create() =>
      WriteLogEntriesPartialErrors();
  static PbList<WriteLogEntriesPartialErrors> createRepeated() =>
      PbList<WriteLogEntriesPartialErrors>();
  static WriteLogEntriesPartialErrors getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyWriteLogEntriesPartialErrors();
    return _defaultInstance;
  }

  static WriteLogEntriesPartialErrors _defaultInstance;
  static void $checkItem(WriteLogEntriesPartialErrors v) {
    if (v is! WriteLogEntriesPartialErrors)
      checkItemFailed(v, 'WriteLogEntriesPartialErrors');
  }

  List<WriteLogEntriesPartialErrors_LogEntryErrorsEntry> get logEntryErrors =>
      $_getList(0);
}

class _ReadonlyWriteLogEntriesPartialErrors extends WriteLogEntriesPartialErrors
    with ReadonlyMessageMixin {}

class ListLogEntriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ListLogEntriesRequest')
    ..pPS(1, 'projectIds')
    ..aOS(2, 'filter')
    ..aOS(3, 'orderBy')
    ..a<int>(4, 'pageSize', PbFieldType.O3)
    ..aOS(5, 'pageToken')
    ..pPS(8, 'resourceNames')
    ..hasRequiredFields = false;

  ListLogEntriesRequest() : super();
  ListLogEntriesRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListLogEntriesRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListLogEntriesRequest clone() =>
      ListLogEntriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogEntriesRequest create() => ListLogEntriesRequest();
  static PbList<ListLogEntriesRequest> createRepeated() =>
      PbList<ListLogEntriesRequest>();
  static ListLogEntriesRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyListLogEntriesRequest();
    return _defaultInstance;
  }

  static ListLogEntriesRequest _defaultInstance;
  static void $checkItem(ListLogEntriesRequest v) {
    if (v is! ListLogEntriesRequest)
      checkItemFailed(v, 'ListLogEntriesRequest');
  }

  List<String> get projectIds => $_getList(0);

  String get filter => $_getS(1, '');
  set filter(String v) {
    $_setString(1, v);
  }

  bool hasFilter() => $_has(1);
  void clearFilter() => clearField(2);

  String get orderBy => $_getS(2, '');
  set orderBy(String v) {
    $_setString(2, v);
  }

  bool hasOrderBy() => $_has(2);
  void clearOrderBy() => clearField(3);

  int get pageSize => $_get(3, 0);
  set pageSize(int v) {
    $_setUnsignedInt32(3, v);
  }

  bool hasPageSize() => $_has(3);
  void clearPageSize() => clearField(4);

  String get pageToken => $_getS(4, '');
  set pageToken(String v) {
    $_setString(4, v);
  }

  bool hasPageToken() => $_has(4);
  void clearPageToken() => clearField(5);

  List<String> get resourceNames => $_getList(5);
}

class _ReadonlyListLogEntriesRequest extends ListLogEntriesRequest
    with ReadonlyMessageMixin {}

class ListLogEntriesResponse extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ListLogEntriesResponse')
    ..pp<LogEntry>(
        1, 'entries', PbFieldType.PM, LogEntry.$checkItem, LogEntry.create)
    ..aOS(2, 'nextPageToken')
    ..hasRequiredFields = false;

  ListLogEntriesResponse() : super();
  ListLogEntriesResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListLogEntriesResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListLogEntriesResponse clone() =>
      ListLogEntriesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogEntriesResponse create() => ListLogEntriesResponse();
  static PbList<ListLogEntriesResponse> createRepeated() =>
      PbList<ListLogEntriesResponse>();
  static ListLogEntriesResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyListLogEntriesResponse();
    return _defaultInstance;
  }

  static ListLogEntriesResponse _defaultInstance;
  static void $checkItem(ListLogEntriesResponse v) {
    if (v is! ListLogEntriesResponse)
      checkItemFailed(v, 'ListLogEntriesResponse');
  }

  List<LogEntry> get entries => $_getList(0);

  String get nextPageToken => $_getS(1, '');
  set nextPageToken(String v) {
    $_setString(1, v);
  }

  bool hasNextPageToken() => $_has(1);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListLogEntriesResponse extends ListLogEntriesResponse
    with ReadonlyMessageMixin {}

class ListMonitoredResourceDescriptorsRequest extends GeneratedMessage {
  static final BuilderInfo _i =
      BuilderInfo('ListMonitoredResourceDescriptorsRequest')
        ..a<int>(1, 'pageSize', PbFieldType.O3)
        ..aOS(2, 'pageToken')
        ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsRequest() : super();
  ListMonitoredResourceDescriptorsRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListMonitoredResourceDescriptorsRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListMonitoredResourceDescriptorsRequest clone() =>
      ListMonitoredResourceDescriptorsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMonitoredResourceDescriptorsRequest create() =>
      ListMonitoredResourceDescriptorsRequest();
  static PbList<ListMonitoredResourceDescriptorsRequest> createRepeated() =>
      PbList<ListMonitoredResourceDescriptorsRequest>();
  static ListMonitoredResourceDescriptorsRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyListMonitoredResourceDescriptorsRequest();
    return _defaultInstance;
  }

  static ListMonitoredResourceDescriptorsRequest _defaultInstance;
  static void $checkItem(ListMonitoredResourceDescriptorsRequest v) {
    if (v is! ListMonitoredResourceDescriptorsRequest)
      checkItemFailed(v, 'ListMonitoredResourceDescriptorsRequest');
  }

  int get pageSize => $_get(0, 0);
  set pageSize(int v) {
    $_setUnsignedInt32(0, v);
  }

  bool hasPageSize() => $_has(0);
  void clearPageSize() => clearField(1);

  String get pageToken => $_getS(1, '');
  set pageToken(String v) {
    $_setString(1, v);
  }

  bool hasPageToken() => $_has(1);
  void clearPageToken() => clearField(2);
}

class _ReadonlyListMonitoredResourceDescriptorsRequest
    extends ListMonitoredResourceDescriptorsRequest with ReadonlyMessageMixin {}

class ListMonitoredResourceDescriptorsResponse extends GeneratedMessage {
  static final BuilderInfo _i =
      BuilderInfo('ListMonitoredResourceDescriptorsResponse')
        ..pp<$google$api.MonitoredResourceDescriptor>(
            1,
            'resourceDescriptors',
            PbFieldType.PM,
            $google$api.MonitoredResourceDescriptor.$checkItem,
            $google$api.MonitoredResourceDescriptor.create)
        ..aOS(2, 'nextPageToken')
        ..hasRequiredFields = false;

  ListMonitoredResourceDescriptorsResponse() : super();
  ListMonitoredResourceDescriptorsResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListMonitoredResourceDescriptorsResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListMonitoredResourceDescriptorsResponse clone() =>
      ListMonitoredResourceDescriptorsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMonitoredResourceDescriptorsResponse create() =>
      ListMonitoredResourceDescriptorsResponse();
  static PbList<ListMonitoredResourceDescriptorsResponse> createRepeated() =>
      PbList<ListMonitoredResourceDescriptorsResponse>();
  static ListMonitoredResourceDescriptorsResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyListMonitoredResourceDescriptorsResponse();
    return _defaultInstance;
  }

  static ListMonitoredResourceDescriptorsResponse _defaultInstance;
  static void $checkItem(ListMonitoredResourceDescriptorsResponse v) {
    if (v is! ListMonitoredResourceDescriptorsResponse)
      checkItemFailed(v, 'ListMonitoredResourceDescriptorsResponse');
  }

  List<$google$api.MonitoredResourceDescriptor> get resourceDescriptors =>
      $_getList(0);

  String get nextPageToken => $_getS(1, '');
  set nextPageToken(String v) {
    $_setString(1, v);
  }

  bool hasNextPageToken() => $_has(1);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListMonitoredResourceDescriptorsResponse
    extends ListMonitoredResourceDescriptorsResponse with ReadonlyMessageMixin {
}

class ListLogsRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ListLogsRequest')
    ..aOS(1, 'parent')
    ..a<int>(2, 'pageSize', PbFieldType.O3)
    ..aOS(3, 'pageToken')
    ..hasRequiredFields = false;

  ListLogsRequest() : super();
  ListLogsRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListLogsRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListLogsRequest clone() => ListLogsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogsRequest create() => ListLogsRequest();
  static PbList<ListLogsRequest> createRepeated() => PbList<ListLogsRequest>();
  static ListLogsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = _ReadonlyListLogsRequest();
    return _defaultInstance;
  }

  static ListLogsRequest _defaultInstance;
  static void $checkItem(ListLogsRequest v) {
    if (v is! ListLogsRequest) checkItemFailed(v, 'ListLogsRequest');
  }

  String get parent => $_getS(0, '');
  set parent(String v) {
    $_setString(0, v);
  }

  bool hasParent() => $_has(0);
  void clearParent() => clearField(1);

  int get pageSize => $_get(1, 0);
  set pageSize(int v) {
    $_setUnsignedInt32(1, v);
  }

  bool hasPageSize() => $_has(1);
  void clearPageSize() => clearField(2);

  String get pageToken => $_getS(2, '');
  set pageToken(String v) {
    $_setString(2, v);
  }

  bool hasPageToken() => $_has(2);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListLogsRequest extends ListLogsRequest
    with ReadonlyMessageMixin {}

class ListLogsResponse extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('ListLogsResponse')
    ..aOS(2, 'nextPageToken')
    ..pPS(3, 'logNames')
    ..hasRequiredFields = false;

  ListLogsResponse() : super();
  ListLogsResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListLogsResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListLogsResponse clone() => ListLogsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogsResponse create() => ListLogsResponse();
  static PbList<ListLogsResponse> createRepeated() =>
      PbList<ListLogsResponse>();
  static ListLogsResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyListLogsResponse();
    return _defaultInstance;
  }

  static ListLogsResponse _defaultInstance;
  static void $checkItem(ListLogsResponse v) {
    if (v is! ListLogsResponse) checkItemFailed(v, 'ListLogsResponse');
  }

  String get nextPageToken => $_getS(0, '');
  set nextPageToken(String v) {
    $_setString(0, v);
  }

  bool hasNextPageToken() => $_has(0);
  void clearNextPageToken() => clearField(2);

  List<String> get logNames => $_getList(1);
}

class _ReadonlyListLogsResponse extends ListLogsResponse
    with ReadonlyMessageMixin {}
