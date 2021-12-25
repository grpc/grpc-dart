///
//  Generated code. Do not modify.
//  source: google/rpc/status.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use statusDescriptor instead')
const Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {
      '1': 'details',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'details'
    },
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode(
    'CgZTdGF0dXMSEgoEY29kZRgBIAEoBVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEi4KB2RldGFpbHMYAyADKAsyFC5nb29nbGUucHJvdG9idWYuQW55UgdkZXRhaWxz');
