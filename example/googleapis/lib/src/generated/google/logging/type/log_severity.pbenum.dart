///
//  Generated code. Do not modify.
//  source: google/logging/type/log_severity.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LogSeverity extends $pb.ProtobufEnum {
  static const LogSeverity DEFAULT = LogSeverity._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'DEFAULT');
  static const LogSeverity DEBUG = LogSeverity._(
      100,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'DEBUG');
  static const LogSeverity INFO = LogSeverity._(
      200,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'INFO');
  static const LogSeverity NOTICE = LogSeverity._(
      300,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'NOTICE');
  static const LogSeverity WARNING = LogSeverity._(
      400,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'WARNING');
  static const LogSeverity ERROR = LogSeverity._(
      500,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ERROR');
  static const LogSeverity CRITICAL = LogSeverity._(
      600,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'CRITICAL');
  static const LogSeverity ALERT = LogSeverity._(
      700,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ALERT');
  static const LogSeverity EMERGENCY = LogSeverity._(
      800,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'EMERGENCY');

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

  const LogSeverity._($core.int v, $core.String n) : super(v, n);
}
