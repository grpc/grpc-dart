// This is a generated file - do not edit.
//
// Generated from google/logging/v2/log_entry.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/monitored_resource.pb.dart' as $3;
import '../../protobuf/any.pb.dart' as $0;
import '../../protobuf/struct.pb.dart' as $1;
import '../../protobuf/timestamp.pb.dart' as $4;
import '../type/http_request.pb.dart' as $2;
import '../type/log_severity.pbenum.dart' as $5;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum LogEntry_Payload { protoPayload, textPayload, jsonPayload, notSet }

/// An individual entry in a log.
class LogEntry extends $pb.GeneratedMessage {
  factory LogEntry({
    $0.Any? protoPayload,
    $core.String? textPayload,
    $core.String? insertId,
    $1.Struct? jsonPayload,
    $2.HttpRequest? httpRequest,
    $3.MonitoredResource? resource,
    $4.Timestamp? timestamp,
    $5.LogSeverity? severity,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.String? logName,
    LogEntryOperation? operation,
    $core.String? trace,
    LogEntrySourceLocation? sourceLocation,
    $4.Timestamp? receiveTimestamp,
    $core.String? spanId,
    $core.bool? traceSampled,
    LogSplit? split,
  }) {
    final result = create();
    if (protoPayload != null) result.protoPayload = protoPayload;
    if (textPayload != null) result.textPayload = textPayload;
    if (insertId != null) result.insertId = insertId;
    if (jsonPayload != null) result.jsonPayload = jsonPayload;
    if (httpRequest != null) result.httpRequest = httpRequest;
    if (resource != null) result.resource = resource;
    if (timestamp != null) result.timestamp = timestamp;
    if (severity != null) result.severity = severity;
    if (labels != null) result.labels.addEntries(labels);
    if (logName != null) result.logName = logName;
    if (operation != null) result.operation = operation;
    if (trace != null) result.trace = trace;
    if (sourceLocation != null) result.sourceLocation = sourceLocation;
    if (receiveTimestamp != null) result.receiveTimestamp = receiveTimestamp;
    if (spanId != null) result.spanId = spanId;
    if (traceSampled != null) result.traceSampled = traceSampled;
    if (split != null) result.split = split;
    return result;
  }

  LogEntry._();

