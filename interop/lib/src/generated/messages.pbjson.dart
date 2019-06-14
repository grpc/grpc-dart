///
//  Generated code. Do not modify.
//  source: messages.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const PayloadType$json = {
  '1': 'PayloadType',
  '2': [
    {'1': 'COMPRESSABLE', '2': 0},
  ],
};

const BoolValue$json = {
  '1': 'BoolValue',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

const Payload$json = {
  '1': 'Payload',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.grpc.testing.PayloadType',
      '10': 'type'
    },
    {'1': 'body', '3': 2, '4': 1, '5': 12, '10': 'body'},
  ],
};

const EchoStatus$json = {
  '1': 'EchoStatus',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const SimpleRequest$json = {
  '1': 'SimpleRequest',
  '2': [
    {
      '1': 'response_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.grpc.testing.PayloadType',
      '10': 'responseType'
    },
    {'1': 'response_size', '3': 2, '4': 1, '5': 5, '10': 'responseSize'},
    {
      '1': 'payload',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.Payload',
      '10': 'payload'
    },
    {'1': 'fill_username', '3': 4, '4': 1, '5': 8, '10': 'fillUsername'},
    {'1': 'fill_oauth_scope', '3': 5, '4': 1, '5': 8, '10': 'fillOauthScope'},
    {
      '1': 'response_compressed',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.BoolValue',
      '10': 'responseCompressed'
    },
    {
      '1': 'response_status',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.EchoStatus',
      '10': 'responseStatus'
    },
    {
      '1': 'expect_compressed',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.BoolValue',
      '10': 'expectCompressed'
    },
  ],
};

const SimpleResponse$json = {
  '1': 'SimpleResponse',
  '2': [
    {
      '1': 'payload',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.Payload',
      '10': 'payload'
    },
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'oauth_scope', '3': 3, '4': 1, '5': 9, '10': 'oauthScope'},
  ],
};

const StreamingInputCallRequest$json = {
  '1': 'StreamingInputCallRequest',
  '2': [
    {
      '1': 'payload',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.Payload',
      '10': 'payload'
    },
    {
      '1': 'expect_compressed',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.BoolValue',
      '10': 'expectCompressed'
    },
  ],
};

const StreamingInputCallResponse$json = {
  '1': 'StreamingInputCallResponse',
  '2': [
    {
      '1': 'aggregated_payload_size',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'aggregatedPayloadSize'
    },
  ],
};

const ResponseParameters$json = {
  '1': 'ResponseParameters',
  '2': [
    {'1': 'size', '3': 1, '4': 1, '5': 5, '10': 'size'},
    {'1': 'interval_us', '3': 2, '4': 1, '5': 5, '10': 'intervalUs'},
    {
      '1': 'compressed',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.BoolValue',
      '10': 'compressed'
    },
  ],
};

const StreamingOutputCallRequest$json = {
  '1': 'StreamingOutputCallRequest',
  '2': [
    {
      '1': 'response_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.grpc.testing.PayloadType',
      '10': 'responseType'
    },
    {
      '1': 'response_parameters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.grpc.testing.ResponseParameters',
      '10': 'responseParameters'
    },
    {
      '1': 'payload',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.Payload',
      '10': 'payload'
    },
    {
      '1': 'response_status',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.EchoStatus',
      '10': 'responseStatus'
    },
  ],
};

const StreamingOutputCallResponse$json = {
  '1': 'StreamingOutputCallResponse',
  '2': [
    {
      '1': 'payload',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.grpc.testing.Payload',
      '10': 'payload'
    },
  ],
};

const ReconnectParams$json = {
  '1': 'ReconnectParams',
  '2': [
    {
      '1': 'max_reconnect_backoff_ms',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'maxReconnectBackoffMs'
    },
  ],
};

const ReconnectInfo$json = {
  '1': 'ReconnectInfo',
  '2': [
    {'1': 'passed', '3': 1, '4': 1, '5': 8, '10': 'passed'},
    {'1': 'backoff_ms', '3': 2, '4': 3, '5': 5, '10': 'backoffMs'},
  ],
};
