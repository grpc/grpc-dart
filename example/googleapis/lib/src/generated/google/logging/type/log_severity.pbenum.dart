///
//  Generated code. Do not modify.
//  source: google/logging/type/log_severity.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LogSeverity extends $pb.ProtobufEnum {
  static const LogSeverity DEFAULT = LogSeverity._(0, 'DEFAULT');
  static const LogSeverity DEBUG = LogSeverity._(100, 'DEBUG');
  static const LogSeverity INFO = LogSeverity._(200, 'INFO');
  static const LogSeverity NOTICE = LogSeverity._(300, 'NOTICE');
  static const LogSeverity WARNING = LogSeverity._(400, 'WARNING');
  static const LogSeverity ERROR = LogSeverity._(500, 'ERROR');
  static const LogSeverity CRITICAL = LogSeverity._(600, 'CRITICAL');
  static const LogSeverity ALERT = LogSeverity._(700, 'ALERT');
  static const LogSeverity EMERGENCY = LogSeverity._(800, 'EMERGENCY');

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
  static LogSeverity valueOf($core.int value) => _byValue[value];

  const LogSeverity._($core.int v, $core.String n) : super(v, n);
}
