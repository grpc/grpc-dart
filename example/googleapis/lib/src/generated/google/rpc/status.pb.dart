///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.rpc_status;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import '../protobuf/any.pb.dart' as $google$protobuf;

class Status extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('Status')
    ..a<int>(1, 'code', PbFieldType.O3)
    ..aOS(2, 'message')
    ..pp<$google$protobuf.Any>(3, 'details', PbFieldType.PM,
        $google$protobuf.Any.$checkItem, $google$protobuf.Any.create)
    ..hasRequiredFields = false;

  Status() : super();
  Status.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Status.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Status clone() => Status()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Status create() => Status();
  static PbList<Status> createRepeated() => PbList<Status>();
  static Status getDefault() {
    if (_defaultInstance == null) _defaultInstance = _ReadonlyStatus();
    return _defaultInstance;
  }

  static Status _defaultInstance;
  static void $checkItem(Status v) {
    if (v is! Status) checkItemFailed(v, 'Status');
  }

  int get code => $_get(0, 0);
  set code(int v) {
    $_setUnsignedInt32(0, v);
  }

  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  String get message => $_getS(1, '');
  set message(String v) {
    $_setString(1, v);
  }

  bool hasMessage() => $_has(1);
  void clearMessage() => clearField(2);

  List<$google$protobuf.Any> get details => $_getList(2);
}

class _ReadonlyStatus extends Status with ReadonlyMessageMixin {}
