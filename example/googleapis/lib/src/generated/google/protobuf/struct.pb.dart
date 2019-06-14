///
//  Generated code. Do not modify.
//  source: google/protobuf/struct.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'struct.pbenum.dart';

export 'struct.pbenum.dart';

class Struct extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Struct',
      package: const $pb.PackageName('google.protobuf'))
    ..m<$core.String, Value>(
        1,
        'fields',
        'Struct.FieldsEntry',
        $pb.PbFieldType.OS,
        $pb.PbFieldType.OM,
        Value.create,
        null,
        null,
        const $pb.PackageName('google.protobuf'))
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
  static Struct getDefault() => _defaultInstance ??= create()..freeze();
  static Struct _defaultInstance;

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

class Value extends $pb.GeneratedMessage {
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
      package: const $pb.PackageName('google.protobuf'))
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..e<NullValue>(1, 'nullValue', $pb.PbFieldType.OE, NullValue.NULL_VALUE,
        NullValue.valueOf, NullValue.values)
    ..a<$core.double>(2, 'numberValue', $pb.PbFieldType.OD)
    ..aOS(3, 'stringValue')
    ..aOB(4, 'boolValue')
    ..a<Struct>(
        5, 'structValue', $pb.PbFieldType.OM, Struct.getDefault, Struct.create)
    ..a<ListValue>(6, 'listValue', $pb.PbFieldType.OM, ListValue.getDefault,
        ListValue.create)
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
  static Value getDefault() => _defaultInstance ??= create()..freeze();
  static Value _defaultInstance;

  Value_Kind whichKind() => _Value_KindByTag[$_whichOneof(0)];
  void clearKind() => clearField($_whichOneof(0));

  NullValue get nullValue => $_getN(0);
  set nullValue(NullValue v) {
    setField(1, v);
  }

  $core.bool hasNullValue() => $_has(0);
  void clearNullValue() => clearField(1);

  $core.double get numberValue => $_getN(1);
  set numberValue($core.double v) {
    $_setDouble(1, v);
  }

  $core.bool hasNumberValue() => $_has(1);
  void clearNumberValue() => clearField(2);

  $core.String get stringValue => $_getS(2, '');
  set stringValue($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasStringValue() => $_has(2);
  void clearStringValue() => clearField(3);

  $core.bool get boolValue => $_get(3, false);
  set boolValue($core.bool v) {
    $_setBool(3, v);
  }

  $core.bool hasBoolValue() => $_has(3);
  void clearBoolValue() => clearField(4);

  Struct get structValue => $_getN(4);
  set structValue(Struct v) {
    setField(5, v);
  }

  $core.bool hasStructValue() => $_has(4);
  void clearStructValue() => clearField(5);

  ListValue get listValue => $_getN(5);
  set listValue(ListValue v) {
    setField(6, v);
  }

  $core.bool hasListValue() => $_has(5);
  void clearListValue() => clearField(6);
}

class ListValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ListValue',
      package: const $pb.PackageName('google.protobuf'))
    ..pc<Value>(1, 'values', $pb.PbFieldType.PM, Value.create)
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
  static ListValue getDefault() => _defaultInstance ??= create()..freeze();
  static ListValue _defaultInstance;

  $core.List<Value> get values => $_getList(0);
}
