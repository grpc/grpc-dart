///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.v2_log_entry;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/any.pb.dart' as $google$protobuf;
import '../../protobuf/struct.pb.dart' as $google$protobuf;
import '../type/http_request.pb.dart' as $google$logging$type;
import '../../api/monitored_resource.pb.dart' as $google$api;
import '../../protobuf/timestamp.pb.dart' as $google$protobuf;

import '../type/log_severity.pbenum.dart' as $google$logging$type;

class LogEntry_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('LogEntry_LabelsEntry')
    ..aOS(1, 'key')
    ..aOS(2, 'value')
    ..hasRequiredFields = false;

  LogEntry_LabelsEntry() : super();
  LogEntry_LabelsEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  LogEntry_LabelsEntry.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  LogEntry_LabelsEntry clone() =>
      LogEntry_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntry_LabelsEntry create() => LogEntry_LabelsEntry();
  static PbList<LogEntry_LabelsEntry> createRepeated() =>
      PbList<LogEntry_LabelsEntry>();
  static LogEntry_LabelsEntry getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyLogEntry_LabelsEntry();
    return _defaultInstance;
  }

  static LogEntry_LabelsEntry _defaultInstance;
  static void $checkItem(LogEntry_LabelsEntry v) {
    if (v is! LogEntry_LabelsEntry) checkItemFailed(v, 'LogEntry_LabelsEntry');
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

class _ReadonlyLogEntry_LabelsEntry extends LogEntry_LabelsEntry
    with ReadonlyMessageMixin {}

class LogEntry extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('LogEntry')
    ..a<$google$protobuf.Any>(2, 'protoPayload', PbFieldType.OM,
        $google$protobuf.Any.getDefault, $google$protobuf.Any.create)
    ..aOS(3, 'textPayload')
    ..aOS(4, 'insertId')
    ..a<$google$protobuf.Struct>(6, 'jsonPayload', PbFieldType.OM,
        $google$protobuf.Struct.getDefault, $google$protobuf.Struct.create)
    ..a<$google$logging$type.HttpRequest>(
        7,
        'httpRequest',
        PbFieldType.OM,
        $google$logging$type.HttpRequest.getDefault,
        $google$logging$type.HttpRequest.create)
    ..a<$google$api.MonitoredResource>(
        8,
        'resource',
        PbFieldType.OM,
        $google$api.MonitoredResource.getDefault,
        $google$api.MonitoredResource.create)
    ..a<$google$protobuf.Timestamp>(
        9,
        'timestamp',
        PbFieldType.OM,
        $google$protobuf.Timestamp.getDefault,
        $google$protobuf.Timestamp.create)
    ..e<$google$logging$type.LogSeverity>(
        10,
        'severity',
        PbFieldType.OE,
        $google$logging$type.LogSeverity.DEFAULT,
        $google$logging$type.LogSeverity.valueOf,
        $google$logging$type.LogSeverity.values)
    ..pp<LogEntry_LabelsEntry>(11, 'labels', PbFieldType.PM,
        LogEntry_LabelsEntry.$checkItem, LogEntry_LabelsEntry.create)
    ..aOS(12, 'logName')
    ..a<LogEntryOperation>(15, 'operation', PbFieldType.OM,
        LogEntryOperation.getDefault, LogEntryOperation.create)
    ..aOS(22, 'trace')
    ..a<LogEntrySourceLocation>(23, 'sourceLocation', PbFieldType.OM,
        LogEntrySourceLocation.getDefault, LogEntrySourceLocation.create)
    ..a<$google$protobuf.Timestamp>(
        24,
        'receiveTimestamp',
        PbFieldType.OM,
        $google$protobuf.Timestamp.getDefault,
        $google$protobuf.Timestamp.create)
    ..aOS(27, 'spanId')
    ..hasRequiredFields = false;

  LogEntry() : super();
  LogEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  LogEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  LogEntry clone() => LogEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntry create() => LogEntry();
  static PbList<LogEntry> createRepeated() => PbList<LogEntry>();
  static LogEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = _ReadonlyLogEntry();
    return _defaultInstance;
  }

  static LogEntry _defaultInstance;
  static void $checkItem(LogEntry v) {
    if (v is! LogEntry) checkItemFailed(v, 'LogEntry');
  }

  $google$protobuf.Any get protoPayload => $_getN(0);
  set protoPayload($google$protobuf.Any v) {
    setField(2, v);
  }

  bool hasProtoPayload() => $_has(0);
  void clearProtoPayload() => clearField(2);

  String get textPayload => $_getS(1, '');
  set textPayload(String v) {
    $_setString(1, v);
  }

  bool hasTextPayload() => $_has(1);
  void clearTextPayload() => clearField(3);

  String get insertId => $_getS(2, '');
  set insertId(String v) {
    $_setString(2, v);
  }

  bool hasInsertId() => $_has(2);
  void clearInsertId() => clearField(4);

  $google$protobuf.Struct get jsonPayload => $_getN(3);
  set jsonPayload($google$protobuf.Struct v) {
    setField(6, v);
  }

  bool hasJsonPayload() => $_has(3);
  void clearJsonPayload() => clearField(6);

  $google$logging$type.HttpRequest get httpRequest => $_getN(4);
  set httpRequest($google$logging$type.HttpRequest v) {
    setField(7, v);
  }

  bool hasHttpRequest() => $_has(4);
  void clearHttpRequest() => clearField(7);

  $google$api.MonitoredResource get resource => $_getN(5);
  set resource($google$api.MonitoredResource v) {
    setField(8, v);
  }

  bool hasResource() => $_has(5);
  void clearResource() => clearField(8);

  $google$protobuf.Timestamp get timestamp => $_getN(6);
  set timestamp($google$protobuf.Timestamp v) {
    setField(9, v);
  }

  bool hasTimestamp() => $_has(6);
  void clearTimestamp() => clearField(9);

  $google$logging$type.LogSeverity get severity => $_getN(7);
  set severity($google$logging$type.LogSeverity v) {
    setField(10, v);
  }

  bool hasSeverity() => $_has(7);
  void clearSeverity() => clearField(10);

  List<LogEntry_LabelsEntry> get labels => $_getList(8);

  String get logName => $_getS(9, '');
  set logName(String v) {
    $_setString(9, v);
  }

  bool hasLogName() => $_has(9);
  void clearLogName() => clearField(12);

  LogEntryOperation get operation => $_getN(10);
  set operation(LogEntryOperation v) {
    setField(15, v);
  }

  bool hasOperation() => $_has(10);
  void clearOperation() => clearField(15);

  String get trace => $_getS(11, '');
  set trace(String v) {
    $_setString(11, v);
  }

  bool hasTrace() => $_has(11);
  void clearTrace() => clearField(22);

  LogEntrySourceLocation get sourceLocation => $_getN(12);
  set sourceLocation(LogEntrySourceLocation v) {
    setField(23, v);
  }

  bool hasSourceLocation() => $_has(12);
  void clearSourceLocation() => clearField(23);

  $google$protobuf.Timestamp get receiveTimestamp => $_getN(13);
  set receiveTimestamp($google$protobuf.Timestamp v) {
    setField(24, v);
  }

  bool hasReceiveTimestamp() => $_has(13);
  void clearReceiveTimestamp() => clearField(24);

  String get spanId => $_getS(14, '');
  set spanId(String v) {
    $_setString(14, v);
  }

  bool hasSpanId() => $_has(14);
  void clearSpanId() => clearField(27);
}

