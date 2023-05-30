///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/model_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getModelRequestDescriptor instead')
const GetModelRequest$json = const {
  '1': 'GetModelRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'name'},
  ],
};

/// Descriptor for `GetModelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getModelRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRNb2RlbFJlcXVlc3QSQwoEbmFtZRgBIAEoCUIv4EEC+kEpCidnZW5lcmF0aXZlbGFuZ3VhZ2UuZ29vZ2xlYXBpcy5jb20vTW9kZWxSBG5hbWU=');
@$core.Deprecated('Use listModelsRequestDescriptor instead')
const ListModelsRequest$json = const {
  '1': 'ListModelsRequest',
  '2': const [
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListModelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listModelsRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0TW9kZWxzUmVxdWVzdBIbCglwYWdlX3NpemUYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use listModelsResponseDescriptor instead')
const ListModelsResponse$json = const {
  '1': 'ListModelsResponse',
  '2': const [
    const {
      '1': 'models',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Model',
      '10': 'models'
    },
    const {
      '1': 'next_page_token',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'nextPageToken'
    },
  ],
};

/// Descriptor for `ListModelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listModelsResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0TW9kZWxzUmVzcG9uc2USQwoGbW9kZWxzGAEgAygLMisuZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1vZGVsUgZtb2RlbHMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');
