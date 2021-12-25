///
//  Generated code. Do not modify.
//  source: google/protobuf/struct.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'package:protobuf/src/protobuf/mixins/well_known.dart' as $mixin;

import 'struct.pbenum.dart';

export 'struct.pbenum.dart';

class Struct extends $pb.GeneratedMessage with $mixin.StructMixin {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Struct',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.StructMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.StructMixin.fromProto3JsonHelper)
    ..m<$core.String, Value>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fields',
        entryClassName: 'Struct.FieldsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: Value.create,
        packageName: const $pb.PackageName('google.protobuf'))
    ..hasRequiredFields = false;

  Struct._() : super();
  factory Struct({
    $core.Map<$core.String, Value>? fields,
  }) {
    final _result = create();
    if (fields != null) {
      _result.fields.addAll(fields);
    }
    return _result;
  }
  factory Struct.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Struct.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Struct clone() => Struct()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Struct copyWith(void Function(Struct) updates) =>
      super.copyWith((message) => updates(message as Struct))
          as Struct; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Struct create() => Struct._();
  Struct createEmptyInstance() => create();
  static $pb.PbList<Struct> createRepeated() => $pb.PbList<Struct>();
  @$core.pragma('dart2js:noInline')
  static Struct getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Struct>(create);
  static Struct? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Value',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.ValueMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.ValueMixin.fromProto3JsonHelper)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..e<NullValue>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'nullValue',
        $pb.PbFieldType.OE,
        defaultOrMaker: NullValue.NULL_VALUE,
        valueOf: NullValue.valueOf,
        enumValues: NullValue.values)
    ..a<$core.double>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'numberValue',
        $pb.PbFieldType.OD)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'stringValue')
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'boolValue')
    ..aOM<Struct>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'structValue',
        subBuilder: Struct.create)
    ..aOM<ListValue>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'listValue',
        subBuilder: ListValue.create)
    ..hasRequiredFields = false;

  Value._() : super();
  factory Value({
    NullValue? nullValue,
    $core.double? numberValue,
    $core.String? stringValue,
    $core.bool? boolValue,
    Struct? structValue,
    ListValue? listValue,
  }) {
    final _result = create();
    if (nullValue != null) {
      _result.nullValue = nullValue;
    }
    if (numberValue != null) {
      _result.numberValue = numberValue;
    }
    if (stringValue != null) {
      _result.stringValue = stringValue;
    }
    if (boolValue != null) {
      _result.boolValue = boolValue;
    }
    if (structValue != null) {
      _result.structValue = structValue;
    }
    if (listValue != null) {
      _result.listValue = listValue;
    }
    return _result;
  }
  factory Value.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Value.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Value clone() => Value()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Value copyWith(void Function(Value) updates) =>
      super.copyWith((message) => updates(message as Value))
          as Value; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Value create() => Value._();
  Value createEmptyInstance() => create();
  static $pb.PbList<Value> createRepeated() => $pb.PbList<Value>();
  @$core.pragma('dart2js:noInline')
  static Value getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Value>(create);
  static Value? _defaultInstance;

  Value_Kind whichKind() => _Value_KindByTag[$_whichOneof(0)]!;
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ListValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.protobuf'),
      createEmptyInstance: create,
      toProto3Json: $mixin.ListValueMixin.toProto3JsonHelper,
      fromProto3Json: $mixin.ListValueMixin.fromProto3JsonHelper)
    ..pc<Value>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'values',
        $pb.PbFieldType.PM,
        subBuilder: Value.create)
    ..hasRequiredFields = false;

  ListValue._() : super();
  factory ListValue({
    $core.Iterable<Value>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory ListValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListValue clone() => ListValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListValue copyWith(void Function(ListValue) updates) =>
      super.copyWith((message) => updates(message as ListValue))
          as ListValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListValue create() => ListValue._();
  ListValue createEmptyInstance() => create();
  static $pb.PbList<ListValue> createRepeated() => $pb.PbList<ListValue>();
  @$core.pragma('dart2js:noInline')
  static ListValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListValue>(create);
  static ListValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Value> get values => $_getList(0);
}
