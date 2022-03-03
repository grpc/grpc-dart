///
//  Generated code. Do not modify.
//  source: google/logging/v2/logging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deleteLogRequestDescriptor instead')
const DeleteLogRequest$json = const {
  '1': 'DeleteLogRequest',
  '2': const [
    const {
      '1': 'log_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'logName'
    },
  ],
};

/// Descriptor for `DeleteLogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteLogRequestDescriptor = $convert.base64Decode(
    'ChBEZWxldGVMb2dSZXF1ZXN0Ej0KCGxvZ19uYW1lGAEgASgJQiLgQQL6QRwKGmxvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nUgdsb2dOYW1l');
@$core.Deprecated('Use writeLogEntriesRequestDescriptor instead')
const WriteLogEntriesRequest$json = const {
  '1': 'WriteLogEntriesRequest',
  '2': const [
    const {
      '1': 'log_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'logName'
    },
    const {
      '1': 'resource',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '8': const {},
      '10': 'resource'
    },
    const {
      '1': 'labels',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.WriteLogEntriesRequest.LabelsEntry',
      '8': const {},
      '10': 'labels'
    },
    const {
      '1': 'entries',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry',
      '8': const {},
      '10': 'entries'
    },
    const {
      '1': 'partial_success',
      '3': 5,
      '4': 1,
      '5': 8,
      '8': const {},
      '10': 'partialSuccess'
    },
    const {
      '1': 'dry_run',
      '3': 6,
      '4': 1,
      '5': 8,
      '8': const {},
      '10': 'dryRun'
    },
  ],
  '3': const [WriteLogEntriesRequest_LabelsEntry$json],
};

@$core.Deprecated('Use writeLogEntriesRequestDescriptor instead')
const WriteLogEntriesRequest_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `WriteLogEntriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeLogEntriesRequestDescriptor =
    $convert.base64Decode(
        'ChZXcml0ZUxvZ0VudHJpZXNSZXF1ZXN0Ej0KCGxvZ19uYW1lGAEgASgJQiLgQQH6QRwKGmxvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nUgdsb2dOYW1lEj4KCHJlc291cmNlGAIgASgLMh0uZ29vZ2xlLmFwaS5Nb25pdG9yZWRSZXNvdXJjZUID4EEBUghyZXNvdXJjZRJSCgZsYWJlbHMYAyADKAsyNS5nb29nbGUubG9nZ2luZy52Mi5Xcml0ZUxvZ0VudHJpZXNSZXF1ZXN0LkxhYmVsc0VudHJ5QgPgQQFSBmxhYmVscxI6CgdlbnRyaWVzGAQgAygLMhsuZ29vZ2xlLmxvZ2dpbmcudjIuTG9nRW50cnlCA+BBAlIHZW50cmllcxIsCg9wYXJ0aWFsX3N1Y2Nlc3MYBSABKAhCA+BBAVIOcGFydGlhbFN1Y2Nlc3MSHAoHZHJ5X3J1bhgGIAEoCEID4EEBUgZkcnlSdW4aOQoLTGFiZWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use writeLogEntriesResponseDescriptor instead')
const WriteLogEntriesResponse$json = const {
  '1': 'WriteLogEntriesResponse',
};

/// Descriptor for `WriteLogEntriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeLogEntriesResponseDescriptor =
    $convert.base64Decode('ChdXcml0ZUxvZ0VudHJpZXNSZXNwb25zZQ==');
@$core.Deprecated('Use writeLogEntriesPartialErrorsDescriptor instead')
const WriteLogEntriesPartialErrors$json = const {
  '1': 'WriteLogEntriesPartialErrors',
  '2': const [
    const {
      '1': 'log_entry_errors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6':
          '.google.logging.v2.WriteLogEntriesPartialErrors.LogEntryErrorsEntry',
      '10': 'logEntryErrors'
    },
  ],
  '3': const [WriteLogEntriesPartialErrors_LogEntryErrorsEntry$json],
};

@$core.Deprecated('Use writeLogEntriesPartialErrorsDescriptor instead')
const WriteLogEntriesPartialErrors_LogEntryErrorsEntry$json = const {
  '1': 'LogEntryErrorsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    const {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'value'
    },
  ],
  '7': const {'7': true},
};

/// Descriptor for `WriteLogEntriesPartialErrors`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List writeLogEntriesPartialErrorsDescriptor =
    $convert.base64Decode(
        'ChxXcml0ZUxvZ0VudHJpZXNQYXJ0aWFsRXJyb3JzEm0KEGxvZ19lbnRyeV9lcnJvcnMYASADKAsyQy5nb29nbGUubG9nZ2luZy52Mi5Xcml0ZUxvZ0VudHJpZXNQYXJ0aWFsRXJyb3JzLkxvZ0VudHJ5RXJyb3JzRW50cnlSDmxvZ0VudHJ5RXJyb3JzGlUKE0xvZ0VudHJ5RXJyb3JzRW50cnkSEAoDa2V5GAEgASgFUgNrZXkSKAoFdmFsdWUYAiABKAsyEi5nb29nbGUucnBjLlN0YXR1c1IFdmFsdWU6AjgB');
