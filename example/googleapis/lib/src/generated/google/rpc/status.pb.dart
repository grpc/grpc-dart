///
//  Generated code. Do not modify.
//  source: google/rpc/status.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/any.pb.dart' as $0;

class Status extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Status', package: const $pb.PackageName('google.rpc'))
        ..a<$core.int>(1, 'code', $pb.PbFieldType.O3)
        ..aOS(2, 'message')
        ..pc<$0.Any>(3, 'details', $pb.PbFieldType.PM, $0.Any.create)
        ..hasRequiredFields = false;

  Status._() : super();
  factory Status() => create();
  factory Status.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Status.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Status clone() => Status()..mergeFromMessage(this);
  Status copyWith(void Function(Status) updates) =>
      super.copyWith((message) => updates(message as Status));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Status create() => Status._();
  Status createEmptyInstance() => create();
  static $pb.PbList<Status> createRepeated() => $pb.PbList<Status>();
  static Status getDefault() => _defaultInstance ??= create()..freeze();
  static Status _defaultInstance;

  $core.int get code => $_get(0, 0);
  set code($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  $core.String get message => $_getS(1, '');
  set message($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasMessage() => $_has(1);
  void clearMessage() => clearField(2);

  $core.List<$0.Any> get details => $_getList(2);
}
