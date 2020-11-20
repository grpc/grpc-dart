///
//  Generated code. Do not modify.
//  source: google/logging/v2/log_entry.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

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

const LogEntry_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

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
