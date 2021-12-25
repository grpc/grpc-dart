///
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pbenum.dart';

export 'label.pbenum.dart';

class LabelDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'LabelDescriptor',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..e<LabelDescriptor_ValueType>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'valueType',
        $pb.PbFieldType.OE,
        defaultOrMaker: LabelDescriptor_ValueType.STRING,
        valueOf: LabelDescriptor_ValueType.valueOf,
        enumValues: LabelDescriptor_ValueType.values)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..hasRequiredFields = false;

  LabelDescriptor._() : super();
  factory LabelDescriptor({
    $core.String? key,
    LabelDescriptor_ValueType? valueType,
    $core.String? description,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (valueType != null) {
      _result.valueType = valueType;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory LabelDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LabelDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LabelDescriptor clone() => LabelDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LabelDescriptor copyWith(void Function(LabelDescriptor) updates) =>
      super.copyWith((message) => updates(message as LabelDescriptor))
          as LabelDescriptor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor create() => LabelDescriptor._();
  LabelDescriptor createEmptyInstance() => create();
  static $pb.PbList<LabelDescriptor> createRepeated() =>
      $pb.PbList<LabelDescriptor>();
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LabelDescriptor>(create);
  static LabelDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  LabelDescriptor_ValueType get valueType => $_getN(1);
  @$pb.TagNumber(2)
  set valueType(LabelDescriptor_ValueType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValueType() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}
