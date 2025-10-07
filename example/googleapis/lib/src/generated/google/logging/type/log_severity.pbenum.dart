// This is a generated file - do not edit.
//
// Generated from google/logging/type/log_severity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The severity of the event described in a log entry, expressed as one of the
/// standard severity levels listed below.  For your reference, the levels are
/// assigned the listed numeric values. The effect of using numeric values other
/// than those listed is undefined.
///
/// You can filter for log entries by severity.  For example, the following
/// filter expression will match log entries with severities `INFO`, `NOTICE`,
/// and `WARNING`:
///
///     severity > DEBUG AND severity <= WARNING
///
/// If you are writing log entries, you should map other severity encodings to
/// one of these standard levels. For example, you might map all of Java's FINE,
/// FINER, and FINEST levels to `LogSeverity.DEBUG`. You can preserve the
/// original severity level in the log entry payload if you wish.
class LogSeverity extends $pb.ProtobufEnum {
  /// (0) The log entry has no assigned severity level.
  static const LogSeverity DEFAULT =
      LogSeverity._(0, _omitEnumNames ? '' : 'DEFAULT');

  /// (100) Debug or trace information.
  static const LogSeverity DEBUG =
      LogSeverity._(100, _omitEnumNames ? '' : 'DEBUG');

  /// (200) Routine information, such as ongoing status or performance.
  static const LogSeverity INFO =
      LogSeverity._(200, _omitEnumNames ? '' : 'INFO');

  /// (300) Normal but significant events, such as start up, shut down, or
  /// a configuration change.
  static const LogSeverity NOTICE =
      LogSeverity._(300, _omitEnumNames ? '' : 'NOTICE');

  /// (400) Warning events might cause problems.
  static const LogSeverity WARNING =
      LogSeverity._(400, _omitEnumNames ? '' : 'WARNING');

  /// (500) Error events are likely to cause problems.
  static const LogSeverity ERROR =
      LogSeverity._(500, _omitEnumNames ? '' : 'ERROR');

  /// (600) Critical events cause more severe problems or outages.
  static const LogSeverity CRITICAL =
      LogSeverity._(600, _omitEnumNames ? '' : 'CRITICAL');

  /// (700) A person must take an action immediately.
  static const LogSeverity ALERT =
      LogSeverity._(700, _omitEnumNames ? '' : 'ALERT');

  /// (800) One or more systems are unusable.
  static const LogSeverity EMERGENCY =
      LogSeverity._(800, _omitEnumNames ? '' : 'EMERGENCY');

  static const $core.List<LogSeverity> values = <LogSeverity>[
    DEFAULT,
    DEBUG,
    INFO,
    NOTICE,
    WARNING,
    ERROR,
    CRITICAL,
    ALERT,
    EMERGENCY,
  ];

  static final $core.Map<$core.int, LogSeverity> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LogSeverity? valueOf($core.int value) => _byValue[value];

  const LogSeverity._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
