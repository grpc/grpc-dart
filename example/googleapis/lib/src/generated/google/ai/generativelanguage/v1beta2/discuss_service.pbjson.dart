///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/discuss_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use generateMessageRequestDescriptor instead')
const GenerateMessageRequest$json = const {
  '1': 'GenerateMessageRequest',
  '2': const [
    const {'1': 'model', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'model'},
    const {
      '1': 'prompt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.MessagePrompt',
      '8': const {},
      '10': 'prompt'
    },
    const {
      '1': 'temperature',
      '3': 3,
      '4': 1,
      '5': 2,
      '8': const {},
      '9': 0,
      '10': 'temperature',
      '17': true
    },
    const {
      '1': 'candidate_count',
      '3': 4,
      '4': 1,
      '5': 5,
      '8': const {},
      '9': 1,
      '10': 'candidateCount',
      '17': true
    },
    const {
      '1': 'top_p',
      '3': 5,
      '4': 1,
      '5': 2,
      '8': const {},
      '9': 2,
      '10': 'topP',
      '17': true
    },
    const {
      '1': 'top_k',
      '3': 6,
      '4': 1,
      '5': 5,
      '8': const {},
      '9': 3,
      '10': 'topK',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_temperature'},
    const {'1': '_candidate_count'},
    const {'1': '_top_p'},
    const {'1': '_top_k'},
  ],
};

/// Descriptor for `GenerateMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMessageRequestDescriptor =
    $convert.base64Decode(
        'ChZHZW5lcmF0ZU1lc3NhZ2VSZXF1ZXN0EkUKBW1vZGVsGAEgASgJQi/gQQL6QSkKJ2dlbmVyYXRpdmVsYW5ndWFnZS5nb29nbGVhcGlzLmNvbS9Nb2RlbFIFbW9kZWwSUAoGcHJvbXB0GAIgASgLMjMuZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1lc3NhZ2VQcm9tcHRCA+BBAlIGcHJvbXB0EioKC3RlbXBlcmF0dXJlGAMgASgCQgPgQQFIAFILdGVtcGVyYXR1cmWIAQESMQoPY2FuZGlkYXRlX2NvdW50GAQgASgFQgPgQQFIAVIOY2FuZGlkYXRlQ291bnSIAQESHQoFdG9wX3AYBSABKAJCA+BBAUgCUgR0b3BQiAEBEh0KBXRvcF9rGAYgASgFQgPgQQFIA1IEdG9wS4gBAUIOCgxfdGVtcGVyYXR1cmVCEgoQX2NhbmRpZGF0ZV9jb3VudEIICgZfdG9wX3BCCAoGX3RvcF9r');
@$core.Deprecated('Use generateMessageResponseDescriptor instead')
const GenerateMessageResponse$json = const {
  '1': 'GenerateMessageResponse',
  '2': const [
    const {
      '1': 'candidates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Message',
      '10': 'candidates'
    },
    const {
      '1': 'messages',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Message',
      '10': 'messages'
    },
    const {
      '1': 'filters',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.ContentFilter',
      '10': 'filters'
    },
  ],
};

/// Descriptor for `GenerateMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateMessageResponseDescriptor =
    $convert.base64Decode(
        'ChdHZW5lcmF0ZU1lc3NhZ2VSZXNwb25zZRJNCgpjYW5kaWRhdGVzGAEgAygLMi0uZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1lc3NhZ2VSCmNhbmRpZGF0ZXMSSQoIbWVzc2FnZXMYAiADKAsyLS5nb29nbGUuYWkuZ2VuZXJhdGl2ZWxhbmd1YWdlLnYxYmV0YTIuTWVzc2FnZVIIbWVzc2FnZXMSTQoHZmlsdGVycxgDIAMoCzIzLmdvb2dsZS5haS5nZW5lcmF0aXZlbGFuZ3VhZ2UudjFiZXRhMi5Db250ZW50RmlsdGVyUgdmaWx0ZXJz');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {
      '1': 'author',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'author'
    },
    const {
      '1': 'content',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'content'
    },
    const {
      '1': 'citation_metadata',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.CitationMetadata',
      '8': const {},
      '9': 0,
      '10': 'citationMetadata',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_citation_metadata'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhsKBmF1dGhvchgBIAEoCUID4EEBUgZhdXRob3ISHQoHY29udGVudBgCIAEoCUID4EECUgdjb250ZW50Em0KEWNpdGF0aW9uX21ldGFkYXRhGAMgASgLMjYuZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLkNpdGF0aW9uTWV0YWRhdGFCA+BBA0gAUhBjaXRhdGlvbk1ldGFkYXRhiAEBQhQKEl9jaXRhdGlvbl9tZXRhZGF0YQ==');
@$core.Deprecated('Use messagePromptDescriptor instead')
const MessagePrompt$json = const {
  '1': 'MessagePrompt',
  '2': const [
    const {
      '1': 'context',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'context'
    },
    const {
      '1': 'examples',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Example',
      '8': const {},
      '10': 'examples'
    },
    const {
      '1': 'messages',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Message',
      '8': const {},
      '10': 'messages'
    },
  ],
};

/// Descriptor for `MessagePrompt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagePromptDescriptor = $convert.base64Decode(
    'Cg1NZXNzYWdlUHJvbXB0Eh0KB2NvbnRleHQYASABKAlCA+BBAVIHY29udGV4dBJOCghleGFtcGxlcxgCIAMoCzItLmdvb2dsZS5haS5nZW5lcmF0aXZlbGFuZ3VhZ2UudjFiZXRhMi5FeGFtcGxlQgPgQQFSCGV4YW1wbGVzEk4KCG1lc3NhZ2VzGAMgAygLMi0uZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1lc3NhZ2VCA+BBAlIIbWVzc2FnZXM=');
