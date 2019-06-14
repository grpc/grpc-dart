///
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const MonitoredResourceDescriptor$json = {
  '1': 'MonitoredResourceDescriptor',
  '2': [
    {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {
      '1': 'labels',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.api.LabelDescriptor',
      '10': 'labels'
    },
    {
      '1': 'launch_stage',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.api.LaunchStage',
      '10': 'launchStage'
    },
  ],
};

const MonitoredResource$json = {
  '1': 'MonitoredResource',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {
      '1': 'labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResource.LabelsEntry',
      '10': 'labels'
    },
  ],
  '3': [MonitoredResource_LabelsEntry$json],
};

const MonitoredResource_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

const MonitoredResourceMetadata$json = {
  '1': 'MonitoredResourceMetadata',
  '2': [
    {
      '1': 'system_labels',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'systemLabels'
    },
    {
      '1': 'user_labels',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResourceMetadata.UserLabelsEntry',
      '10': 'userLabels'
    },
  ],
  '3': [MonitoredResourceMetadata_UserLabelsEntry$json],
};

const MonitoredResourceMetadata_UserLabelsEntry$json = {
  '1': 'UserLabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};
