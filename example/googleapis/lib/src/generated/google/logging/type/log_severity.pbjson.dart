// This is a generated file - do not edit.
//
// Generated from google/logging/type/log_severity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logSeverityDescriptor instead')
const LogSeverity$json = {
  '1': 'LogSeverity',
  '2': [
    {'1': 'DEFAULT', '2': 0},
    {'1': 'DEBUG', '2': 100},
    {'1': 'INFO', '2': 200},
    {'1': 'NOTICE', '2': 300},
    {'1': 'WARNING', '2': 400},
    {'1': 'ERROR', '2': 500},
    {'1': 'CRITICAL', '2': 600},
    {'1': 'ALERT', '2': 700},
    {'1': 'EMERGENCY', '2': 800},
  ],
};

/// Descriptor for `LogSeverity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List logSeverityDescriptor = $convert.base64Decode(
    'CgtMb2dTZXZlcml0eRILCgdERUZBVUxUEAASCQoFREVCVUcQZBIJCgRJTkZPEMgBEgsKBk5PVE'
    'lDRRCsAhIMCgdXQVJOSU5HEJADEgoKBUVSUk9SEPQDEg0KCENSSVRJQ0FMENgEEgoKBUFMRVJU'
    'ELwFEg4KCUVNRVJHRU5DWRCgBg==');
