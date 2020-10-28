///
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pbenum.dart';

export 'label.pbenum.dart';

class LabelDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LabelDescriptor',
      package: const $pb.PackageName('google.api'), createEmptyInstance: create)
    ..aOS(1, 'key')
    ..e<LabelDescriptor_ValueType>(2, 'valueType', $pb.PbFieldType.OE,
        defaultOrMaker: LabelDescriptor_ValueType.STRING,
        valueOf: LabelDescriptor_ValueType.valueOf,
        enumValues: LabelDescriptor_ValueType.values)
    ..aOS(3, 'description')
    ..hasRequiredFields = false;

  LabelDescriptor._() : super();
  factory LabelDescriptor() => create();
  factory LabelDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LabelDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  LabelDescriptor clone() => LabelDescriptor()..mergeFromMessage(this);
  LabelDescriptor copyWith(void Function(LabelDescriptor) updates) =>
      super.copyWith((message) => updates(message as LabelDescriptor));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor create() => LabelDescriptor._();
  LabelDescriptor createEmptyInstance() => create();
  static $pb.PbList<LabelDescriptor> createRepeated() =>
      $pb.PbList<LabelDescriptor>();
  @$core.pragma('dart2js:noInline')
  static LabelDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LabelDescriptor>(create);
  static LabelDescriptor _defaultInstance;

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
