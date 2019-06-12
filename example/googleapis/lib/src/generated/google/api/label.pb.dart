///
//  Generated code. Do not modify.
//  source: google/api/label.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pbenum.dart';

export 'label.pbenum.dart';

class LabelDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LabelDescriptor',
      package: const $pb.PackageName('google.api'))
    ..aOS(1, 'key')
    ..e<LabelDescriptor_ValueType>(
        2,
        'valueType',
        $pb.PbFieldType.OE,
        LabelDescriptor_ValueType.STRING,
        LabelDescriptor_ValueType.valueOf,
        LabelDescriptor_ValueType.values)
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
  static LabelDescriptor getDefault() =>
      _defaultInstance ??= create()..freeze();
  static LabelDescriptor _defaultInstance;

  $core.String get key => $_getS(0, '');
  set key($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  LabelDescriptor_ValueType get valueType => $_getN(1);
  set valueType(LabelDescriptor_ValueType v) {
    setField(2, v);
  }

  $core.bool hasValueType() => $_has(1);
  void clearValueType() => clearField(2);

  $core.String get description => $_getS(2, '');
  set description($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasDescription() => $_has(2);
  void clearDescription() => clearField(3);
}
