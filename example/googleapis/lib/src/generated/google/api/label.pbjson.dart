///
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use labelDescriptorDescriptor instead')
const LabelDescriptor$json = const {
  '1': 'LabelDescriptor',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {
      '1': 'value_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.api.LabelDescriptor.ValueType',
      '10': 'valueType'
    },
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': const [LabelDescriptor_ValueType$json],
};

@$core.Deprecated('Use labelDescriptorDescriptor instead')
const LabelDescriptor_ValueType$json = const {
  '1': 'ValueType',
  '2': const [
    const {'1': 'STRING', '2': 0},
    const {'1': 'BOOL', '2': 1},
    const {'1': 'INT64', '2': 2},
  ],
};

/// Descriptor for `LabelDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List labelDescriptorDescriptor = $convert.base64Decode(
    'Cg9MYWJlbERlc2NyaXB0b3ISEAoDa2V5GAEgASgJUgNrZXkSRAoKdmFsdWVfdHlwZRgCIAEoDjIlLmdvb2dsZS5hcGkuTGFiZWxEZXNjcmlwdG9yLlZhbHVlVHlwZVIJdmFsdWVUeXBlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbiIsCglWYWx1ZVR5cGUSCgoGU1RSSU5HEAASCAoEQk9PTBABEgkKBUlOVDY0EAI=');
