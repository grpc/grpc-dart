///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/model.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use modelDescriptor instead')
const Model$json = const {
  '1': 'Model',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'name'},
    const {
      '1': 'base_model_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'baseModelId'
    },
    const {
      '1': 'version',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'version'
    },
    const {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {
      '1': 'input_token_limit',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'inputTokenLimit'
    },
    const {
      '1': 'output_token_limit',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'outputTokenLimit'
    },
    const {
      '1': 'supported_generation_methods',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'supportedGenerationMethods'
    },
    const {
      '1': 'temperature',
      '3': 9,
      '4': 1,
      '5': 2,
      '9': 0,
      '10': 'temperature',
      '17': true
    },
    const {
      '1': 'top_p',
      '3': 10,
      '4': 1,
      '5': 2,
      '9': 1,
      '10': 'topP',
      '17': true
    },
    const {
      '1': 'top_k',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'topK',
      '17': true
    },
  ],
  '7': const {},
  '8': const [
    const {'1': '_temperature'},
    const {'1': '_top_p'},
    const {'1': '_top_k'},
  ],
};

/// Descriptor for `Model`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List modelDescriptor = $convert.base64Decode(
    'CgVNb2RlbBIXCgRuYW1lGAEgASgJQgPgQQJSBG5hbWUSJwoNYmFzZV9tb2RlbF9pZBgCIAEoCUID4EECUgtiYXNlTW9kZWxJZBIdCgd2ZXJzaW9uGAMgASgJQgPgQQJSB3ZlcnNpb24SIQoMZGlzcGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SKgoRaW5wdXRfdG9rZW5fbGltaXQYBiABKAVSD2lucHV0VG9rZW5MaW1pdBIsChJvdXRwdXRfdG9rZW5fbGltaXQYByABKAVSEG91dHB1dFRva2VuTGltaXQSQAocc3VwcG9ydGVkX2dlbmVyYXRpb25fbWV0aG9kcxgIIAMoCVIac3VwcG9ydGVkR2VuZXJhdGlvbk1ldGhvZHMSJQoLdGVtcGVyYXR1cmUYCSABKAJIAFILdGVtcGVyYXR1cmWIAQESGAoFdG9wX3AYCiABKAJIAVIEdG9wUIgBARIYCgV0b3BfaxgLIAEoBUgCUgR0b3BLiAEBOjzqQTkKJ2dlbmVyYXRpdmVsYW5ndWFnZS5nb29nbGVhcGlzLmNvbS9Nb2RlbBIObW9kZWxzL3ttb2RlbH1CDgoMX3RlbXBlcmF0dXJlQggKBl90b3BfcEIICgZfdG9wX2s=');