  factory LogEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, LogEntry_Payload> _LogEntry_PayloadByTag = {
    2: LogEntry_Payload.protoPayload,
    3: LogEntry_Payload.textPayload,
    6: LogEntry_Payload.jsonPayload,
    0: LogEntry_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntry',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 6])
    ..aOM<$0.Any>(2, _omitFieldNames ? '' : 'protoPayload',
        subBuilder: $0.Any.create)
    ..aOS(3, _omitFieldNames ? '' : 'textPayload')
    ..aOS(4, _omitFieldNames ? '' : 'insertId')
    ..aOM<$1.Struct>(6, _omitFieldNames ? '' : 'jsonPayload',
        subBuilder: $1.Struct.create)
    ..aOM<$2.HttpRequest>(7, _omitFieldNames ? '' : 'httpRequest',
        subBuilder: $2.HttpRequest.create)
    ..aOM<$3.MonitoredResource>(8, _omitFieldNames ? '' : 'resource',
        subBuilder: $3.MonitoredResource.create)
    ..aOM<$4.Timestamp>(9, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $4.Timestamp.create)
    ..aE<$5.LogSeverity>(10, _omitFieldNames ? '' : 'severity',
        enumValues: $5.LogSeverity.values)
    ..m<$core.String, $core.String>(11, _omitFieldNames ? '' : 'labels',
        entryClassName: 'LogEntry.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..aOS(12, _omitFieldNames ? '' : 'logName')
    ..aOM<LogEntryOperation>(15, _omitFieldNames ? '' : 'operation',
        subBuilder: LogEntryOperation.create)
    ..aOS(22, _omitFieldNames ? '' : 'trace')
    ..aOM<LogEntrySourceLocation>(23, _omitFieldNames ? '' : 'sourceLocation',
        subBuilder: LogEntrySourceLocation.create)
    ..aOM<$4.Timestamp>(24, _omitFieldNames ? '' : 'receiveTimestamp',
        subBuilder: $4.Timestamp.create)
    ..aOS(27, _omitFieldNames ? '' : 'spanId')
    ..aOB(30, _omitFieldNames ? '' : 'traceSampled')
    ..aOM<LogSplit>(35, _omitFieldNames ? '' : 'split',
        subBuilder: LogSplit.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntry copyWith(void Function(LogEntry) updates) =>
      super.copyWith((message) => updates(message as LogEntry)) as LogEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntry create() => LogEntry._();
  @$core.override
  LogEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogEntry>(create);
  static LogEntry? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(6)
  LogEntry_Payload whichPayload() => _LogEntry_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(6)
  void clearPayload() => $_clearField($_whichOneof(0));

  /// The log entry payload, represented as a protocol buffer. Some Google
  /// Cloud Platform services use this field for their log entry payloads.
  ///
  /// The following protocol buffer types are supported; user-defined types
  /// are not supported:
  ///
  ///   "type.googleapis.com/google.cloud.audit.AuditLog"
  ///   "type.googleapis.com/google.appengine.logging.v1.RequestLog"
  @$pb.TagNumber(2)
  $0.Any get protoPayload => $_getN(0);
  @$pb.TagNumber(2)
  set protoPayload($0.Any value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasProtoPayload() => $_has(0);
  @$pb.TagNumber(2)
  void clearProtoPayload() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Any ensureProtoPayload() => $_ensure(0);

  /// The log entry payload, represented as a Unicode string (UTF-8).
  @$pb.TagNumber(3)
  $core.String get textPayload => $_getSZ(1);
  @$pb.TagNumber(3)
  set textPayload($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasTextPayload() => $_has(1);
  @$pb.TagNumber(3)
  void clearTextPayload() => $_clearField(3);

  /// Optional. A unique identifier for the log entry. If you provide a value,
  /// then Logging considers other log entries in the same project, with the same
  /// `timestamp`, and with the same `insert_id` to be duplicates which are
  /// removed in a single query result. However, there are no guarantees of
  /// de-duplication in the export of logs.
  ///
  /// If the `insert_id` is omitted when writing a log entry, the Logging API
  /// assigns its own unique identifier in this field.
  ///
  /// In queries, the `insert_id` is also used to order log entries that have
  /// the same `log_name` and `timestamp` values.
  @$pb.TagNumber(4)
  $core.String get insertId => $_getSZ(2);
  @$pb.TagNumber(4)
  set insertId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasInsertId() => $_has(2);
  @$pb.TagNumber(4)
  void clearInsertId() => $_clearField(4);

  /// The log entry payload, represented as a structure that is
  /// expressed as a JSON object.
  @$pb.TagNumber(6)
  $1.Struct get jsonPayload => $_getN(3);
  @$pb.TagNumber(6)
  set jsonPayload($1.Struct value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasJsonPayload() => $_has(3);
  @$pb.TagNumber(6)
  void clearJsonPayload() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Struct ensureJsonPayload() => $_ensure(3);

  /// Optional. Information about the HTTP request associated with this log
  /// entry, if applicable.
  @$pb.TagNumber(7)
  $2.HttpRequest get httpRequest => $_getN(4);
  @$pb.TagNumber(7)
  set httpRequest($2.HttpRequest value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasHttpRequest() => $_has(4);
  @$pb.TagNumber(7)
  void clearHttpRequest() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.HttpRequest ensureHttpRequest() => $_ensure(4);

  /// Required. The monitored resource that produced this log entry.
  ///
  /// Example: a log entry that reports a database error would be associated with
  /// the monitored resource designating the particular database that reported
  /// the error.
  @$pb.TagNumber(8)
  $3.MonitoredResource get resource => $_getN(5);
  @$pb.TagNumber(8)
  set resource($3.MonitoredResource value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasResource() => $_has(5);
  @$pb.TagNumber(8)
  void clearResource() => $_clearField(8);
  @$pb.TagNumber(8)
  $3.MonitoredResource ensureResource() => $_ensure(5);

  /// Optional. The time the event described by the log entry occurred. This time
  /// is used to compute the log entry's age and to enforce the logs retention
  /// period. If this field is omitted in a new log entry, then Logging assigns
  /// it the current time. Timestamps have nanosecond accuracy, but trailing
  /// zeros in the fractional seconds might be omitted when the timestamp is
  /// displayed.
  ///
  /// Incoming log entries must have timestamps that don't exceed the
  /// [logs retention
  /// period](https://cloud.google.com/logging/quotas#logs_retention_periods) in
  /// the past, and that don't exceed 24 hours in the future. Log entries outside
  /// those time boundaries aren't ingested by Logging.
  @$pb.TagNumber(9)
  $4.Timestamp get timestamp => $_getN(6);
  @$pb.TagNumber(9)
  set timestamp($4.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTimestamp() => $_has(6);
  @$pb.TagNumber(9)
  void clearTimestamp() => $_clearField(9);
  @$pb.TagNumber(9)
  $4.Timestamp ensureTimestamp() => $_ensure(6);

  /// Optional. The severity of the log entry. The default value is
  /// `LogSeverity.DEFAULT`.
  @$pb.TagNumber(10)
  $5.LogSeverity get severity => $_getN(7);
  @$pb.TagNumber(10)
  set severity($5.LogSeverity value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSeverity() => $_has(7);
  @$pb.TagNumber(10)
  void clearSeverity() => $_clearField(10);

  /// Optional. A map of key, value pairs that provides additional information
  /// about the log entry. The labels can be user-defined or system-defined.
  ///
  /// User-defined labels are arbitrary key, value pairs that you can use to
  /// classify logs.
  ///
  /// System-defined labels are defined by GCP services for platform logs.
  /// They have two components - a service namespace component and the
  /// attribute name. For example: `compute.googleapis.com/resource_name`.
  ///
  /// Cloud Logging truncates label keys that exceed 512 B and label
  /// values that exceed 64 KB upon their associated log entry being
  /// written. The truncation is indicated by an ellipsis at the
  /// end of the character string.
  @$pb.TagNumber(11)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(8);

  /// Required. The resource name of the log to which this log entry belongs:
  ///
  ///     "projects/[PROJECT_ID]/logs/[LOG_ID]"
  ///     "organizations/[ORGANIZATION_ID]/logs/[LOG_ID]"
  ///     "billingAccounts/[BILLING_ACCOUNT_ID]/logs/[LOG_ID]"
  ///     "folders/[FOLDER_ID]/logs/[LOG_ID]"
  ///
  /// A project number may be used in place of PROJECT_ID. The project number is
  /// translated to its corresponding PROJECT_ID internally and the `log_name`
  /// field will contain PROJECT_ID in queries and exports.
  ///
  /// `[LOG_ID]` must be URL-encoded within `log_name`. Example:
  /// `"organizations/1234567890/logs/cloudresourcemanager.googleapis.com%2Factivity"`.
  ///
  /// `[LOG_ID]` must be less than 512 characters long and can only include the
  /// following characters: upper and lower case alphanumeric characters,
  /// forward-slash, underscore, hyphen, and period.
  ///
  /// For backward compatibility, if `log_name` begins with a forward-slash, such
  /// as `/projects/...`, then the log entry is ingested as usual, but the
  /// forward-slash is removed. Listing the log entry will not show the leading
  /// slash and filtering for a log name with a leading slash will never return
  /// any results.
  @$pb.TagNumber(12)
  $core.String get logName => $_getSZ(9);
  @$pb.TagNumber(12)
  set logName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(12)
  $core.bool hasLogName() => $_has(9);
  @$pb.TagNumber(12)
  void clearLogName() => $_clearField(12);

  /// Optional. Information about an operation associated with the log entry, if
  /// applicable.
  @$pb.TagNumber(15)
  LogEntryOperation get operation => $_getN(10);
  @$pb.TagNumber(15)
  set operation(LogEntryOperation value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasOperation() => $_has(10);
  @$pb.TagNumber(15)
  void clearOperation() => $_clearField(15);
  @$pb.TagNumber(15)
  LogEntryOperation ensureOperation() => $_ensure(10);

  /// Optional. The REST resource name of the trace being written to
  /// [Cloud Trace](https://cloud.google.com/trace) in
  /// association with this log entry. For example, if your trace data is stored
  /// in the Cloud project "my-trace-project" and if the service that is creating
  /// the log entry receives a trace header that includes the trace ID "12345",
  /// then the service should use "projects/my-tracing-project/traces/12345".
  ///
  /// The `trace` field provides the link between logs and traces. By using
  /// this field, you can navigate from a log entry to a trace.
  @$pb.TagNumber(22)
  $core.String get trace => $_getSZ(11);
  @$pb.TagNumber(22)
  set trace($core.String value) => $_setString(11, value);
  @$pb.TagNumber(22)
  $core.bool hasTrace() => $_has(11);
  @$pb.TagNumber(22)
  void clearTrace() => $_clearField(22);

  /// Optional. Source code location information associated with the log entry,
  /// if any.
  @$pb.TagNumber(23)
  LogEntrySourceLocation get sourceLocation => $_getN(12);
  @$pb.TagNumber(23)
  set sourceLocation(LogEntrySourceLocation value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasSourceLocation() => $_has(12);
  @$pb.TagNumber(23)
  void clearSourceLocation() => $_clearField(23);
  @$pb.TagNumber(23)
  LogEntrySourceLocation ensureSourceLocation() => $_ensure(12);

  /// Output only. The time the log entry was received by Logging.
  @$pb.TagNumber(24)
  $4.Timestamp get receiveTimestamp => $_getN(13);
  @$pb.TagNumber(24)
  set receiveTimestamp($4.Timestamp value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasReceiveTimestamp() => $_has(13);
  @$pb.TagNumber(24)
  void clearReceiveTimestamp() => $_clearField(24);
  @$pb.TagNumber(24)
  $4.Timestamp ensureReceiveTimestamp() => $_ensure(13);

  /// Optional. The ID of the [Cloud Trace](https://cloud.google.com/trace) span
  /// associated with the current operation in which the log is being written.
  /// For example, if a span has the REST resource name of
  /// "projects/some-project/traces/some-trace/spans/some-span-id", then the
  /// `span_id` field is "some-span-id".
  ///
  /// A
  /// [Span](https://cloud.google.com/trace/docs/reference/v2/rest/v2/projects.traces/batchWrite#Span)
  /// represents a single operation within a trace. Whereas a trace may involve
  /// multiple different microservices running on multiple different machines,
  /// a span generally corresponds to a single logical operation being performed
  /// in a single instance of a microservice on one specific machine. Spans
  /// are the nodes within the tree that is a trace.
  ///
  /// Applications that are [instrumented for
  /// tracing](https://cloud.google.com/trace/docs/setup) will generally assign a
  /// new, unique span ID on each incoming request. It is also common to create
  /// and record additional spans corresponding to internal processing elements
  /// as well as issuing requests to dependencies.
  ///
  /// The span ID is expected to be a 16-character, hexadecimal encoding of an
  /// 8-byte array and should not be zero. It should be unique within the trace
  /// and should, ideally, be generated in a manner that is uniformly random.
  ///
  /// Example values:
  ///
  ///   - `000000000000004a`
  ///   - `7a2190356c3fc94b`
  ///   - `0000f00300090021`
  ///   - `d39223e101960076`
  @$pb.TagNumber(27)
  $core.String get spanId => $_getSZ(14);
  @$pb.TagNumber(27)
  set spanId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(27)
  $core.bool hasSpanId() => $_has(14);
  @$pb.TagNumber(27)
  void clearSpanId() => $_clearField(27);

  /// Optional. The sampling decision of the trace associated with the log entry.
  ///
  /// True means that the trace resource name in the `trace` field was sampled
  /// for storage in a trace backend. False means that the trace was not sampled
  /// for storage when this log entry was written, or the sampling decision was
  /// unknown at the time. A non-sampled `trace` value is still useful as a
  /// request correlation identifier. The default is False.
  @$pb.TagNumber(30)
  $core.bool get traceSampled => $_getBF(15);
  @$pb.TagNumber(30)
  set traceSampled($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(30)
  $core.bool hasTraceSampled() => $_has(15);
  @$pb.TagNumber(30)
  void clearTraceSampled() => $_clearField(30);

  /// Optional. Information indicating this LogEntry is part of a sequence of
  /// multiple log entries split from a single LogEntry.
  @$pb.TagNumber(35)
  LogSplit get split => $_getN(16);
  @$pb.TagNumber(35)
  set split(LogSplit value) => $_setField(35, value);
  @$pb.TagNumber(35)
  $core.bool hasSplit() => $_has(16);
  @$pb.TagNumber(35)
  void clearSplit() => $_clearField(35);
  @$pb.TagNumber(35)
  LogSplit ensureSplit() => $_ensure(16);
}

/// Additional information about a potentially long-running operation with which
/// a log entry is associated.
class LogEntryOperation extends $pb.GeneratedMessage {
  factory LogEntryOperation({
    $core.String? id,
    $core.String? producer,
    $core.bool? first,
    $core.bool? last,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (producer != null) result.producer = producer;
    if (first != null) result.first = first;
    if (last != null) result.last = last;
    return result;
  }

  LogEntryOperation._();

  factory LogEntryOperation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogEntryOperation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntryOperation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'producer')
    ..aOB(3, _omitFieldNames ? '' : 'first')
    ..aOB(4, _omitFieldNames ? '' : 'last')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryOperation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryOperation copyWith(void Function(LogEntryOperation) updates) =>
      super.copyWith((message) => updates(message as LogEntryOperation))
          as LogEntryOperation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntryOperation create() => LogEntryOperation._();
  @$core.override
  LogEntryOperation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogEntryOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntryOperation>(create);
  static LogEntryOperation? _defaultInstance;

  /// Optional. An arbitrary operation identifier. Log entries with the same
  /// identifier are assumed to be part of the same operation.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Optional. An arbitrary producer identifier. The combination of `id` and
  /// `producer` must be globally unique. Examples for `producer`:
  /// `"MyDivision.MyBigCompany.com"`, `"github.com/MyProject/MyApplication"`.
  @$pb.TagNumber(2)
  $core.String get producer => $_getSZ(1);
  @$pb.TagNumber(2)
  set producer($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProducer() => $_has(1);
  @$pb.TagNumber(2)
  void clearProducer() => $_clearField(2);

  /// Optional. Set this to True if this is the first log entry in the operation.
  @$pb.TagNumber(3)
  $core.bool get first => $_getBF(2);
  @$pb.TagNumber(3)
  set first($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirst() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirst() => $_clearField(3);

  /// Optional. Set this to True if this is the last log entry in the operation.
  @$pb.TagNumber(4)
  $core.bool get last => $_getBF(3);
  @$pb.TagNumber(4)
  set last($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLast() => $_has(3);
  @$pb.TagNumber(4)
  void clearLast() => $_clearField(4);
}

/// Additional information about the source code location that produced the log
/// entry.
class LogEntrySourceLocation extends $pb.GeneratedMessage {
  factory LogEntrySourceLocation({
    $core.String? file,
    $fixnum.Int64? line,
    $core.String? function,
  }) {
    final result = create();
    if (file != null) result.file = file;
    if (line != null) result.line = line;
    if (function != null) result.function = function;
    return result;
  }

  LogEntrySourceLocation._();

  factory LogEntrySourceLocation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogEntrySourceLocation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntrySourceLocation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'file')
    ..aInt64(2, _omitFieldNames ? '' : 'line')
    ..aOS(3, _omitFieldNames ? '' : 'function')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntrySourceLocation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntrySourceLocation copyWith(
          void Function(LogEntrySourceLocation) updates) =>
      super.copyWith((message) => updates(message as LogEntrySourceLocation))
          as LogEntrySourceLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation create() => LogEntrySourceLocation._();
  @$core.override
  LogEntrySourceLocation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntrySourceLocation>(create);
  static LogEntrySourceLocation? _defaultInstance;

  /// Optional. Source file name. Depending on the runtime environment, this
  /// might be a simple name or a fully-qualified name.
  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => $_clearField(1);

  /// Optional. Line within the source file. 1-based; 0 indicates no line number
  /// available.
  @$pb.TagNumber(2)
  $fixnum.Int64 get line => $_getI64(1);
  @$pb.TagNumber(2)
  set line($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearLine() => $_clearField(2);

  /// Optional. Human-readable name of the function or method being invoked, with
  /// optional context such as the class or package name. This information may be
  /// used in contexts such as the logs viewer, where a file and line number are
  /// less meaningful. The format can vary by language. For example:
  /// `qual.if.ied.Class.method` (Java), `dir/package.func` (Go), `function`
  /// (Python).
  @$pb.TagNumber(3)
  $core.String get function => $_getSZ(2);
  @$pb.TagNumber(3)
  set function($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => $_clearField(3);
}

/// Additional information used to correlate multiple log entries. Used when a
/// single LogEntry would exceed the Google Cloud Logging size limit and is
/// split across multiple log entries.
class LogSplit extends $pb.GeneratedMessage {
  factory LogSplit({
    $core.String? uid,
    $core.int? index,
    $core.int? totalSplits,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (index != null) result.index = index;
    if (totalSplits != null) result.totalSplits = totalSplits;
    return result;
  }

  LogSplit._();

  factory LogSplit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogSplit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogSplit',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..aI(2, _omitFieldNames ? '' : 'index')
    ..aI(3, _omitFieldNames ? '' : 'totalSplits')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogSplit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogSplit copyWith(void Function(LogSplit) updates) =>
      super.copyWith((message) => updates(message as LogSplit)) as LogSplit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogSplit create() => LogSplit._();
  @$core.override
  LogSplit createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogSplit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogSplit>(create);
  static LogSplit? _defaultInstance;

  /// A globally unique identifier for all log entries in a sequence of split log
  /// entries. All log entries with the same |LogSplit.uid| are assumed to be
  /// part of the same sequence of split log entries.
  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  /// The index of this LogEntry in the sequence of split log entries. Log
  /// entries are given |index| values 0, 1, ..., n-1 for a sequence of n log
  /// entries.
  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => $_clearField(2);

  /// The total number of log entries that the original LogEntry was split into.
  @$pb.TagNumber(3)
  $core.int get totalSplits => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalSplits($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSplits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSplits() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
