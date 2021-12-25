///
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry$json = const {
  '1': 'LogEntry',
  '2': const [
    const {
      '1': 'log_name',
      '3': 12,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'logName'
    },
    const {
      '1': 'resource',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '8': const {},
      '10': 'resource'
    },
    const {
      '1': 'proto_payload',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'protoPayload'
    },
    const {
      '1': 'text_payload',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'textPayload'
    },
    const {
      '1': 'json_payload',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '9': 0,
      '10': 'jsonPayload'
    },
    const {
      '1': 'timestamp',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': const {},
      '10': 'timestamp'
    },
    const {
      '1': 'receive_timestamp',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': const {},
      '10': 'receiveTimestamp'
    },
    const {
      '1': 'severity',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.logging.type.LogSeverity',
      '8': const {},
      '10': 'severity'
    },
    const {
      '1': 'insert_id',
      '3': 4,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'insertId'
    },
    const {
      '1': 'http_request',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.logging.type.HttpRequest',
      '8': const {},
      '10': 'httpRequest'
    },
    const {
      '1': 'labels',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry.LabelsEntry',
      '8': const {},
      '10': 'labels'
    },
    const {
      '1': 'operation',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntryOperation',
      '8': const {},
      '10': 'operation'
    },
    const {'1': 'trace', '3': 22, '4': 1, '5': 9, '8': const {}, '10': 'trace'},
    const {
      '1': 'span_id',
      '3': 27,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'spanId'
    },
    const {
      '1': 'trace_sampled',
      '3': 30,
      '4': 1,
      '5': 8,
      '8': const {},
      '10': 'traceSampled'
    },
    const {
      '1': 'source_location',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntrySourceLocation',
      '8': const {},
      '10': 'sourceLocation'
    },
  ],
  '3': const [LogEntry_LabelsEntry$json],
  '7': const {},
  '8': const [
    const {'1': 'payload'},
  ],
};

@$core.Deprecated('Use logEntryDescriptor instead')
const LogEntry_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `LogEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryDescriptor = $convert.base64Decode(
    'CghMb2dFbnRyeRIeCghsb2dfbmFtZRgMIAEoCUID4EECUgdsb2dOYW1lEj4KCHJlc291cmNlGAggASgLMh0uZ29vZ2xlLmFwaS5Nb25pdG9yZWRSZXNvdXJjZUID4EECUghyZXNvdXJjZRI7Cg1wcm90b19wYXlsb2FkGAIgASgLMhQuZ29vZ2xlLnByb3RvYnVmLkFueUgAUgxwcm90b1BheWxvYWQSIwoMdGV4dF9wYXlsb2FkGAMgASgJSABSC3RleHRQYXlsb2FkEjwKDGpzb25fcGF5bG9hZBgGIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RIAFILanNvblBheWxvYWQSPQoJdGltZXN0YW1wGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEBUgl0aW1lc3RhbXASTAoRcmVjZWl2ZV90aW1lc3RhbXAYGCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wQgPgQQNSEHJlY2VpdmVUaW1lc3RhbXASQQoIc2V2ZXJpdHkYCiABKA4yIC5nb29nbGUubG9nZ2luZy50eXBlLkxvZ1NldmVyaXR5QgPgQQFSCHNldmVyaXR5EiAKCWluc2VydF9pZBgEIAEoCUID4EEBUghpbnNlcnRJZBJICgxodHRwX3JlcXVlc3QYByABKAsyIC5nb29nbGUubG9nZ2luZy50eXBlLkh0dHBSZXF1ZXN0QgPgQQFSC2h0dHBSZXF1ZXN0EkQKBmxhYmVscxgLIAMoCzInLmdvb2dsZS5sb2dnaW5nLnYyLkxvZ0VudHJ5LkxhYmVsc0VudHJ5QgPgQQFSBmxhYmVscxJHCglvcGVyYXRpb24YDyABKAsyJC5nb29nbGUubG9nZ2luZy52Mi5Mb2dFbnRyeU9wZXJhdGlvbkID4EEBUglvcGVyYXRpb24SGQoFdHJhY2UYFiABKAlCA+BBAVIFdHJhY2USHAoHc3Bhbl9pZBgbIAEoCUID4EEBUgZzcGFuSWQSKAoNdHJhY2Vfc2FtcGxlZBgeIAEoCEID4EEBUgx0cmFjZVNhbXBsZWQSVwoPc291cmNlX2xvY2F0aW9uGBcgASgLMikuZ29vZ2xlLmxvZ2dpbmcudjIuTG9nRW50cnlTb3VyY2VMb2NhdGlvbkID4EEBUg5zb3VyY2VMb2NhdGlvbho5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBOr0B6kG5AQoabG9nZ2luZy5nb29nbGVhcGlzLmNvbS9Mb2cSHXByb2plY3RzL3twcm9qZWN0fS9sb2dzL3tsb2d9Eidvcmdhbml6YXRpb25zL3tvcmdhbml6YXRpb259L2xvZ3Mve2xvZ30SG2ZvbGRlcnMve2ZvbGRlcn0vbG9ncy97bG9nfRIsYmlsbGluZ0FjY291bnRzL3tiaWxsaW5nX2FjY291bnR9L2xvZ3Mve2xvZ30aCGxvZ19uYW1lQgkKB3BheWxvYWQ=');
@$core.Deprecated('Use logEntryOperationDescriptor instead')
const LogEntryOperation$json = const {
  '1': 'LogEntryOperation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'id'},
    const {
      '1': 'producer',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'producer'
    },
    const {'1': 'first', '3': 3, '4': 1, '5': 8, '8': const {}, '10': 'first'},
    const {'1': 'last', '3': 4, '4': 1, '5': 8, '8': const {}, '10': 'last'},
  ],
};

/// Descriptor for `LogEntryOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryOperationDescriptor = $convert.base64Decode(
    'ChFMb2dFbnRyeU9wZXJhdGlvbhITCgJpZBgBIAEoCUID4EEBUgJpZBIfCghwcm9kdWNlchgCIAEoCUID4EEBUghwcm9kdWNlchIZCgVmaXJzdBgDIAEoCEID4EEBUgVmaXJzdBIXCgRsYXN0GAQgASgIQgPgQQFSBGxhc3Q=');
@$core.Deprecated('Use logEntrySourceLocationDescriptor instead')
const LogEntrySourceLocation$json = const {
  '1': 'LogEntrySourceLocation',
  '2': const [
    const {'1': 'file', '3': 1, '4': 1, '5': 9, '8': const {}, '10': 'file'},
    const {'1': 'line', '3': 2, '4': 1, '5': 3, '8': const {}, '10': 'line'},
    const {
      '1': 'function',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': const {},
      '10': 'function'
    },
  ],
};

/// Descriptor for `LogEntrySourceLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntrySourceLocationDescriptor =
    $convert.base64Decode(
        'ChZMb2dFbnRyeVNvdXJjZUxvY2F0aW9uEhcKBGZpbGUYASABKAlCA+BBAVIEZmlsZRIXCgRsaW5lGAIgASgDQgPgQQFSBGxpbmUSHwoIZnVuY3Rpb24YAyABKAlCA+BBAVIIZnVuY3Rpb24=');
