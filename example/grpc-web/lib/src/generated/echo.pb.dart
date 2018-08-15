///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Empty extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Empty')
    ..hasRequiredFields = false
  ;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Empty.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
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

class EchoRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EchoRequest')
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  EchoRequest() : super();
  EchoRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EchoRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EchoRequest clone() => new EchoRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EchoRequest create() => new EchoRequest();
  static PbList<EchoRequest> createRepeated() => new PbList<EchoRequest>();
  static EchoRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEchoRequest();
    return _defaultInstance;
  }
  static EchoRequest _defaultInstance;
  static void $checkItem(EchoRequest v) {
    if (v is! EchoRequest) checkItemFailed(v, 'EchoRequest');
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class _ReadonlyEchoRequest extends EchoRequest with ReadonlyMessageMixin {}

class EchoResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EchoResponse')
    ..aOS(1, 'message')
    ..a<int>(2, 'messageCount', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  EchoResponse() : super();
  EchoResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EchoResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EchoResponse clone() => new EchoResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EchoResponse create() => new EchoResponse();
  static PbList<EchoResponse> createRepeated() => new PbList<EchoResponse>();
  static EchoResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEchoResponse();
    return _defaultInstance;
  }
  static EchoResponse _defaultInstance;
  static void $checkItem(EchoResponse v) {
    if (v is! EchoResponse) checkItemFailed(v, 'EchoResponse');
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);

  int get messageCount => $_get(1, 0);
  set messageCount(int v) { $_setSignedInt32(1, v); }
  bool hasMessageCount() => $_has(1);
  void clearMessageCount() => clearField(2);
}

class _ReadonlyEchoResponse extends EchoResponse with ReadonlyMessageMixin {}

class ServerStreamingEchoRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServerStreamingEchoRequest')
    ..aOS(1, 'message')
    ..a<int>(2, 'messageCount', PbFieldType.O3)
    ..a<int>(3, 'messageInterval', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ServerStreamingEchoRequest() : super();
  ServerStreamingEchoRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServerStreamingEchoRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServerStreamingEchoRequest clone() => new ServerStreamingEchoRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServerStreamingEchoRequest create() => new ServerStreamingEchoRequest();
  static PbList<ServerStreamingEchoRequest> createRepeated() => new PbList<ServerStreamingEchoRequest>();
  static ServerStreamingEchoRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServerStreamingEchoRequest();
    return _defaultInstance;
  }
  static ServerStreamingEchoRequest _defaultInstance;
  static void $checkItem(ServerStreamingEchoRequest v) {
    if (v is! ServerStreamingEchoRequest) checkItemFailed(v, 'ServerStreamingEchoRequest');
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);

  int get messageCount => $_get(1, 0);
  set messageCount(int v) { $_setSignedInt32(1, v); }
  bool hasMessageCount() => $_has(1);
  void clearMessageCount() => clearField(2);

  int get messageInterval => $_get(2, 0);
  set messageInterval(int v) { $_setSignedInt32(2, v); }
  bool hasMessageInterval() => $_has(2);
  void clearMessageInterval() => clearField(3);
}

class _ReadonlyServerStreamingEchoRequest extends ServerStreamingEchoRequest with ReadonlyMessageMixin {}

class ServerStreamingEchoResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServerStreamingEchoResponse')
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  ServerStreamingEchoResponse() : super();
  ServerStreamingEchoResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServerStreamingEchoResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServerStreamingEchoResponse clone() => new ServerStreamingEchoResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServerStreamingEchoResponse create() => new ServerStreamingEchoResponse();
  static PbList<ServerStreamingEchoResponse> createRepeated() => new PbList<ServerStreamingEchoResponse>();
  static ServerStreamingEchoResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServerStreamingEchoResponse();
    return _defaultInstance;
  }
  static ServerStreamingEchoResponse _defaultInstance;
  static void $checkItem(ServerStreamingEchoResponse v) {
    if (v is! ServerStreamingEchoResponse) checkItemFailed(v, 'ServerStreamingEchoResponse');
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class _ReadonlyServerStreamingEchoResponse extends ServerStreamingEchoResponse with ReadonlyMessageMixin {}

class ClientStreamingEchoRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ClientStreamingEchoRequest')
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  ClientStreamingEchoRequest() : super();
  ClientStreamingEchoRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ClientStreamingEchoRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ClientStreamingEchoRequest clone() => new ClientStreamingEchoRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ClientStreamingEchoRequest create() => new ClientStreamingEchoRequest();
  static PbList<ClientStreamingEchoRequest> createRepeated() => new PbList<ClientStreamingEchoRequest>();
  static ClientStreamingEchoRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyClientStreamingEchoRequest();
    return _defaultInstance;
  }
  static ClientStreamingEchoRequest _defaultInstance;
  static void $checkItem(ClientStreamingEchoRequest v) {
    if (v is! ClientStreamingEchoRequest) checkItemFailed(v, 'ClientStreamingEchoRequest');
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class _ReadonlyClientStreamingEchoRequest extends ClientStreamingEchoRequest with ReadonlyMessageMixin {}

class ClientStreamingEchoResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ClientStreamingEchoResponse')
    ..a<int>(1, 'messageCount', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ClientStreamingEchoResponse() : super();
  ClientStreamingEchoResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ClientStreamingEchoResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ClientStreamingEchoResponse clone() => new ClientStreamingEchoResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ClientStreamingEchoResponse create() => new ClientStreamingEchoResponse();
  static PbList<ClientStreamingEchoResponse> createRepeated() => new PbList<ClientStreamingEchoResponse>();
  static ClientStreamingEchoResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyClientStreamingEchoResponse();
    return _defaultInstance;
  }
  static ClientStreamingEchoResponse _defaultInstance;
  static void $checkItem(ClientStreamingEchoResponse v) {
    if (v is! ClientStreamingEchoResponse) checkItemFailed(v, 'ClientStreamingEchoResponse');
  }

  int get messageCount => $_get(0, 0);
  set messageCount(int v) { $_setSignedInt32(0, v); }
  bool hasMessageCount() => $_has(0);
  void clearMessageCount() => clearField(1);
}

class _ReadonlyClientStreamingEchoResponse extends ClientStreamingEchoResponse with ReadonlyMessageMixin {}

