///
//  Generated code. Do not modify.
//  source: google/protobuf/struct.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'package:protobuf/src/protobuf/mixins/well_known.dart' as $mixin;

import 'struct.pbenum.dart';

export 'struct.pbenum.dart';

class Struct extends $pb.GeneratedMessage with $mixin.StructMixin {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Struct',
      package: const $pb.PackageName('google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.StructMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.StructMixin.fromProto3JsonHelper)
    ..m<$core.String, Value>(1, 'fields',
        entryClassName: 'Struct.FieldsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: Value.create,
        packageName: const $pb.PackageName('google.protobuf'))
    ..hasRequiredFields = false;

  Struct._() : super();
  factory Struct() => create();
  factory Struct.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Struct.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Struct clone() => Struct()..mergeFromMessage(this);
  Struct copyWith(void Function(Struct) updates) =>
      super.copyWith((message) => updates(message as Struct));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Struct create() => Struct._();
  Struct createEmptyInstance() => create();
  static $pb.PbList<Struct> createRepeated() => $pb.PbList<Struct>();
  @$core.pragma('dart2js:noInline')
  static Struct getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Struct>(create);
  static Struct _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.String, Value> get fields => $_getMap(0);
}

enum Value_Kind {
  nullValue,
  numberValue,
  stringValue,
  boolValue,
  structValue,
  listValue,
  notSet
}

class Value extends $pb.GeneratedMessage with $mixin.ValueMixin {
  static const $core.Map<$core.int, Value_Kind> _Value_KindByTag = {
    1: Value_Kind.nullValue,
    2: Value_Kind.numberValue,
    3: Value_Kind.stringValue,
    4: Value_Kind.boolValue,
    5: Value_Kind.structValue,
    6: Value_Kind.listValue,
    0: Value_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Value',
      package: const $pb.PackageName('google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.ValueMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.ValueMixin.fromProto3JsonHelper)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..e<NullValue>(1, 'nullValue', $pb.PbFieldType.OE,
        defaultOrMaker: NullValue.NULL_VALUE,
        valueOf: NullValue.valueOf,
        enumValues: NullValue.values)
    ..a<$core.double>(2, 'numberValue', $pb.PbFieldType.OD)
    ..aOS(3, 'stringValue')
    ..aOB(4, 'boolValue')
    ..aOM<Struct>(5, 'structValue', subBuilder: Struct.create)
    ..aOM<ListValue>(6, 'listValue', subBuilder: ListValue.create)
    ..hasRequiredFields = false;

  Value._() : super();
  factory Value() => create();
  factory Value.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Value.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Value clone() => Value()..mergeFromMessage(this);
  Value copyWith(void Function(Value) updates) =>
      super.copyWith((message) => updates(message as Value));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Value create() => Value._();
  Value createEmptyInstance() => create();
  static $pb.PbList<Value> createRepeated() => $pb.PbList<Value>();
  @$core.pragma('dart2js:noInline')
  static Value getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Value>(create);
  static Value _defaultInstance;

  Value_Kind whichKind() => _Value_KindByTag[$_whichOneof(0)];
  void clearKind() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  NullValue get nullValue => $_getN(0);
  @$pb.TagNumber(1)
  set nullValue(NullValue v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNullValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearNullValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get numberValue => $_getN(1);
  @$pb.TagNumber(2)
  set numberValue($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNumberValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumberValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stringValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set stringValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasStringValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearStringValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => clearField(4);

  @$pb.TagNumber(5)
  Struct get structValue => $_getN(4);
  @$pb.TagNumber(5)
  set structValue(Struct v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStructValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearStructValue() => clearField(5);
  @$pb.TagNumber(5)
  Struct ensureStructValue() => $_ensure(4);

  @$pb.TagNumber(6)
  ListValue get listValue => $_getN(5);
  @$pb.TagNumber(6)
  set listValue(ListValue v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasListValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearListValue() => clearField(6);
  @$pb.TagNumber(6)
  ListValue ensureListValue() => $_ensure(5);
}

class ListValue extends $pb.GeneratedMessage with $mixin.ListValueMixin {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListValue',
      package: const $pb.PackageName('google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.ListValueMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.ListValueMixin.fromProto3JsonHelper)
    ..pc<Value>(1, 'values', $pb.PbFieldType.PM, subBuilder: Value.create)
    ..hasRequiredFields = false;

  ListValue._() : super();
  factory ListValue() => create();
  factory ListValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ListValue clone() => ListValue()..mergeFromMessage(this);
  ListValue copyWith(void Function(ListValue) updates) =>
      super.copyWith((message) => updates(message as ListValue));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListValue create() => ListValue._();
  ListValue createEmptyInstance() => create();
  static $pb.PbList<ListValue> createRepeated() => $pb.PbList<ListValue>();
  @$core.pragma('dart2js:noInline')
  static ListValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListValue>(create);
  static ListValue _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Value> get values => $_getList(0);
}
