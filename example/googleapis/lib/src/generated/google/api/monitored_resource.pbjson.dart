///
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use monitoredResourceDescriptorDescriptor instead')
const MonitoredResourceDescriptor$json = const {
  '1': 'MonitoredResourceDescriptor',
  '2': const [
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {
      '1': 'labels',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.LabelDescriptor',
      '10': 'labels'
    },
    const {
      '1': 'launch_stage',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.api.LaunchStage',
      '10': 'launchStage'
    },
  ],
};

/// Descriptor for `MonitoredResourceDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitoredResourceDescriptorDescriptor =
    $convert.base64Decode(
        'ChtNb25pdG9yZWRSZXNvdXJjZURlc2NyaXB0b3ISEgoEbmFtZRgFIAEoCVIEbmFtZRISCgR0eXBlGAEgASgJUgR0eXBlEiEKDGRpc3BsYXlfbmFtZRgCIAEoCVILZGlzcGxheU5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEjMKBmxhYmVscxgEIAMoCzIbLmdvb2dsZS5hcGkuTGFiZWxEZXNjcmlwdG9yUgZsYWJlbHMSOgoMbGF1bmNoX3N0YWdlGAcgASgOMhcuZ29vZ2xlLmFwaS5MYXVuY2hTdGFnZVILbGF1bmNoU3RhZ2U=');
@$core.Deprecated('Use monitoredResourceDescriptor instead')
const MonitoredResource$json = const {
  '1': 'MonitoredResource',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResource.LabelsEntry',
      '10': 'labels'
    },
  ],
  '3': const [MonitoredResource_LabelsEntry$json],
};

@$core.Deprecated('Use monitoredResourceDescriptor instead')
const MonitoredResource_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `MonitoredResource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitoredResourceDescriptor = $convert.base64Decode(
    'ChFNb25pdG9yZWRSZXNvdXJjZRISCgR0eXBlGAEgASgJUgR0eXBlEkEKBmxhYmVscxgCIAMoCzIpLmdvb2dsZS5hcGkuTW9uaXRvcmVkUmVzb3VyY2UuTGFiZWxzRW50cnlSBmxhYmVscxo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
@$core.Deprecated('Use monitoredResourceMetadataDescriptor instead')
const MonitoredResourceMetadata$json = const {
  '1': 'MonitoredResourceMetadata',
  '2': const [
    const {
      '1': 'system_labels',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'systemLabels'
    },
    const {
      '1': 'user_labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResourceMetadata.UserLabelsEntry',
      '10': 'userLabels'
    },
  ],
  '3': const [MonitoredResourceMetadata_UserLabelsEntry$json],
};

@$core.Deprecated('Use monitoredResourceMetadataDescriptor instead')
const MonitoredResourceMetadata_UserLabelsEntry$json = const {
  '1': 'UserLabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `MonitoredResourceMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List monitoredResourceMetadataDescriptor =
    $convert.base64Decode(
        'ChlNb25pdG9yZWRSZXNvdXJjZU1ldGFkYXRhEjwKDXN5c3RlbV9sYWJlbHMYASABKAsyFy5nb29nbGUucHJvdG9idWYuU3RydWN0UgxzeXN0ZW1MYWJlbHMSVgoLdXNlcl9sYWJlbHMYAiADKAsyNS5nb29nbGUuYXBpLk1vbml0b3JlZFJlc291cmNlTWV0YWRhdGEuVXNlckxhYmVsc0VudHJ5Ugp1c2VyTGFiZWxzGj0KD1VzZXJMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
