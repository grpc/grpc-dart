///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library grpc_metadata;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Record extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Record')
    ..a<String>(1, 'value', PbFieldType.OS)
    ..hasRequiredFields = false;

  Record() : super();
  Record.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Record.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Record clone() => new Record()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Record create() => new Record();
  static PbList<Record> createRepeated() => new PbList<Record>();
  static Record getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRecord();
    return _defaultInstance;
  }

  static Record _defaultInstance;
  static void $checkItem(Record v) {
    if (v is! Record) checkItemFailed(v, 'Record');
  }

  String get value => $_get(0, 1, '');
  set value(String v) {
    $_setString(0, 1, v);
  }

  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyRecord extends Record with ReadonlyMessageMixin {}

class Number extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Number')
    ..a<int>(1, 'value', PbFieldType.O3)
    ..hasRequiredFields = false;

  Number() : super();
  Number.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Number.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Number clone() => new Number()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Number create() => new Number();
  static PbList<Number> createRepeated() => new PbList<Number>();
  static Number getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyNumber();
    return _defaultInstance;
  }

  static Number _defaultInstance;
  static void $checkItem(Number v) {
    if (v is! Number) checkItemFailed(v, 'Number');
  }

  int get value => $_get(0, 1, 0);
  set value(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyNumber extends Number with ReadonlyMessageMixin {}

class Empty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Empty')
    ..hasRequiredFields = false;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Empty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Empty clone() => new Empty()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Empty create() => new Empty();
  static PbList<Empty> createRepeated() => new PbList<Empty>();
  static Empty getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEmpty();
    return _defaultInstance;
  }

  static Empty _defaultInstance;
  static void $checkItem(Empty v) {
    if (v is! Empty) checkItemFailed(v, 'Empty');
  }
}

class _ReadonlyEmpty extends Empty with ReadonlyMessageMixin {}
