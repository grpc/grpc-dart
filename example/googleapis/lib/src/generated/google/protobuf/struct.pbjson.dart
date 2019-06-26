///
//  Generated code. Do not modify.
//  source: google/protobuf/struct.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const NullValue$json = {
  '1': 'NullValue',
  '2': [
    {'1': 'NULL_VALUE', '2': 0},
  ],
};

const Struct$json = {
  '1': 'Struct',
  '2': [
    {
      '1': 'fields',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Struct.FieldsEntry',
      '10': 'fields'
    },
  ],
  '3': [Struct_FieldsEntry$json],
};

const Struct_FieldsEntry$json = {
  '1': 'FieldsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

const Value$json = {
  '1': 'Value',
  '2': [
    {
      '1': 'null_value',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.protobuf.NullValue',
      '9': 0,
      '10': 'nullValue'
    },
    {'1': 'number_value', '3': 2, '4': 1, '5': 1, '9': 0, '10': 'numberValue'},
    {'1': 'string_value', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'stringValue'},
    {'1': 'bool_value', '3': 4, '4': 1, '5': 8, '9': 0, '10': 'boolValue'},
    {
      '1': 'struct_value',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '9': 0,
      '10': 'structValue'
    },
    {
      '1': 'list_value',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.ListValue',
      '9': 0,
      '10': 'listValue'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

const ListValue$json = {
  '1': 'ListValue',
  '2': [
    {
      '1': 'values',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Value',
      '10': 'values'
    },
  ],
};
