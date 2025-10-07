// This is a generated file - do not edit.
//
// Generated from google/api/label.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Value types that can be used as label values.
class LabelDescriptor_ValueType extends $pb.ProtobufEnum {
  /// A variable-length string. This is the default.
  static const LabelDescriptor_ValueType STRING =
      LabelDescriptor_ValueType._(0, _omitEnumNames ? '' : 'STRING');

  /// Boolean; true or false.
  static const LabelDescriptor_ValueType BOOL =
      LabelDescriptor_ValueType._(1, _omitEnumNames ? '' : 'BOOL');

  /// A 64-bit signed integer.
  static const LabelDescriptor_ValueType INT64 =
      LabelDescriptor_ValueType._(2, _omitEnumNames ? '' : 'INT64');

  static const $core.List<LabelDescriptor_ValueType> values =
      <LabelDescriptor_ValueType>[
    STRING,
    BOOL,
    INT64,
  ];

  static final $core.List<LabelDescriptor_ValueType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static LabelDescriptor_ValueType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LabelDescriptor_ValueType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
