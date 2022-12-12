///
//  Generated code. Do not modify.
//  source: echo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use echoRequestDescriptor instead')
const EchoRequest$json = const {
  '1': 'EchoRequest',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoRequestDescriptor = $convert
    .base64Decode('CgtFY2hvUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use echoResponseDescriptor instead')
const EchoResponse$json = const {
  '1': 'EchoResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoResponseDescriptor = $convert
    .base64Decode('CgxFY2hvUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use serverStreamingEchoRequestDescriptor instead')
const ServerStreamingEchoRequest$json = const {
  '1': 'ServerStreamingEchoRequest',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'message_count', '3': 2, '4': 1, '5': 5, '10': 'messageCount'},
    const {
      '1': 'message_interval',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'messageInterval'
    },
  ],
};

/// Descriptor for `ServerStreamingEchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverStreamingEchoRequestDescriptor =
    $convert.base64Decode(
        'ChpTZXJ2ZXJTdHJlYW1pbmdFY2hvUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEiMKDW1lc3NhZ2VfY291bnQYAiABKAVSDG1lc3NhZ2VDb3VudBIpChBtZXNzYWdlX2ludGVydmFsGAMgASgFUg9tZXNzYWdlSW50ZXJ2YWw=');
@$core.Deprecated('Use serverStreamingEchoResponseDescriptor instead')
const ServerStreamingEchoResponse$json = const {
  '1': 'ServerStreamingEchoResponse',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ServerStreamingEchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverStreamingEchoResponseDescriptor =
    $convert.base64Decode(
        'ChtTZXJ2ZXJTdHJlYW1pbmdFY2hvUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');
