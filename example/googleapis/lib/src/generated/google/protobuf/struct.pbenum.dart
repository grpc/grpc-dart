///
//  Generated code. Do not modify.
//  source: google/protobuf/struct.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class NullValue extends $pb.ProtobufEnum {
  static const NullValue NULL_VALUE = NullValue._(0, 'NULL_VALUE');

  static const $core.List<NullValue> values = <NullValue>[
    NULL_VALUE,
  ];

  static final $core.Map<$core.int, NullValue> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static NullValue valueOf($core.int value) => _byValue[value];

  const NullValue._($core.int v, $core.String n) : super(v, n);
}
