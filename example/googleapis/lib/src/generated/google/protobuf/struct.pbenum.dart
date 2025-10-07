// This is a generated file - do not edit.
//
// Generated from google/protobuf/struct.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// `NullValue` is a singleton enumeration to represent the null value for the
/// `Value` type union.
///
/// The JSON representation for `NullValue` is JSON `null`.
class NullValue extends $pb.ProtobufEnum {
  /// Null value.
  static const NullValue NULL_VALUE =
      NullValue._(0, _omitEnumNames ? '' : 'NULL_VALUE');

  static const $core.List<NullValue> values = <NullValue>[
    NULL_VALUE,
  ];

  static final $core.List<NullValue?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static NullValue? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const NullValue._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
