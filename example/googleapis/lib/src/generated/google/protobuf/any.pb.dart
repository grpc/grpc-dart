///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.protobuf_any;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Any extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Any')
    ..aOS(1, 'typeUrl')
    ..a<List<int>>(2, 'value', PbFieldType.OY)
    ..hasRequiredFields = false;

  Any() : super();
  Any.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Any.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Any clone() => new Any()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Any create() => new Any();
  static PbList<Any> createRepeated() => new PbList<Any>();
  static Any getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAny();
    return _defaultInstance;
  }

  static Any _defaultInstance;
  static void $checkItem(Any v) {
    if (v is! Any) checkItemFailed(v, 'Any');
  }

  String get typeUrl => $_getS(0, '');
  set typeUrl(String v) {
    $_setString(0, v);
  }

  bool hasTypeUrl() => $_has(0);
  void clearTypeUrl() => clearField(1);

  List<int> get value => $_getN(1);
  set value(List<int> v) {
    $_setBytes(1, v);
  }

  bool hasValue() => $_has(1);
  void clearValue() => clearField(2);
}

class _ReadonlyAny extends Any with ReadonlyMessageMixin {}
