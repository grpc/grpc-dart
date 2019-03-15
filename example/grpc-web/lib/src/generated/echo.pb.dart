///
//  Generated code. Do not modify.
//  source: echo.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class EchoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('EchoRequest', package: const $pb.PackageName('grpc.gateway.testing'))
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  EchoRequest() : super();
  EchoRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EchoRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EchoRequest clone() => new EchoRequest()..mergeFromMessage(this);
  EchoRequest copyWith(void Function(EchoRequest) updates) => super.copyWith((message) => updates(message as EchoRequest));
  $pb.BuilderInfo get info_ => _i;
  static EchoRequest create() => new EchoRequest();
  EchoRequest createEmptyInstance() => create();
  static $pb.PbList<EchoRequest> createRepeated() => new $pb.PbList<EchoRequest>();
  static EchoRequest getDefault() => _defaultInstance ??= create()..freeze();
  static EchoRequest _defaultInstance;
  static void $checkItem(EchoRequest v) {
    if (v is! EchoRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class EchoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('EchoResponse', package: const $pb.PackageName('grpc.gateway.testing'))
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  EchoResponse() : super();
  EchoResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EchoResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EchoResponse clone() => new EchoResponse()..mergeFromMessage(this);
  EchoResponse copyWith(void Function(EchoResponse) updates) => super.copyWith((message) => updates(message as EchoResponse));
  $pb.BuilderInfo get info_ => _i;
  static EchoResponse create() => new EchoResponse();
  EchoResponse createEmptyInstance() => create();
  static $pb.PbList<EchoResponse> createRepeated() => new $pb.PbList<EchoResponse>();
  static EchoResponse getDefault() => _defaultInstance ??= create()..freeze();
  static EchoResponse _defaultInstance;
  static void $checkItem(EchoResponse v) {
    if (v is! EchoResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

class ServerStreamingEchoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ServerStreamingEchoRequest', package: const $pb.PackageName('grpc.gateway.testing'))
    ..aOS(1, 'message')
    ..a<int>(2, 'messageCount', $pb.PbFieldType.O3)
    ..a<int>(3, 'messageInterval', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ServerStreamingEchoRequest() : super();
  ServerStreamingEchoRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServerStreamingEchoRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServerStreamingEchoRequest clone() => new ServerStreamingEchoRequest()..mergeFromMessage(this);
  ServerStreamingEchoRequest copyWith(void Function(ServerStreamingEchoRequest) updates) => super.copyWith((message) => updates(message as ServerStreamingEchoRequest));
  $pb.BuilderInfo get info_ => _i;
  static ServerStreamingEchoRequest create() => new ServerStreamingEchoRequest();
  ServerStreamingEchoRequest createEmptyInstance() => create();
  static $pb.PbList<ServerStreamingEchoRequest> createRepeated() => new $pb.PbList<ServerStreamingEchoRequest>();
  static ServerStreamingEchoRequest getDefault() => _defaultInstance ??= create()..freeze();
  static ServerStreamingEchoRequest _defaultInstance;
  static void $checkItem(ServerStreamingEchoRequest v) {
    if (v is! ServerStreamingEchoRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
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

class ServerStreamingEchoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ServerStreamingEchoResponse', package: const $pb.PackageName('grpc.gateway.testing'))
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  ServerStreamingEchoResponse() : super();
  ServerStreamingEchoResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServerStreamingEchoResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServerStreamingEchoResponse clone() => new ServerStreamingEchoResponse()..mergeFromMessage(this);
  ServerStreamingEchoResponse copyWith(void Function(ServerStreamingEchoResponse) updates) => super.copyWith((message) => updates(message as ServerStreamingEchoResponse));
  $pb.BuilderInfo get info_ => _i;
  static ServerStreamingEchoResponse create() => new ServerStreamingEchoResponse();
  ServerStreamingEchoResponse createEmptyInstance() => create();
  static $pb.PbList<ServerStreamingEchoResponse> createRepeated() => new $pb.PbList<ServerStreamingEchoResponse>();
  static ServerStreamingEchoResponse getDefault() => _defaultInstance ??= create()..freeze();
  static ServerStreamingEchoResponse _defaultInstance;
  static void $checkItem(ServerStreamingEchoResponse v) {
    if (v is! ServerStreamingEchoResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