@$core.Deprecated('Use exampleDescriptor instead')
const Example$json = const {
  '1': 'Example',
  '2': const [
    const {
      '1': 'input',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Message',
      '10': 'input'
    },
    const {
      '1': 'output',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.Message',
      '10': 'output'
    },
  ],
};

/// Descriptor for `Example`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exampleDescriptor = $convert.base64Decode(
    'CgdFeGFtcGxlEkMKBWlucHV0GAEgASgLMi0uZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1lc3NhZ2VSBWlucHV0EkUKBm91dHB1dBgCIAEoCzItLmdvb2dsZS5haS5nZW5lcmF0aXZlbGFuZ3VhZ2UudjFiZXRhMi5NZXNzYWdlUgZvdXRwdXQ=');
@$core.Deprecated('Use countMessageTokensRequestDescriptor instead')
const CountMessageTokensRequest$json = const {
  '1': 'CountMessageTokensRequest',
  '2': const [
    const {'1': 'model', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'model'},
    const {
      '1': 'prompt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.MessagePrompt',
      '8': const {},
      '10': 'prompt'
    },
  ],
};

/// Descriptor for `CountMessageTokensRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countMessageTokensRequestDescriptor =
    $convert.base64Decode(
        'ChlDb3VudE1lc3NhZ2VUb2tlbnNSZXF1ZXN0EkUKBW1vZGVsGAEgASgJQi/gQQL6QSkKJ2dlbmVyYXRpdmVsYW5ndWFnZS5nb29nbGVhcGlzLmNvbS9Nb2RlbFIFbW9kZWwSUAoGcHJvbXB0GAIgASgLMjMuZ29vZ2xlLmFpLmdlbmVyYXRpdmVsYW5ndWFnZS52MWJldGEyLk1lc3NhZ2VQcm9tcHRCA+BBAlIGcHJvbXB0');
@$core.Deprecated('Use countMessageTokensResponseDescriptor instead')
const CountMessageTokensResponse$json = const {
  '1': 'CountMessageTokensResponse',
  '2': const [
    const {'1': 'token_count', '3': 1, '4': 1, '5': 5, '10': 'tokenCount'},
  ],
};

/// Descriptor for `CountMessageTokensResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countMessageTokensResponseDescriptor =
    $convert.base64Decode(
        'ChpDb3VudE1lc3NhZ2VUb2tlbnNSZXNwb25zZRIfCgt0b2tlbl9jb3VudBgBIAEoBVIKdG9rZW5Db3VudA==');
