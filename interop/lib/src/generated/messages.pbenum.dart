// This is a generated file - do not edit.
//
// Generated from messages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// DEPRECATED, don't use. To be removed shortly.
/// The type of payload that should be returned.
class PayloadType extends $pb.ProtobufEnum {
  /// Compressable text format.
  static const PayloadType COMPRESSABLE =
      PayloadType._(0, _omitEnumNames ? '' : 'COMPRESSABLE');

  static const $core.List<PayloadType> values = <PayloadType>[
    COMPRESSABLE,
  ];

  static final $core.List<PayloadType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static PayloadType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PayloadType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
