///
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/any.pb.dart' as $0;
import '../../protobuf/struct.pb.dart' as $1;
import '../type/http_request.pb.dart' as $2;
import '../../api/monitored_resource.pb.dart' as $3;
import '../../protobuf/timestamp.pb.dart' as $4;

import '../type/log_severity.pbenum.dart' as $5;

enum LogEntry_Payload { protoPayload, textPayload, jsonPayload, notSet }

class LogEntry extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, LogEntry_Payload> _LogEntry_PayloadByTag = {
    2: LogEntry_Payload.protoPayload,
    3: LogEntry_Payload.textPayload,
    6: LogEntry_Payload.jsonPayload,
    0: LogEntry_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogEntry',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 6])
    ..aOM<$0.Any>(2, 'protoPayload', subBuilder: $0.Any.create)
    ..aOS(3, 'textPayload')
    ..aOS(4, 'insertId')
    ..aOM<$1.Struct>(6, 'jsonPayload', subBuilder: $1.Struct.create)
    ..aOM<$2.HttpRequest>(7, 'httpRequest', subBuilder: $2.HttpRequest.create)
    ..aOM<$3.MonitoredResource>(8, 'resource',
        subBuilder: $3.MonitoredResource.create)
    ..aOM<$4.Timestamp>(9, 'timestamp', subBuilder: $4.Timestamp.create)
    ..e<$5.LogSeverity>(10, 'severity', $pb.PbFieldType.OE,
        defaultOrMaker: $5.LogSeverity.DEFAULT,
        valueOf: $5.LogSeverity.valueOf,
        enumValues: $5.LogSeverity.values)
    ..m<$core.String, $core.String>(11, 'labels',
        entryClassName: 'LogEntry.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..aOS(12, 'logName')
    ..aOM<LogEntryOperation>(15, 'operation',
        subBuilder: LogEntryOperation.create)
    ..aOS(22, 'trace')
    ..aOM<LogEntrySourceLocation>(23, 'sourceLocation',
        subBuilder: LogEntrySourceLocation.create)
    ..aOM<$4.Timestamp>(24, 'receiveTimestamp', subBuilder: $4.Timestamp.create)
    ..aOS(27, 'spanId')
    ..aOB(30, 'traceSampled')
    ..hasRequiredFields = false;

  LogEntry._() : super();
  factory LogEntry() => create();
  factory LogEntry.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntry.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  LogEntry clone() => LogEntry()..mergeFromMessage(this);
  LogEntry copyWith(void Function(LogEntry) updates) =>
      super.copyWith((message) => updates(message as LogEntry));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogEntry create() => LogEntry._();
  LogEntry createEmptyInstance() => create();
  static $pb.PbList<LogEntry> createRepeated() => $pb.PbList<LogEntry>();
  @$core.pragma('dart2js:noInline')
  static LogEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogEntry>(create);
  static LogEntry _defaultInstance;

  LogEntry_Payload whichPayload() => _LogEntry_PayloadByTag[$_whichOneof(0)];
  void clearPayload() => clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  $0.Any get protoPayload => $_getN(0);
  @$pb.TagNumber(2)
  set protoPayload($0.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProtoPayload() => $_has(0);
  @$pb.TagNumber(2)
  void clearProtoPayload() => clearField(2);
  @$pb.TagNumber(2)
  $0.Any ensureProtoPayload() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.String get textPayload => $_getSZ(1);
  @$pb.TagNumber(3)
  set textPayload($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTextPayload() => $_has(1);
  @$pb.TagNumber(3)
  void clearTextPayload() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get insertId => $_getSZ(2);
  @$pb.TagNumber(4)
  set insertId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasInsertId() => $_has(2);
  @$pb.TagNumber(4)
  void clearInsertId() => clearField(4);

  @$pb.TagNumber(6)
  $1.Struct get jsonPayload => $_getN(3);
  @$pb.TagNumber(6)
  set jsonPayload($1.Struct v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasJsonPayload() => $_has(3);
  @$pb.TagNumber(6)
  void clearJsonPayload() => clearField(6);
  @$pb.TagNumber(6)
  $1.Struct ensureJsonPayload() => $_ensure(3);

  @$pb.TagNumber(7)
  $2.HttpRequest get httpRequest => $_getN(4);
  @$pb.TagNumber(7)
  set httpRequest($2.HttpRequest v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasHttpRequest() => $_has(4);
  @$pb.TagNumber(7)
  void clearHttpRequest() => clearField(7);
  @$pb.TagNumber(7)
  $2.HttpRequest ensureHttpRequest() => $_ensure(4);

  @$pb.TagNumber(8)
  $3.MonitoredResource get resource => $_getN(5);
  @$pb.TagNumber(8)
  set resource($3.MonitoredResource v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasResource() => $_has(5);
  @$pb.TagNumber(8)
  void clearResource() => clearField(8);
  @$pb.TagNumber(8)
  $3.MonitoredResource ensureResource() => $_ensure(5);

  @$pb.TagNumber(9)
  $4.Timestamp get timestamp => $_getN(6);
  @$pb.TagNumber(9)
  set timestamp($4.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTimestamp() => $_has(6);
  @$pb.TagNumber(9)
  void clearTimestamp() => clearField(9);
  @$pb.TagNumber(9)
  $4.Timestamp ensureTimestamp() => $_ensure(6);

  @$pb.TagNumber(10)
  $5.LogSeverity get severity => $_getN(7);
  @$pb.TagNumber(10)
  set severity($5.LogSeverity v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasSeverity() => $_has(7);
  @$pb.TagNumber(10)
  void clearSeverity() => clearField(10);

  @$pb.TagNumber(11)
  $core.Map<$core.String, $core.String> get labels => $_getMap(8);

  @$pb.TagNumber(12)
  $core.String get logName => $_getSZ(9);
  @$pb.TagNumber(12)
  set logName($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasLogName() => $_has(9);
  @$pb.TagNumber(12)
  void clearLogName() => clearField(12);

  @$pb.TagNumber(15)
  LogEntryOperation get operation => $_getN(10);
  @$pb.TagNumber(15)
  set operation(LogEntryOperation v) {
    setField(15, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasOperation() => $_has(10);
  @$pb.TagNumber(15)
  void clearOperation() => clearField(15);
  @$pb.TagNumber(15)
  LogEntryOperation ensureOperation() => $_ensure(10);

  @$pb.TagNumber(22)
  $core.String get trace => $_getSZ(11);
  @$pb.TagNumber(22)
  set trace($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasTrace() => $_has(11);
  @$pb.TagNumber(22)
  void clearTrace() => clearField(22);

  @$pb.TagNumber(23)
  LogEntrySourceLocation get sourceLocation => $_getN(12);
  @$pb.TagNumber(23)
  set sourceLocation(LogEntrySourceLocation v) {
    setField(23, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasSourceLocation() => $_has(12);
  @$pb.TagNumber(23)
  void clearSourceLocation() => clearField(23);
  @$pb.TagNumber(23)
  LogEntrySourceLocation ensureSourceLocation() => $_ensure(12);

  @$pb.TagNumber(24)
  $4.Timestamp get receiveTimestamp => $_getN(13);
  @$pb.TagNumber(24)
  set receiveTimestamp($4.Timestamp v) {
    setField(24, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasReceiveTimestamp() => $_has(13);
  @$pb.TagNumber(24)
  void clearReceiveTimestamp() => clearField(24);
  @$pb.TagNumber(24)
  $4.Timestamp ensureReceiveTimestamp() => $_ensure(13);

  @$pb.TagNumber(27)
  $core.String get spanId => $_getSZ(14);
  @$pb.TagNumber(27)
  set spanId($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasSpanId() => $_has(14);
  @$pb.TagNumber(27)
  void clearSpanId() => clearField(27);

  @$pb.TagNumber(30)
  $core.bool get traceSampled => $_getBF(15);
  @$pb.TagNumber(30)
  set traceSampled($core.bool v) {
    $_setBool(15, v);
  }

  @$pb.TagNumber(30)
  $core.bool hasTraceSampled() => $_has(15);
  @$pb.TagNumber(30)
  void clearTraceSampled() => clearField(30);
}

class LogEntryOperation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogEntryOperation',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'producer')
    ..aOB(3, 'first')
    ..aOB(4, 'last')
    ..hasRequiredFields = false;

  LogEntryOperation._() : super();
  factory LogEntryOperation() => create();
  factory LogEntryOperation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntryOperation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  LogEntryOperation clone() => LogEntryOperation()..mergeFromMessage(this);
  LogEntryOperation copyWith(void Function(LogEntryOperation) updates) =>
      super.copyWith((message) => updates(message as LogEntryOperation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogEntryOperation create() => LogEntryOperation._();
  LogEntryOperation createEmptyInstance() => create();
  static $pb.PbList<LogEntryOperation> createRepeated() =>
      $pb.PbList<LogEntryOperation>();
  @$core.pragma('dart2js:noInline')
  static LogEntryOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntryOperation>(create);
  static LogEntryOperation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get producer => $_getSZ(1);
  @$pb.TagNumber(2)
  set producer($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProducer() => $_has(1);
  @$pb.TagNumber(2)
  void clearProducer() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get first => $_getBF(2);
  @$pb.TagNumber(3)
  set first($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFirst() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirst() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get last => $_getBF(3);
  @$pb.TagNumber(4)
  set last($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLast() => $_has(3);
  @$pb.TagNumber(4)
  void clearLast() => clearField(4);
}

class LogEntrySourceLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogEntrySourceLocation',
      package: const $pb.PackageName('google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, 'file')
    ..aInt64(2, 'line')
    ..aOS(3, 'function')
    ..hasRequiredFields = false;

  LogEntrySourceLocation._() : super();
  factory LogEntrySourceLocation() => create();
  factory LogEntrySourceLocation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntrySourceLocation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  LogEntrySourceLocation clone() =>
      LogEntrySourceLocation()..mergeFromMessage(this);
  LogEntrySourceLocation copyWith(
          void Function(LogEntrySourceLocation) updates) =>
      super.copyWith((message) => updates(message as LogEntrySourceLocation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation create() => LogEntrySourceLocation._();
  LogEntrySourceLocation createEmptyInstance() => create();
  static $pb.PbList<LogEntrySourceLocation> createRepeated() =>
      $pb.PbList<LogEntrySourceLocation>();
  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntrySourceLocation>(create);
  static LogEntrySourceLocation _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get line => $_getI64(1);
  @$pb.TagNumber(2)
  set line($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearLine() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get function => $_getSZ(2);
  @$pb.TagNumber(3)
  set function($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => clearField(3);
}