@$core.Deprecated('Use listLogEntriesRequestDescriptor instead')
const ListLogEntriesRequest$json = const {
  '1': 'ListLogEntriesRequest',
  '2': const [
    const {
      '1': 'resource_names',
      '3': 8,
      '4': 3,
      '5': 9,
      '8': const {},
      '10': 'resourceNames'
    },
    const {
      '1': 'filter',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'filter'
    },
    const {
      '1': 'order_by',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'orderBy'
    },
    const {
      '1': 'page_size',
      '3': 4,
      '4': 1,
      '5': 5,
      '8': const {},
      '10': 'pageSize'
    },
    const {
      '1': 'page_token',
      '3': 5,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'pageToken'
    },
  ],
};

/// Descriptor for `ListLogEntriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogEntriesRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0TG9nRW50cmllc1JlcXVlc3QSSQoOcmVzb3VyY2VfbmFtZXMYCCADKAlCIuBBAvpBHBIabG9nZ2luZy5nb29nbGVhcGlzLmNvbS9Mb2dSDXJlc291cmNlTmFtZXMSGwoGZmlsdGVyGAIgASgJQgPgQQFSBmZpbHRlchIeCghvcmRlcl9ieRgDIAEoCUID4EEBUgdvcmRlckJ5EiAKCXBhZ2Vfc2l6ZRgEIAEoBUID4EEBUghwYWdlU2l6ZRIiCgpwYWdlX3Rva2VuGAUgASgJQgPgQQFSCXBhZ2VUb2tlbg==');
@$core.Deprecated('Use listLogEntriesResponseDescriptor instead')
const ListLogEntriesResponse$json = const {
  '1': 'ListLogEntriesResponse',
  '2': const [
    const {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry',
      '10': 'entries'
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

/// Descriptor for `ListLogEntriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogEntriesResponseDescriptor =
    $convert.base64Decode(
        'ChZMaXN0TG9nRW50cmllc1Jlc3BvbnNlEjUKB2VudHJpZXMYASADKAsyGy5nb29nbGUubG9nZ2luZy52Mi5Mb2dFbnRyeVIHZW50cmllcxImCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAlSDW5leHRQYWdlVG9rZW4=');
@$core
    .Deprecated('Use listMonitoredResourceDescriptorsRequestDescriptor instead')
const ListMonitoredResourceDescriptorsRequest$json = const {
  '1': 'ListMonitoredResourceDescriptorsRequest',
  '2': const [
    const {
      '1': 'page_size',
      '3': 1,
      '4': 1,
      '5': 5,
      '8': const {},
      '10': 'pageSize'
    },
    const {
      '1': 'page_token',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'pageToken'
    },
  ],
};

/// Descriptor for `ListMonitoredResourceDescriptorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMonitoredResourceDescriptorsRequestDescriptor =
    $convert.base64Decode(
        'CidMaXN0TW9uaXRvcmVkUmVzb3VyY2VEZXNjcmlwdG9yc1JlcXVlc3QSIAoJcGFnZV9zaXplGAEgASgFQgPgQQFSCHBhZ2VTaXplEiIKCnBhZ2VfdG9rZW4YAiABKAlCA+BBAVIJcGFnZVRva2Vu');
@$core.Deprecated(
    'Use listMonitoredResourceDescriptorsResponseDescriptor instead')
const ListMonitoredResourceDescriptorsResponse$json = const {
  '1': 'ListMonitoredResourceDescriptorsResponse',
  '2': const [
    const {
      '1': 'resource_descriptors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.api.MonitoredResourceDescriptor',
      '10': 'resourceDescriptors'
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

/// Descriptor for `ListMonitoredResourceDescriptorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMonitoredResourceDescriptorsResponseDescriptor =
    $convert.base64Decode(
        'CihMaXN0TW9uaXRvcmVkUmVzb3VyY2VEZXNjcmlwdG9yc1Jlc3BvbnNlEloKFHJlc291cmNlX2Rlc2NyaXB0b3JzGAEgAygLMicuZ29vZ2xlLmFwaS5Nb25pdG9yZWRSZXNvdXJjZURlc2NyaXB0b3JSE3Jlc291cmNlRGVzY3JpcHRvcnMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');
@$core.Deprecated('Use listLogsRequestDescriptor instead')
const ListLogsRequest$json = const {
  '1': 'ListLogsRequest',
  '2': const [
    const {
      '1': 'parent',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'parent'
    },
    const {
      '1': 'page_size',
      '3': 2,
      '4': 1,
      '5': 5,
      '8': const {},
      '10': 'pageSize'
    },
    const {
      '1': 'page_token',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'pageToken'
    },
    const {
      '1': 'resource_names',
      '3': 8,
      '4': 3,
      '5': 9,
      '8': const {},
      '10': 'resourceNames'
    },
  ],
};

/// Descriptor for `ListLogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogsRequestDescriptor = $convert.base64Decode(
    'Cg9MaXN0TG9nc1JlcXVlc3QSOgoGcGFyZW50GAEgASgJQiLgQQL6QRwSGmxvZ2dpbmcuZ29vZ2xlYXBpcy5jb20vTG9nUgZwYXJlbnQSIAoJcGFnZV9zaXplGAIgASgFQgPgQQFSCHBhZ2VTaXplEiIKCnBhZ2VfdG9rZW4YAyABKAlCA+BBAVIJcGFnZVRva2VuEioKDnJlc291cmNlX25hbWVzGAggAygJQgPgQQFSDXJlc291cmNlTmFtZXM=');
@$core.Deprecated('Use listLogsResponseDescriptor instead')
const ListLogsResponse$json = const {
  '1': 'ListLogsResponse',
  '2': const [
    const {'1': 'log_names', '3': 3, '4': 3, '5': 9, '10': 'logNames'},
    const {
      '1': 'next_page_token',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'nextPageToken'
    },
  ],
};

/// Descriptor for `ListLogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLogsResponseDescriptor = $convert.base64Decode(
    'ChBMaXN0TG9nc1Jlc3BvbnNlEhsKCWxvZ19uYW1lcxgDIAMoCVIIbG9nTmFtZXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');
@$core.Deprecated('Use tailLogEntriesRequestDescriptor instead')
const TailLogEntriesRequest$json = const {
  '1': 'TailLogEntriesRequest',
  '2': const [
    const {
      '1': 'resource_names',
      '3': 1,
      '4': 3,
      '5': 9,
      '8': const {},
      '10': 'resourceNames'
    },
    const {
      '1': 'filter',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'filter'
    },
    const {
      '1': 'buffer_window',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '8': const {},
      '10': 'bufferWindow'
    },
  ],
};

/// Descriptor for `TailLogEntriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tailLogEntriesRequestDescriptor = $convert.base64Decode(
    'ChVUYWlsTG9nRW50cmllc1JlcXVlc3QSKgoOcmVzb3VyY2VfbmFtZXMYASADKAlCA+BBAlINcmVzb3VyY2VOYW1lcxIbCgZmaWx0ZXIYAiABKAlCA+BBAVIGZmlsdGVyEkMKDWJ1ZmZlcl93aW5kb3cYAyABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25CA+BBAVIMYnVmZmVyV2luZG93');
@$core.Deprecated('Use tailLogEntriesResponseDescriptor instead')
const TailLogEntriesResponse$json = const {
  '1': 'TailLogEntriesResponse',
  '2': const [
    const {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry',
      '10': 'entries'
    },
    const {
      '1': 'suppression_info',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.TailLogEntriesResponse.SuppressionInfo',
      '10': 'suppressionInfo'
    },
  ],
  '3': const [TailLogEntriesResponse_SuppressionInfo$json],
};

@$core.Deprecated('Use tailLogEntriesResponseDescriptor instead')
const TailLogEntriesResponse_SuppressionInfo$json = const {
  '1': 'SuppressionInfo',
  '2': const [
    const {
      '1': 'reason',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.logging.v2.TailLogEntriesResponse.SuppressionInfo.Reason',
      '10': 'reason'
    },
    const {
      '1': 'suppressed_count',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'suppressedCount'
    },
  ],
  '4': const [TailLogEntriesResponse_SuppressionInfo_Reason$json],
};

@$core.Deprecated('Use tailLogEntriesResponseDescriptor instead')
const TailLogEntriesResponse_SuppressionInfo_Reason$json = const {
  '1': 'Reason',
  '2': const [
    const {'1': 'REASON_UNSPECIFIED', '2': 0},
    const {'1': 'RATE_LIMIT', '2': 1},
    const {'1': 'NOT_CONSUMED', '2': 2},
  ],
};

/// Descriptor for `TailLogEntriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tailLogEntriesResponseDescriptor =
    $convert.base64Decode(
        'ChZUYWlsTG9nRW50cmllc1Jlc3BvbnNlEjUKB2VudHJpZXMYASADKAsyGy5nb29nbGUubG9nZ2luZy52Mi5Mb2dFbnRyeVIHZW50cmllcxJkChBzdXBwcmVzc2lvbl9pbmZvGAIgAygLMjkuZ29vZ2xlLmxvZ2dpbmcudjIuVGFpbExvZ0VudHJpZXNSZXNwb25zZS5TdXBwcmVzc2lvbkluZm9SD3N1cHByZXNzaW9uSW5mbxraAQoPU3VwcHJlc3Npb25JbmZvElgKBnJlYXNvbhgBIAEoDjJALmdvb2dsZS5sb2dnaW5nLnYyLlRhaWxMb2dFbnRyaWVzUmVzcG9uc2UuU3VwcHJlc3Npb25JbmZvLlJlYXNvblIGcmVhc29uEikKEHN1cHByZXNzZWRfY291bnQYAiABKAVSD3N1cHByZXNzZWRDb3VudCJCCgZSZWFzb24SFgoSUkVBU09OX1VOU1BFQ0lGSUVEEAASDgoKUkFURV9MSU1JVBABEhAKDE5PVF9DT05TVU1FRBAC');
