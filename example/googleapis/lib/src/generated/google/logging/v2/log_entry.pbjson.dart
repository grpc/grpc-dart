///
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const LogEntry$json = {
  '1': 'LogEntry',
  '2': [
    {'1': 'log_name', '3': 12, '4': 1, '5': 9, '10': 'logName'},
    {
      '1': 'resource',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '10': 'resource'
    },
    {
      '1': 'proto_payload',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'protoPayload'
    },
    {'1': 'text_payload', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'textPayload'},
    {
      '1': 'json_payload',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '9': 0,
      '10': 'jsonPayload'
    },
    {
      '1': 'timestamp',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timestamp'
    },
    {
      '1': 'receive_timestamp',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'receiveTimestamp'
    },
    {
      '1': 'severity',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.logging.type.LogSeverity',
      '10': 'severity'
    },
    {'1': 'insert_id', '3': 4, '4': 1, '5': 9, '10': 'insertId'},
    {
      '1': 'http_request',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.logging.type.HttpRequest',
      '10': 'httpRequest'
    },
    {
      '1': 'labels',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'metadata',
      '3': 25,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResourceMetadata',
      '10': 'metadata'
    },
    {
      '1': 'operation',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntryOperation',
      '10': 'operation'
    },
    {'1': 'trace', '3': 22, '4': 1, '5': 9, '10': 'trace'},
    {'1': 'span_id', '3': 27, '4': 1, '5': 9, '10': 'spanId'},
    {'1': 'trace_sampled', '3': 30, '4': 1, '5': 8, '10': 'traceSampled'},
    {
      '1': 'source_location',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.logging.v2.LogEntrySourceLocation',
      '10': 'sourceLocation'
    },
  ],
  '3': [LogEntry_LabelsEntry$json],
  '8': [
    {'1': 'payload'},
  ],
};

const LogEntry_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

const LogEntryOperation$json = {
  '1': 'LogEntryOperation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'producer', '3': 2, '4': 1, '5': 9, '10': 'producer'},
    {'1': 'first', '3': 3, '4': 1, '5': 8, '10': 'first'},
    {'1': 'last', '3': 4, '4': 1, '5': 8, '10': 'last'},
  ],
};

const LogEntrySourceLocation$json = {
  '1': 'LogEntrySourceLocation',
  '2': [
    {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
    {'1': 'line', '3': 2, '4': 1, '5': 3, '10': 'line'},
    {'1': 'function', '3': 3, '4': 1, '5': 9, '10': 'function'},
  ],
};
