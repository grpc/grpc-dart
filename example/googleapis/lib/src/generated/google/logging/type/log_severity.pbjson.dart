///
//  Generated code. Do not modify.
//  source: google/logging/type/log_severity.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logSeverityDescriptor instead')
const LogSeverity$json = const {
  '1': 'LogSeverity',
  '2': const [
    const {'1': 'DEFAULT', '2': 0},
    const {'1': 'DEBUG', '2': 100},
    const {'1': 'INFO', '2': 200},
    const {'1': 'NOTICE', '2': 300},
    const {'1': 'WARNING', '2': 400},
    const {'1': 'ERROR', '2': 500},
    const {'1': 'CRITICAL', '2': 600},
    const {'1': 'ALERT', '2': 700},
    const {'1': 'EMERGENCY', '2': 800},
  ],
};

/// Descriptor for `LogSeverity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List logSeverityDescriptor = $convert.base64Decode(
    'CgtMb2dTZXZlcml0eRILCgdERUZBVUxUEAASCQoFREVCVUcQZBIJCgRJTkZPEMgBEgsKBk5PVElDRRCsAhIMCgdXQVJOSU5HEJADEgoKBUVSUk9SEPQDEg0KCENSSVRJQ0FMENgEEgoKBUFMRVJUELwFEg4KCUVNRVJHRU5DWRCgBg==');
