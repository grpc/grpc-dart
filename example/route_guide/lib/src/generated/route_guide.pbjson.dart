// This is a generated file - do not edit.
//
// Generated from route_guide.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use pointDescriptor instead')
const Point$json = {
  '1': 'Point',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 5, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 5, '10': 'longitude'},
  ],
};

/// Descriptor for `Point`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointDescriptor = $convert.base64Decode(
    'CgVQb2ludBIaCghsYXRpdHVkZRgBIAEoBVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgASgFUg'
    'lsb25naXR1ZGU=');

@$core.Deprecated('Use rectangleDescriptor instead')
const Rectangle$json = {
  '1': 'Rectangle',
  '2': [
    {'1': 'lo', '3': 1, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'lo'},
    {'1': 'hi', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'hi'},
  ],
};

/// Descriptor for `Rectangle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rectangleDescriptor = $convert.base64Decode(
    'CglSZWN0YW5nbGUSIQoCbG8YASABKAsyES5yb3V0ZWd1aWRlLlBvaW50UgJsbxIhCgJoaRgCIA'
    'EoCzIRLnJvdXRlZ3VpZGUuUG9pbnRSAmhp');

@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
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
    'CgdGZWF0dXJlEhIKBG5hbWUYASABKAlSBG5hbWUSLQoIbG9jYXRpb24YAiABKAsyES5yb3V0ZW'
    'd1aWRlLlBvaW50Ughsb2NhdGlvbg==');

@$core.Deprecated('Use routeNoteDescriptor instead')
const RouteNote$json = {
  '1': 'RouteNote',
  '2': [
    {
      '1': 'location',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'location'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RouteNote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeNoteDescriptor = $convert.base64Decode(
    'CglSb3V0ZU5vdGUSLQoIbG9jYXRpb24YASABKAsyES5yb3V0ZWd1aWRlLlBvaW50Ughsb2NhdG'
    'lvbhIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use routeSummaryDescriptor instead')
const RouteSummary$json = {
  '1': 'RouteSummary',
  '2': [
    {'1': 'point_count', '3': 1, '4': 1, '5': 5, '10': 'pointCount'},
    {'1': 'feature_count', '3': 2, '4': 1, '5': 5, '10': 'featureCount'},
    {'1': 'distance', '3': 3, '4': 1, '5': 5, '10': 'distance'},
    {'1': 'elapsed_time', '3': 4, '4': 1, '5': 5, '10': 'elapsedTime'},
  ],
};

/// Descriptor for `RouteSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeSummaryDescriptor = $convert.base64Decode(
    'CgxSb3V0ZVN1bW1hcnkSHwoLcG9pbnRfY291bnQYASABKAVSCnBvaW50Q291bnQSIwoNZmVhdH'
    'VyZV9jb3VudBgCIAEoBVIMZmVhdHVyZUNvdW50EhoKCGRpc3RhbmNlGAMgASgFUghkaXN0YW5j'
    'ZRIhCgxlbGFwc2VkX3RpbWUYBCABKAVSC2VsYXBzZWRUaW1l');
