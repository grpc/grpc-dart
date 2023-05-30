///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/citation.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use citationMetadataDescriptor instead')
const CitationMetadata$json = const {
  '1': 'CitationMetadata',
  '2': const [
    const {
      '1': 'citation_sources',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.ai.generativelanguage.v1beta2.CitationSource',
      '10': 'citationSources'
    },
  ],
};

/// Descriptor for `CitationMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List citationMetadataDescriptor = $convert.base64Decode(
    'ChBDaXRhdGlvbk1ldGFkYXRhEl8KEGNpdGF0aW9uX3NvdXJjZXMYASADKAsyNC5nb29nbGUuYWkuZ2VuZXJhdGl2ZWxhbmd1YWdlLnYxYmV0YTIuQ2l0YXRpb25Tb3VyY2VSD2NpdGF0aW9uU291cmNlcw==');
@$core.Deprecated('Use citationSourceDescriptor instead')
const CitationSource$json = const {
  '1': 'CitationSource',
  '2': const [
    const {
      '1': 'start_index',
      '3': 1,
      '4': 1,
      '5': 5,
      '8': const {},
      '9': 0,
      '10': 'startIndex',
      '17': true
    },
    const {
      '1': 'end_index',
      '3': 2,
      '4': 1,
      '5': 5,
      '8': const {},
      '9': 1,
      '10': 'endIndex',
      '17': true
    },
    const {
      '1': 'uri',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': const {},
      '9': 2,
      '10': 'uri',
      '17': true
    },
    const {
      '1': 'license',
      '3': 4,
      '4': 1,
      '5': 9,
      '8': const {},
      '9': 3,
      '10': 'license',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_start_index'},
    const {'1': '_end_index'},
    const {'1': '_uri'},
    const {'1': '_license'},
  ],
};

/// Descriptor for `CitationSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List citationSourceDescriptor = $convert.base64Decode(
    'Cg5DaXRhdGlvblNvdXJjZRIpCgtzdGFydF9pbmRleBgBIAEoBUID4EEBSABSCnN0YXJ0SW5kZXiIAQESJQoJZW5kX2luZGV4GAIgASgFQgPgQQFIAVIIZW5kSW5kZXiIAQESGgoDdXJpGAMgASgJQgPgQQFIAlIDdXJpiAEBEiIKB2xpY2Vuc2UYBCABKAlCA+BBAUgDUgdsaWNlbnNliAEBQg4KDF9zdGFydF9pbmRleEIMCgpfZW5kX2luZGV4QgYKBF91cmlCCgoIX2xpY2Vuc2U=');
