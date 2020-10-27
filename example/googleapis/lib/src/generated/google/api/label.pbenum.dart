///
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LabelDescriptor_ValueType extends $pb.ProtobufEnum {
  static const LabelDescriptor_ValueType STRING =
      LabelDescriptor_ValueType._(0, 'STRING');
  static const LabelDescriptor_ValueType BOOL =
      LabelDescriptor_ValueType._(1, 'BOOL');
  static const LabelDescriptor_ValueType INT64 =
      LabelDescriptor_ValueType._(2, 'INT64');

  static const $core.List<LabelDescriptor_ValueType> values =
      <LabelDescriptor_ValueType>[
    STRING,
    BOOL,
    INT64,
  ];

  static final $core.Map<$core.int, LabelDescriptor_ValueType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LabelDescriptor_ValueType valueOf($core.int value) => _byValue[value];

  const LabelDescriptor_ValueType._($core.int v, $core.String n) : super(v, n);
}
