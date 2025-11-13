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

import 'label.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'label.pbenum.dart';

/// A description of a label.
class LabelDescriptor extends $pb.GeneratedMessage {
  factory LabelDescriptor({
    $core.String? key,
    LabelDescriptor_ValueType? valueType,
    $core.String? description,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (valueType != null) result.valueType = valueType;
    if (description != null) result.description = description;
    return result;
  }

  LabelDescriptor._();

  factory LabelDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LabelDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LabelDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aE<LabelDescriptor_ValueType>(2, _omitFieldNames ? '' : 'valueType',
        enumValues: LabelDescriptor_ValueType.values)
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LabelDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LabelDescriptor copyWith(void Function(LabelDescriptor) updates) =>
      super.copyWith((message) => updates(message as LabelDescriptor))
          as LabelDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LabelDescriptor create() => LabelDescriptor._();
  @$core.override
  LabelDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LabelDescriptor>(create);
  static LabelDescriptor? _defaultInstance;

  /// The label key.
  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  /// The type of data that can be assigned to the label.
  @$pb.TagNumber(2)
  LabelDescriptor_ValueType get valueType => $_getN(1);
  @$pb.TagNumber(2)
  set valueType(LabelDescriptor_ValueType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasValueType() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueType() => $_clearField(2);

  /// A human-readable description for the label.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
