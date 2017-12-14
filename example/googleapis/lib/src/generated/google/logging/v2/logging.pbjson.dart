///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.v2_logging_pbjson;

const DeleteLogRequest$json = const {
  '1': 'DeleteLogRequest',
  '2': const [
    const {'1': 'log_name', '3': 1, '4': 1, '5': 9, '10': 'logName'},
  ],
};

const WriteLogEntriesRequest$json = const {
  '1': 'WriteLogEntriesRequest',
  '2': const [
    const {'1': 'log_name', '3': 1, '4': 1, '5': 9, '10': 'logName'},
    const {
      '1': 'resource',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '10': 'resource'
    },
    const {
      '1': 'labels',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.WriteLogEntriesRequest.LabelsEntry',
      '10': 'labels'
    },
    const {
      '1': 'entries',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.google.logging.v2.LogEntry',
      '10': 'entries'
    },
    const {
      '1': 'partial_success',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'partialSuccess'
    },
  ],
  '3': const [WriteLogEntriesRequest_LabelsEntry$json],
};

const WriteLogEntriesRequest_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

const WriteLogEntriesResponse$json = const {
  '1': 'WriteLogEntriesResponse',
};

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

const ListLogEntriesRequest$json = const {
  '1': 'ListLogEntriesRequest',
  '2': const [
    const {'1': 'project_ids', '3': 1, '4': 3, '5': 9, '10': 'projectIds'},
    const {
      '1': 'resource_names',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'resourceNames'
    },
    const {'1': 'filter', '3': 2, '4': 1, '5': 9, '10': 'filter'},
    const {'1': 'order_by', '3': 3, '4': 1, '5': 9, '10': 'orderBy'},
    const {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

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

const ListMonitoredResourceDescriptorsRequest$json = const {
  '1': 'ListMonitoredResourceDescriptorsRequest',
  '2': const [
    const {'1': 'page_size', '3': 1, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

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

const ListLogsRequest$json = const {
  '1': 'ListLogsRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9, '10': 'parent'},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

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
