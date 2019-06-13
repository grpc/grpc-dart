///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library helloworld_helloworld;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class HelloRequest extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('HelloRequest')
    ..aOS(1, 'name')
    ..hasRequiredFields = false;

  HelloRequest() : super();
  HelloRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  HelloRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  HelloRequest clone() => HelloRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HelloRequest create() => HelloRequest();
  static PbList<HelloRequest> createRepeated() => PbList<HelloRequest>();
  static HelloRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = _ReadonlyHelloRequest();
    return _defaultInstance;
  }

  static HelloRequest _defaultInstance;
  static void $checkItem(HelloRequest v) {
    if (v is! HelloRequest) checkItemFailed(v, 'HelloRequest');
  }

  String get name => $_getS(0, '');
  set name(String v) {
    $_setString(0, v);
  }

  bool hasName() => $_has(0);
  void clearName() => clearField(1);
}

class _ReadonlyHelloRequest extends HelloRequest with ReadonlyMessageMixin {}

class HelloReply extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('HelloReply')
    ..aOS(1, 'message')
    ..hasRequiredFields = false;

  HelloReply() : super();
  HelloReply.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  HelloReply.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  HelloReply clone() => HelloReply()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HelloReply create() => HelloReply();
  static PbList<HelloReply> createRepeated() => PbList<HelloReply>();
  static HelloReply getDefault() {
    if (_defaultInstance == null) _defaultInstance = _ReadonlyHelloReply();
    return _defaultInstance;
  }

  static HelloReply _defaultInstance;
  static void $checkItem(HelloReply v) {
    if (v is! HelloReply) checkItemFailed(v, 'HelloReply');
  }

  String get message => $_getS(0, '');
  set message(String v) {
    $_setString(0, v);
  }

  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class _ReadonlyHelloReply extends HelloReply with ReadonlyMessageMixin {}
