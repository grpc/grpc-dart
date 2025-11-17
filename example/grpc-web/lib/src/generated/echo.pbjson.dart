// This is a generated file - do not edit.
//
// Generated from echo.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use echoRequestDescriptor instead')
const EchoRequest$json = {
  '1': 'EchoRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoRequestDescriptor = $convert
    .base64Decode('CgtFY2hvUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use echoResponseDescriptor instead')
const EchoResponse$json = {
  '1': 'EchoResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoResponseDescriptor = $convert
    .base64Decode('CgxFY2hvUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use serverStreamingEchoRequestDescriptor instead')
const ServerStreamingEchoRequest$json = {
  '1': 'ServerStreamingEchoRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'message_count', '3': 2, '4': 1, '5': 5, '10': 'messageCount'},
    {'1': 'message_interval', '3': 3, '4': 1, '5': 5, '10': 'messageInterval'},
  ],
};

/// Descriptor for `ServerStreamingEchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverStreamingEchoRequestDescriptor =
    $convert.base64Decode(
        'ChpTZXJ2ZXJTdHJlYW1pbmdFY2hvUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEi'
        'MKDW1lc3NhZ2VfY291bnQYAiABKAVSDG1lc3NhZ2VDb3VudBIpChBtZXNzYWdlX2ludGVydmFs'
        'GAMgASgFUg9tZXNzYWdlSW50ZXJ2YWw=');

@$core.Deprecated('Use serverStreamingEchoResponseDescriptor instead')
const ServerStreamingEchoResponse$json = {
  '1': 'ServerStreamingEchoResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ServerStreamingEchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverStreamingEchoResponseDescriptor =
    $convert.base64Decode(
        'ChtTZXJ2ZXJTdHJlYW1pbmdFY2hvUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ'
        '==');
