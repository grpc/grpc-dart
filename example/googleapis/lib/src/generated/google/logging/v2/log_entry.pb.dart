///
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
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
      package: const $pb.PackageName('google.logging.v2'))
    ..oo(0, [2, 3, 6])
    ..a<$0.Any>(
        2, 'protoPayload', $pb.PbFieldType.OM, $0.Any.getDefault, $0.Any.create)
    ..aOS(3, 'textPayload')
    ..aOS(4, 'insertId')
    ..a<$1.Struct>(6, 'jsonPayload', $pb.PbFieldType.OM, $1.Struct.getDefault,
        $1.Struct.create)
    ..a<$2.HttpRequest>(7, 'httpRequest', $pb.PbFieldType.OM,
        $2.HttpRequest.getDefault, $2.HttpRequest.create)
    ..a<$3.MonitoredResource>(8, 'resource', $pb.PbFieldType.OM,
        $3.MonitoredResource.getDefault, $3.MonitoredResource.create)
    ..a<$4.Timestamp>(9, 'timestamp', $pb.PbFieldType.OM,
        $4.Timestamp.getDefault, $4.Timestamp.create)
    ..e<$5.LogSeverity>(10, 'severity', $pb.PbFieldType.OE,
        $5.LogSeverity.DEFAULT, $5.LogSeverity.valueOf, $5.LogSeverity.values)
    ..m<$core.String, $core.String>(
        11,
        'labels',
        'LogEntry.LabelsEntry',
        $pb.PbFieldType.OS,
        $pb.PbFieldType.OS,
        null,
        null,
        null,
        const $pb.PackageName('google.logging.v2'))
    ..aOS(12, 'logName')
    ..a<LogEntryOperation>(15, 'operation', $pb.PbFieldType.OM,
        LogEntryOperation.getDefault, LogEntryOperation.create)
    ..aOS(22, 'trace')
    ..a<LogEntrySourceLocation>(23, 'sourceLocation', $pb.PbFieldType.OM,
        LogEntrySourceLocation.getDefault, LogEntrySourceLocation.create)
    ..a<$4.Timestamp>(
        24, 'receiveTimestamp', $pb.PbFieldType.OM, $4.Timestamp.getDefault, $4.Timestamp.create)
    ..a<$3.MonitoredResourceMetadata>(25, 'metadata', $pb.PbFieldType.OM, $3.MonitoredResourceMetadata.getDefault, $3.MonitoredResourceMetadata.create)
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
  static LogEntry getDefault() => _defaultInstance ??= create()..freeze();
  static LogEntry _defaultInstance;

  LogEntry_Payload whichPayload() => _LogEntry_PayloadByTag[$_whichOneof(0)];
  void clearPayload() => clearField($_whichOneof(0));

  $0.Any get protoPayload => $_getN(0);
  set protoPayload($0.Any v) {
    setField(2, v);
  }

  $core.bool hasProtoPayload() => $_has(0);
  void clearProtoPayload() => clearField(2);

  $core.String get textPayload => $_getS(1, '');
  set textPayload($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasTextPayload() => $_has(1);
  void clearTextPayload() => clearField(3);

  $core.String get insertId => $_getS(2, '');
  set insertId($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasInsertId() => $_has(2);
  void clearInsertId() => clearField(4);

  $1.Struct get jsonPayload => $_getN(3);
  set jsonPayload($1.Struct v) {
    setField(6, v);
  }

  $core.bool hasJsonPayload() => $_has(3);
  void clearJsonPayload() => clearField(6);

  $2.HttpRequest get httpRequest => $_getN(4);
  set httpRequest($2.HttpRequest v) {
    setField(7, v);
  }

  $core.bool hasHttpRequest() => $_has(4);
  void clearHttpRequest() => clearField(7);

  $3.MonitoredResource get resource => $_getN(5);
  set resource($3.MonitoredResource v) {
    setField(8, v);
  }

  $core.bool hasResource() => $_has(5);
  void clearResource() => clearField(8);

  $4.Timestamp get timestamp => $_getN(6);
  set timestamp($4.Timestamp v) {
    setField(9, v);
  }

  $core.bool hasTimestamp() => $_has(6);
  void clearTimestamp() => clearField(9);

  $5.LogSeverity get severity => $_getN(7);
  set severity($5.LogSeverity v) {
    setField(10, v);
  }

  $core.bool hasSeverity() => $_has(7);
  void clearSeverity() => clearField(10);

  $core.Map<$core.String, $core.String> get labels => $_getMap(8);

  $core.String get logName => $_getS(9, '');
  set logName($core.String v) {
    $_setString(9, v);
  }

  $core.bool hasLogName() => $_has(9);
  void clearLogName() => clearField(12);

  LogEntryOperation get operation => $_getN(10);
  set operation(LogEntryOperation v) {
    setField(15, v);
  }

  $core.bool hasOperation() => $_has(10);
  void clearOperation() => clearField(15);

  $core.String get trace => $_getS(11, '');
  set trace($core.String v) {
    $_setString(11, v);
  }

  $core.bool hasTrace() => $_has(11);
  void clearTrace() => clearField(22);

  LogEntrySourceLocation get sourceLocation => $_getN(12);
  set sourceLocation(LogEntrySourceLocation v) {
    setField(23, v);
  }

  $core.bool hasSourceLocation() => $_has(12);
  void clearSourceLocation() => clearField(23);

  $4.Timestamp get receiveTimestamp => $_getN(13);
  set receiveTimestamp($4.Timestamp v) {
    setField(24, v);
  }

  $core.bool hasReceiveTimestamp() => $_has(13);
  void clearReceiveTimestamp() => clearField(24);

  $3.MonitoredResourceMetadata get metadata => $_getN(14);
  set metadata($3.MonitoredResourceMetadata v) {
    setField(25, v);
  }

  $core.bool hasMetadata() => $_has(14);
  void clearMetadata() => clearField(25);

  $core.String get spanId => $_getS(15, '');
  set spanId($core.String v) {
    $_setString(15, v);
  }

  $core.bool hasSpanId() => $_has(15);
  void clearSpanId() => clearField(27);

  $core.bool get traceSampled => $_get(16, false);
  set traceSampled($core.bool v) {
    $_setBool(16, v);
  }

  $core.bool hasTraceSampled() => $_has(16);
  void clearTraceSampled() => clearField(30);
}

class LogEntryOperation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogEntryOperation',
      package: const $pb.PackageName('google.logging.v2'))
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
  static LogEntryOperation getDefault() =>
      _defaultInstance ??= create()..freeze();
  static LogEntryOperation _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get producer => $_getS(1, '');
  set producer($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasProducer() => $_has(1);
  void clearProducer() => clearField(2);

  $core.bool get first => $_get(2, false);
  set first($core.bool v) {
    $_setBool(2, v);
  }

  $core.bool hasFirst() => $_has(2);
  void clearFirst() => clearField(3);

  $core.bool get last => $_get(3, false);
  set last($core.bool v) {
    $_setBool(3, v);
  }

  $core.bool hasLast() => $_has(3);
  void clearLast() => clearField(4);
}

class LogEntrySourceLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LogEntrySourceLocation',
      package: const $pb.PackageName('google.logging.v2'))
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
  static LogEntrySourceLocation getDefault() =>
      _defaultInstance ??= create()..freeze();
  static LogEntrySourceLocation _defaultInstance;

  $core.String get file => $_getS(0, '');
  set file($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasFile() => $_has(0);
  void clearFile() => clearField(1);

  Int64 get line => $_getI64(1);
  set line(Int64 v) {
    $_setInt64(1, v);
  }

  $core.bool hasLine() => $_has(1);
  void clearLine() => clearField(2);

  $core.String get function => $_getS(2, '');
  set function($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasFunction() => $_has(2);
  void clearFunction() => clearField(3);
}
