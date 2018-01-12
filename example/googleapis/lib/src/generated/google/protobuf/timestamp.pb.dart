///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.protobuf_timestamp;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Timestamp extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Timestamp')
    ..aInt64(1, 'seconds')
    ..a<int>(2, 'nanos', PbFieldType.O3)
    ..hasRequiredFields = false;

  Timestamp() : super();
  Timestamp.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Timestamp.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Timestamp clone() => new Timestamp()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Timestamp create() => new Timestamp();
  static PbList<Timestamp> createRepeated() => new PbList<Timestamp>();
  static Timestamp getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTimestamp();
    return _defaultInstance;
  }

  static Timestamp _defaultInstance;
  static void $checkItem(Timestamp v) {
    if (v is! Timestamp) checkItemFailed(v, 'Timestamp');
  }

  Int64 get seconds => $_getI64(0);
  set seconds(Int64 v) {
    $_setInt64(0, v);
  }

  bool hasSeconds() => $_has(0);
  void clearSeconds() => clearField(1);

  int get nanos => $_get(1, 0);
  set nanos(int v) {
    $_setUnsignedInt32(1, v);
  }

  bool hasNanos() => $_has(1);
  void clearNanos() => clearField(2);
}

class _ReadonlyTimestamp extends Timestamp with ReadonlyMessageMixin {}
