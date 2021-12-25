///
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LabelDescriptor_ValueType extends $pb.ProtobufEnum {
  static const LabelDescriptor_ValueType STRING = LabelDescriptor_ValueType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'STRING');
  static const LabelDescriptor_ValueType BOOL = LabelDescriptor_ValueType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'BOOL');
  static const LabelDescriptor_ValueType INT64 = LabelDescriptor_ValueType._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'INT64');

  static const $core.List<LabelDescriptor_ValueType> values =
      <LabelDescriptor_ValueType>[
    STRING,
    BOOL,
    INT64,
  ];

  static final $core.Map<$core.int, LabelDescriptor_ValueType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LabelDescriptor_ValueType? valueOf($core.int value) => _byValue[value];

  const LabelDescriptor_ValueType._($core.int v, $core.String n) : super(v, n);
}
