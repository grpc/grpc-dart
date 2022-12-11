///
//  Generated code. Do not modify.
//  source: route_guide.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use pointDescriptor instead')
const Point$json = const {
  '1': 'Point',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 5, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 5, '10': 'longitude'},
  ],
};

/// Descriptor for `Point`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointDescriptor = $convert.base64Decode(
    'CgVQb2ludBIaCghsYXRpdHVkZRgBIAEoBVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgASgFUglsb25naXR1ZGU=');
@$core.Deprecated('Use rectangleDescriptor instead')
const Rectangle$json = const {
  '1': 'Rectangle',
  '2': const [
    const {
      '1': 'lo',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'lo'
    },
    const {
      '1': 'hi',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'hi'
    },
  ],
};

/// Descriptor for `Rectangle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rectangleDescriptor = $convert.base64Decode(
    'CglSZWN0YW5nbGUSIQoCbG8YASABKAsyES5yb3V0ZWd1aWRlLlBvaW50UgJsbxIhCgJoaRgCIAEoCzIRLnJvdXRlZ3VpZGUuUG9pbnRSAmhp');
@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = const {
  '1': 'Feature',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'location',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'location'
    },
  ],
};

/// Descriptor for `Feature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureDescriptor = $convert.base64Decode(
    'CgdGZWF0dXJlEhIKBG5hbWUYASABKAlSBG5hbWUSLQoIbG9jYXRpb24YAiABKAsyES5yb3V0ZWd1aWRlLlBvaW50Ughsb2NhdGlvbg==');
@$core.Deprecated('Use routeNoteDescriptor instead')
const RouteNote$json = const {
  '1': 'RouteNote',
  '2': const [
    const {
      '1': 'location',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'location'
    },
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RouteNote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeNoteDescriptor = $convert.base64Decode(
    'CglSb3V0ZU5vdGUSLQoIbG9jYXRpb24YASABKAsyES5yb3V0ZWd1aWRlLlBvaW50Ughsb2NhdGlvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use routeSummaryDescriptor instead')
const RouteSummary$json = const {
  '1': 'RouteSummary',
  '2': const [
    const {'1': 'point_count', '3': 1, '4': 1, '5': 5, '10': 'pointCount'},
    const {'1': 'feature_count', '3': 2, '4': 1, '5': 5, '10': 'featureCount'},
    const {'1': 'distance', '3': 3, '4': 1, '5': 5, '10': 'distance'},
    const {'1': 'elapsed_time', '3': 4, '4': 1, '5': 5, '10': 'elapsedTime'},
  ],
};

/// Descriptor for `RouteSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeSummaryDescriptor = $convert.base64Decode(
    'CgxSb3V0ZVN1bW1hcnkSHwoLcG9pbnRfY291bnQYASABKAVSCnBvaW50Q291bnQSIwoNZmVhdHVyZV9jb3VudBgCIAEoBVIMZmVhdHVyZUNvdW50EhoKCGRpc3RhbmNlGAMgASgFUghkaXN0YW5jZRIhCgxlbGFwc2VkX3RpbWUYBCABKAVSC2VsYXBzZWRUaW1l');
