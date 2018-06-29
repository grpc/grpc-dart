///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.protobuf_struct;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'struct.pbenum.dart';

export 'struct.pbenum.dart';

class Struct_FieldsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Struct_FieldsEntry')
    ..aOS(1, 'key')
    ..a<Value>(2, 'value', PbFieldType.OM, Value.getDefault, Value.create)
    ..hasRequiredFields = false;

  Struct_FieldsEntry() : super();
  Struct_FieldsEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Struct_FieldsEntry.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Struct_FieldsEntry clone() =>
      new Struct_FieldsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Struct_FieldsEntry create() => new Struct_FieldsEntry();
  static PbList<Struct_FieldsEntry> createRepeated() =>
      new PbList<Struct_FieldsEntry>();
  static Struct_FieldsEntry getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyStruct_FieldsEntry();
    return _defaultInstance;
  }

  static Struct_FieldsEntry _defaultInstance;
  static void $checkItem(Struct_FieldsEntry v) {
    if (v is! Struct_FieldsEntry) checkItemFailed(v, 'Struct_FieldsEntry');
  }

  String get key => $_getS(0, '');
  set key(String v) {
    $_setString(0, v);
  }

  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  Value get value => $_getN(1);
  set value(Value v) {
    setField(2, v);
  }

  bool hasValue() => $_has(1);
  void clearValue() => clearField(2);
}

class _ReadonlyStruct_FieldsEntry extends Struct_FieldsEntry
    with ReadonlyMessageMixin {}

class Struct extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Struct')
    ..pp<Struct_FieldsEntry>(1, 'fields', PbFieldType.PM,
        Struct_FieldsEntry.$checkItem, Struct_FieldsEntry.create)
    ..hasRequiredFields = false;

  Struct() : super();
  Struct.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Struct.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Struct clone() => new Struct()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Struct create() => new Struct();
  static PbList<Struct> createRepeated() => new PbList<Struct>();
  static Struct getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStruct();
    return _defaultInstance;
  }

  static Struct _defaultInstance;
  static void $checkItem(Struct v) {
    if (v is! Struct) checkItemFailed(v, 'Struct');
  }

  List<Struct_FieldsEntry> get fields => $_getN(0);
}

class _ReadonlyStruct extends Struct with ReadonlyMessageMixin {}

class Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Value')
    ..e<NullValue>(1, 'nullValue', PbFieldType.OE, NullValue.NULL_VALUE,
        NullValue.valueOf, NullValue.values)
    ..a<double>(2, 'numberValue', PbFieldType.OD)
    ..aOS(3, 'stringValue')
    ..aOB(4, 'boolValue')
    ..a<Struct>(
        5, 'structValue', PbFieldType.OM, Struct.getDefault, Struct.create)
    ..a<ListValue>(
        6, 'listValue', PbFieldType.OM, ListValue.getDefault, ListValue.create)
    ..hasRequiredFields = false;

  Value() : super();
  Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Value clone() => new Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Value create() => new Value();
  static PbList<Value> createRepeated() => new PbList<Value>();
  static Value getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyValue();
    return _defaultInstance;
  }

  static Value _defaultInstance;
  static void $checkItem(Value v) {
    if (v is! Value) checkItemFailed(v, 'Value');
  }

  NullValue get nullValue => $_getN(0);
  set nullValue(NullValue v) {
    setField(1, v);
  }

  bool hasNullValue() => $_has(0);
  void clearNullValue() => clearField(1);

  double get numberValue => $_getN(1);
  set numberValue(double v) {
    $_setDouble(1, v);
  }

  bool hasNumberValue() => $_has(1);
  void clearNumberValue() => clearField(2);

  String get stringValue => $_getS(2, '');
  set stringValue(String v) {
    $_setString(2, v);
  }

  bool hasStringValue() => $_has(2);
  void clearStringValue() => clearField(3);

  bool get boolValue => $_get(3, false);
  set boolValue(bool v) {
    $_setBool(3, v);
  }

  bool hasBoolValue() => $_has(3);
  void clearBoolValue() => clearField(4);

  Struct get structValue => $_getN(4);
  set structValue(Struct v) {
    setField(5, v);
  }

  bool hasStructValue() => $_has(4);
  void clearStructValue() => clearField(5);

  ListValue get listValue => $_getN(5);
  set listValue(ListValue v) {
    setField(6, v);
  }

  bool hasListValue() => $_has(5);
  void clearListValue() => clearField(6);
}

class _ReadonlyValue extends Value with ReadonlyMessageMixin {}

class ListValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListValue')
    ..pp<Value>(1, 'values', PbFieldType.PM, Value.$checkItem, Value.create)
    ..hasRequiredFields = false;

  ListValue() : super();
  ListValue.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ListValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ListValue clone() => new ListValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListValue create() => new ListValue();
  static PbList<ListValue> createRepeated() => new PbList<ListValue>();
  static ListValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListValue();
    return _defaultInstance;
  }

  static ListValue _defaultInstance;
  static void $checkItem(ListValue v) {
    if (v is! ListValue) checkItemFailed(v, 'ListValue');
  }

  List<Value> get values => $_getN(0);
}

class _ReadonlyListValue extends ListValue with ReadonlyMessageMixin {}
