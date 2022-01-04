///
//  Generated code. Do not modify.
//  source: google/api/launch_stage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use launchStageDescriptor instead')
const LaunchStage$json = const {
  '1': 'LaunchStage',
  '2': const [
    const {'1': 'LAUNCH_STAGE_UNSPECIFIED', '2': 0},
    const {'1': 'UNIMPLEMENTED', '2': 6},
    const {'1': 'PRELAUNCH', '2': 7},
    const {'1': 'EARLY_ACCESS', '2': 1},
    const {'1': 'ALPHA', '2': 2},
    const {'1': 'BETA', '2': 3},
    const {'1': 'GA', '2': 4},
    const {'1': 'DEPRECATED', '2': 5},
  ],
};

/// Descriptor for `LaunchStage`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List launchStageDescriptor = $convert.base64Decode(
    'CgtMYXVuY2hTdGFnZRIcChhMQVVOQ0hfU1RBR0VfVU5TUEVDSUZJRUQQABIRCg1VTklNUExFTUVOVEVEEAYSDQoJUFJFTEFVTkNIEAcSEAoMRUFSTFlfQUNDRVNTEAESCQoFQUxQSEEQAhIICgRCRVRBEAMSBgoCR0EQBBIOCgpERVBSRUNBVEVEEAU=');
