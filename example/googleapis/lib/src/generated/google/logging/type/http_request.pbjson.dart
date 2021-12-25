///
//  Generated code. Do not modify.
//  source: google/logging/type/http_request.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use httpRequestDescriptor instead')
const HttpRequest$json = const {
  '1': 'HttpRequest',
  '2': const [
    const {
      '1': 'request_method',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'requestMethod'
    },
    const {'1': 'request_url', '3': 2, '4': 1, '5': 9, '10': 'requestUrl'},
    const {'1': 'request_size', '3': 3, '4': 1, '5': 3, '10': 'requestSize'},
    const {'1': 'status', '3': 4, '4': 1, '5': 5, '10': 'status'},
    const {'1': 'response_size', '3': 5, '4': 1, '5': 3, '10': 'responseSize'},
    const {'1': 'user_agent', '3': 6, '4': 1, '5': 9, '10': 'userAgent'},
    const {'1': 'remote_ip', '3': 7, '4': 1, '5': 9, '10': 'remoteIp'},
    const {'1': 'server_ip', '3': 13, '4': 1, '5': 9, '10': 'serverIp'},
    const {'1': 'referer', '3': 8, '4': 1, '5': 9, '10': 'referer'},
    const {
      '1': 'latency',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'latency'
    },
    const {'1': 'cache_lookup', '3': 11, '4': 1, '5': 8, '10': 'cacheLookup'},
    const {'1': 'cache_hit', '3': 9, '4': 1, '5': 8, '10': 'cacheHit'},
    const {
      '1': 'cache_validated_with_origin_server',
      '3': 10,
      '4': 1,
      '5': 8,
      '10': 'cacheValidatedWithOriginServer'
    },
    const {
      '1': 'cache_fill_bytes',
      '3': 12,
      '4': 1,
      '5': 3,
      '10': 'cacheFillBytes'
    },
    const {'1': 'protocol', '3': 15, '4': 1, '5': 9, '10': 'protocol'},
  ],
};

/// Descriptor for `HttpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List httpRequestDescriptor = $convert.base64Decode(
    'CgtIdHRwUmVxdWVzdBIlCg5yZXF1ZXN0X21ldGhvZBgBIAEoCVINcmVxdWVzdE1ldGhvZBIfCgtyZXF1ZXN0X3VybBgCIAEoCVIKcmVxdWVzdFVybBIhCgxyZXF1ZXN0X3NpemUYAyABKANSC3JlcXVlc3RTaXplEhYKBnN0YXR1cxgEIAEoBVIGc3RhdHVzEiMKDXJlc3BvbnNlX3NpemUYBSABKANSDHJlc3BvbnNlU2l6ZRIdCgp1c2VyX2FnZW50GAYgASgJUgl1c2VyQWdlbnQSGwoJcmVtb3RlX2lwGAcgASgJUghyZW1vdGVJcBIbCglzZXJ2ZXJfaXAYDSABKAlSCHNlcnZlcklwEhgKB3JlZmVyZXIYCCABKAlSB3JlZmVyZXISMwoHbGF0ZW5jeRgOIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIHbGF0ZW5jeRIhCgxjYWNoZV9sb29rdXAYCyABKAhSC2NhY2hlTG9va3VwEhsKCWNhY2hlX2hpdBgJIAEoCFIIY2FjaGVIaXQSSgoiY2FjaGVfdmFsaWRhdGVkX3dpdGhfb3JpZ2luX3NlcnZlchgKIAEoCFIeY2FjaGVWYWxpZGF0ZWRXaXRoT3JpZ2luU2VydmVyEigKEGNhY2hlX2ZpbGxfYnl0ZXMYDCABKANSDmNhY2hlRmlsbEJ5dGVzEhoKCHByb3RvY29sGA8gASgJUghwcm90b2NvbA==');