class _ReadonlyLogEntry extends LogEntry with ReadonlyMessageMixin {}

class LogEntryOperation extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('LogEntryOperation')
    ..aOS(1, 'id')
    ..aOS(2, 'producer')
    ..aOB(3, 'first')
    ..aOB(4, 'last')
    ..hasRequiredFields = false;

  LogEntryOperation() : super();
  LogEntryOperation.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  LogEntryOperation.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  LogEntryOperation clone() => LogEntryOperation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntryOperation create() => LogEntryOperation();
  static PbList<LogEntryOperation> createRepeated() =>
      PbList<LogEntryOperation>();
  static LogEntryOperation getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyLogEntryOperation();
    return _defaultInstance;
  }

  static LogEntryOperation _defaultInstance;
  static void $checkItem(LogEntryOperation v) {
    if (v is! LogEntryOperation) checkItemFailed(v, 'LogEntryOperation');
  }

  String get id => $_getS(0, '');
  set id(String v) {
    $_setString(0, v);
  }

  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  String get producer => $_getS(1, '');
  set producer(String v) {
    $_setString(1, v);
  }

  bool hasProducer() => $_has(1);
  void clearProducer() => clearField(2);

  bool get first => $_get(2, false);
  set first(bool v) {
    $_setBool(2, v);
  }

  bool hasFirst() => $_has(2);
  void clearFirst() => clearField(3);

  bool get last => $_get(3, false);
  set last(bool v) {
    $_setBool(3, v);
  }

  bool hasLast() => $_has(3);
  void clearLast() => clearField(4);
}

class _ReadonlyLogEntryOperation extends LogEntryOperation
    with ReadonlyMessageMixin {}

class LogEntrySourceLocation extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('LogEntrySourceLocation')
    ..aOS(1, 'file')
    ..aInt64(2, 'line')
    ..aOS(3, 'function')
    ..hasRequiredFields = false;

  LogEntrySourceLocation() : super();
  LogEntrySourceLocation.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  LogEntrySourceLocation.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  LogEntrySourceLocation clone() =>
      LogEntrySourceLocation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntrySourceLocation create() => LogEntrySourceLocation();
  static PbList<LogEntrySourceLocation> createRepeated() =>
      PbList<LogEntrySourceLocation>();
  static LogEntrySourceLocation getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyLogEntrySourceLocation();
    return _defaultInstance;
  }

  static LogEntrySourceLocation _defaultInstance;
  static void $checkItem(LogEntrySourceLocation v) {
    if (v is! LogEntrySourceLocation)
      checkItemFailed(v, 'LogEntrySourceLocation');
  }

  String get file => $_getS(0, '');
  set file(String v) {
    $_setString(0, v);
  }

  bool hasFile() => $_has(0);
  void clearFile() => clearField(1);

  Int64 get line => $_getI64(1);
  set line(Int64 v) {
    $_setInt64(1, v);
  }

  bool hasLine() => $_has(1);
  void clearLine() => clearField(2);

  String get function => $_getS(2, '');
  set function(String v) {
    $_setString(2, v);
  }

  bool hasFunction() => $_has(2);
  void clearFunction() => clearField(3);
}

class _ReadonlyLogEntrySourceLocation extends LogEntrySourceLocation
    with ReadonlyMessageMixin {}
