///
//  Generated code. Do not modify.
//  source: messages.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

class BoolValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('BoolValue', package: const $pb.PackageName('grpc.testing'))
    ..aOB(1, 'value')
    ..hasRequiredFields = false
  ;

  BoolValue() : super();
  BoolValue.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BoolValue.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BoolValue clone() => new BoolValue()..mergeFromMessage(this);
  BoolValue copyWith(void Function(BoolValue) updates) => super.copyWith((message) => updates(message as BoolValue));
  $pb.BuilderInfo get info_ => _i;
  static BoolValue create() => new BoolValue();
  BoolValue createEmptyInstance() => create();
  static $pb.PbList<BoolValue> createRepeated() => new $pb.PbList<BoolValue>();
  static BoolValue getDefault() => _defaultInstance ??= create()..freeze();
  static BoolValue _defaultInstance;
  static void $checkItem(BoolValue v) {
    if (v is! BoolValue) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  bool get value => $_get(0, false);
  set value(bool v) { $_setBool(0, v); }
  bool hasValue() => $_has(0);
  void clearValue() => clearField(1);
}

class Payload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Payload', package: const $pb.PackageName('grpc.testing'))
    ..e<PayloadType>(1, 'type', $pb.PbFieldType.OE, PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
    ..a<List<int>>(2, 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Payload() : super();
  Payload.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Payload.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Payload clone() => new Payload()..mergeFromMessage(this);
  Payload copyWith(void Function(Payload) updates) => super.copyWith((message) => updates(message as Payload));
  $pb.BuilderInfo get info_ => _i;
  static Payload create() => new Payload();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => new $pb.PbList<Payload>();
  static Payload getDefault() => _defaultInstance ??= create()..freeze();
  static Payload _defaultInstance;
  static void $checkItem(Payload v) {
    if (v is! Payload) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  PayloadType get type => $_getN(0);
  set type(PayloadType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  List<int> get body => $_getN(1);
  set body(List<int> v) { $_setBytes(1, v); }
  bool hasBody() => $_has(1);
  void clearBody() => clearField(2);
}

class EchoStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('EchoStatus', package: const $pb.PackageName('grpc.testing'))
    ..a<int>(1, 'code', $pb.PbFieldType.O3)
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  EchoStatus() : super();
  EchoStatus.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EchoStatus.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EchoStatus clone() => new EchoStatus()..mergeFromMessage(this);
  EchoStatus copyWith(void Function(EchoStatus) updates) => super.copyWith((message) => updates(message as EchoStatus));
  $pb.BuilderInfo get info_ => _i;
  static EchoStatus create() => new EchoStatus();
  EchoStatus createEmptyInstance() => create();
  static $pb.PbList<EchoStatus> createRepeated() => new $pb.PbList<EchoStatus>();
  static EchoStatus getDefault() => _defaultInstance ??= create()..freeze();
  static EchoStatus _defaultInstance;
  static void $checkItem(EchoStatus v) {
    if (v is! EchoStatus) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get code => $_get(0, 0);
  set code(int v) { $_setSignedInt32(0, v); }
  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  String get message => $_getS(1, '');
  set message(String v) { $_setString(1, v); }
  bool hasMessage() => $_has(1);
  void clearMessage() => clearField(2);
}

class SimpleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('SimpleRequest', package: const $pb.PackageName('grpc.testing'))
    ..e<PayloadType>(1, 'responseType', $pb.PbFieldType.OE, PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
    ..a<int>(2, 'responseSize', $pb.PbFieldType.O3)
    ..a<Payload>(3, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..aOB(4, 'fillUsername')
    ..aOB(5, 'fillOauthScope')
    ..a<BoolValue>(6, 'responseCompressed', $pb.PbFieldType.OM, BoolValue.getDefault, BoolValue.create)
    ..a<EchoStatus>(7, 'responseStatus', $pb.PbFieldType.OM, EchoStatus.getDefault, EchoStatus.create)
    ..a<BoolValue>(8, 'expectCompressed', $pb.PbFieldType.OM, BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false
  ;

  SimpleRequest() : super();
  SimpleRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SimpleRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SimpleRequest clone() => new SimpleRequest()..mergeFromMessage(this);
  SimpleRequest copyWith(void Function(SimpleRequest) updates) => super.copyWith((message) => updates(message as SimpleRequest));
  $pb.BuilderInfo get info_ => _i;
  static SimpleRequest create() => new SimpleRequest();
  SimpleRequest createEmptyInstance() => create();
  static $pb.PbList<SimpleRequest> createRepeated() => new $pb.PbList<SimpleRequest>();
  static SimpleRequest getDefault() => _defaultInstance ??= create()..freeze();
  static SimpleRequest _defaultInstance;
  static void $checkItem(SimpleRequest v) {
    if (v is! SimpleRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  PayloadType get responseType => $_getN(0);
  set responseType(PayloadType v) { setField(1, v); }
  bool hasResponseType() => $_has(0);
  void clearResponseType() => clearField(1);

  int get responseSize => $_get(1, 0);
  set responseSize(int v) { $_setSignedInt32(1, v); }
  bool hasResponseSize() => $_has(1);
  void clearResponseSize() => clearField(2);

  Payload get payload => $_getN(2);
  set payload(Payload v) { setField(3, v); }
  bool hasPayload() => $_has(2);
  void clearPayload() => clearField(3);

  bool get fillUsername => $_get(3, false);
  set fillUsername(bool v) { $_setBool(3, v); }
  bool hasFillUsername() => $_has(3);
  void clearFillUsername() => clearField(4);

  bool get fillOauthScope => $_get(4, false);
  set fillOauthScope(bool v) { $_setBool(4, v); }
  bool hasFillOauthScope() => $_has(4);
  void clearFillOauthScope() => clearField(5);

  BoolValue get responseCompressed => $_getN(5);
  set responseCompressed(BoolValue v) { setField(6, v); }
  bool hasResponseCompressed() => $_has(5);
  void clearResponseCompressed() => clearField(6);

  EchoStatus get responseStatus => $_getN(6);
  set responseStatus(EchoStatus v) { setField(7, v); }
  bool hasResponseStatus() => $_has(6);
  void clearResponseStatus() => clearField(7);

  BoolValue get expectCompressed => $_getN(7);
  set expectCompressed(BoolValue v) { setField(8, v); }
  bool hasExpectCompressed() => $_has(7);
  void clearExpectCompressed() => clearField(8);
}

class SimpleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('SimpleResponse', package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..aOS(2, 'username')
    ..aOS(3, 'oauthScope')
    ..hasRequiredFields = false
  ;

  SimpleResponse() : super();
  SimpleResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SimpleResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SimpleResponse clone() => new SimpleResponse()..mergeFromMessage(this);
  SimpleResponse copyWith(void Function(SimpleResponse) updates) => super.copyWith((message) => updates(message as SimpleResponse));
  $pb.BuilderInfo get info_ => _i;
  static SimpleResponse create() => new SimpleResponse();
  SimpleResponse createEmptyInstance() => create();
  static $pb.PbList<SimpleResponse> createRepeated() => new $pb.PbList<SimpleResponse>();
  static SimpleResponse getDefault() => _defaultInstance ??= create()..freeze();
  static SimpleResponse _defaultInstance;
  static void $checkItem(SimpleResponse v) {
    if (v is! SimpleResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  Payload get payload => $_getN(0);
  set payload(Payload v) { setField(1, v); }
  bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);

  String get username => $_getS(1, '');
  set username(String v) { $_setString(1, v); }
  bool hasUsername() => $_has(1);
  void clearUsername() => clearField(2);

  String get oauthScope => $_getS(2, '');
  set oauthScope(String v) { $_setString(2, v); }
  bool hasOauthScope() => $_has(2);
  void clearOauthScope() => clearField(3);
}

class StreamingInputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('StreamingInputCallRequest', package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<BoolValue>(2, 'expectCompressed', $pb.PbFieldType.OM, BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false
  ;

  StreamingInputCallRequest() : super();
  StreamingInputCallRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingInputCallRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingInputCallRequest clone() => new StreamingInputCallRequest()..mergeFromMessage(this);
  StreamingInputCallRequest copyWith(void Function(StreamingInputCallRequest) updates) => super.copyWith((message) => updates(message as StreamingInputCallRequest));
  $pb.BuilderInfo get info_ => _i;
  static StreamingInputCallRequest create() => new StreamingInputCallRequest();
  StreamingInputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallRequest> createRepeated() => new $pb.PbList<StreamingInputCallRequest>();
  static StreamingInputCallRequest getDefault() => _defaultInstance ??= create()..freeze();
  static StreamingInputCallRequest _defaultInstance;
  static void $checkItem(StreamingInputCallRequest v) {
    if (v is! StreamingInputCallRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  Payload get payload => $_getN(0);
  set payload(Payload v) { setField(1, v); }
  bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);

  BoolValue get expectCompressed => $_getN(1);
  set expectCompressed(BoolValue v) { setField(2, v); }
  bool hasExpectCompressed() => $_has(1);
  void clearExpectCompressed() => clearField(2);
}

class StreamingInputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('StreamingInputCallResponse', package: const $pb.PackageName('grpc.testing'))
    ..a<int>(1, 'aggregatedPayloadSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  StreamingInputCallResponse() : super();
  StreamingInputCallResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingInputCallResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingInputCallResponse clone() => new StreamingInputCallResponse()..mergeFromMessage(this);
  StreamingInputCallResponse copyWith(void Function(StreamingInputCallResponse) updates) => super.copyWith((message) => updates(message as StreamingInputCallResponse));
  $pb.BuilderInfo get info_ => _i;
  static StreamingInputCallResponse create() => new StreamingInputCallResponse();
  StreamingInputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallResponse> createRepeated() => new $pb.PbList<StreamingInputCallResponse>();
  static StreamingInputCallResponse getDefault() => _defaultInstance ??= create()..freeze();
  static StreamingInputCallResponse _defaultInstance;
  static void $checkItem(StreamingInputCallResponse v) {
    if (v is! StreamingInputCallResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get aggregatedPayloadSize => $_get(0, 0);
  set aggregatedPayloadSize(int v) { $_setSignedInt32(0, v); }
  bool hasAggregatedPayloadSize() => $_has(0);
  void clearAggregatedPayloadSize() => clearField(1);
}

class ResponseParameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ResponseParameters', package: const $pb.PackageName('grpc.testing'))
    ..a<int>(1, 'size', $pb.PbFieldType.O3)
    ..a<int>(2, 'intervalUs', $pb.PbFieldType.O3)
    ..a<BoolValue>(3, 'compressed', $pb.PbFieldType.OM, BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false
  ;

  ResponseParameters() : super();
  ResponseParameters.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResponseParameters.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResponseParameters clone() => new ResponseParameters()..mergeFromMessage(this);
  ResponseParameters copyWith(void Function(ResponseParameters) updates) => super.copyWith((message) => updates(message as ResponseParameters));
  $pb.BuilderInfo get info_ => _i;
  static ResponseParameters create() => new ResponseParameters();
  ResponseParameters createEmptyInstance() => create();
  static $pb.PbList<ResponseParameters> createRepeated() => new $pb.PbList<ResponseParameters>();
  static ResponseParameters getDefault() => _defaultInstance ??= create()..freeze();
  static ResponseParameters _defaultInstance;
  static void $checkItem(ResponseParameters v) {
    if (v is! ResponseParameters) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get size => $_get(0, 0);
  set size(int v) { $_setSignedInt32(0, v); }
  bool hasSize() => $_has(0);
  void clearSize() => clearField(1);

  int get intervalUs => $_get(1, 0);
  set intervalUs(int v) { $_setSignedInt32(1, v); }
  bool hasIntervalUs() => $_has(1);
  void clearIntervalUs() => clearField(2);

  BoolValue get compressed => $_getN(2);
  set compressed(BoolValue v) { setField(3, v); }
  bool hasCompressed() => $_has(2);
  void clearCompressed() => clearField(3);
}

class StreamingOutputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('StreamingOutputCallRequest', package: const $pb.PackageName('grpc.testing'))
    ..e<PayloadType>(1, 'responseType', $pb.PbFieldType.OE, PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
    ..pp<ResponseParameters>(2, 'responseParameters', $pb.PbFieldType.PM, ResponseParameters.$checkItem, ResponseParameters.create)
    ..a<Payload>(3, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<EchoStatus>(7, 'responseStatus', $pb.PbFieldType.OM, EchoStatus.getDefault, EchoStatus.create)
    ..hasRequiredFields = false
  ;

  StreamingOutputCallRequest() : super();
  StreamingOutputCallRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingOutputCallRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingOutputCallRequest clone() => new StreamingOutputCallRequest()..mergeFromMessage(this);
  StreamingOutputCallRequest copyWith(void Function(StreamingOutputCallRequest) updates) => super.copyWith((message) => updates(message as StreamingOutputCallRequest));
  $pb.BuilderInfo get info_ => _i;
  static StreamingOutputCallRequest create() => new StreamingOutputCallRequest();
  StreamingOutputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallRequest> createRepeated() => new $pb.PbList<StreamingOutputCallRequest>();
  static StreamingOutputCallRequest getDefault() => _defaultInstance ??= create()..freeze();
  static StreamingOutputCallRequest _defaultInstance;
  static void $checkItem(StreamingOutputCallRequest v) {
    if (v is! StreamingOutputCallRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  PayloadType get responseType => $_getN(0);
  set responseType(PayloadType v) { setField(1, v); }
  bool hasResponseType() => $_has(0);
  void clearResponseType() => clearField(1);

  List<ResponseParameters> get responseParameters => $_getList(1);

  Payload get payload => $_getN(2);
  set payload(Payload v) { setField(3, v); }
  bool hasPayload() => $_has(2);
  void clearPayload() => clearField(3);

  EchoStatus get responseStatus => $_getN(3);
  set responseStatus(EchoStatus v) { setField(7, v); }
  bool hasResponseStatus() => $_has(3);
  void clearResponseStatus() => clearField(7);
}

class StreamingOutputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('StreamingOutputCallResponse', package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..hasRequiredFields = false
  ;

  StreamingOutputCallResponse() : super();
  StreamingOutputCallResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StreamingOutputCallResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StreamingOutputCallResponse clone() => new StreamingOutputCallResponse()..mergeFromMessage(this);
  StreamingOutputCallResponse copyWith(void Function(StreamingOutputCallResponse) updates) => super.copyWith((message) => updates(message as StreamingOutputCallResponse));
  $pb.BuilderInfo get info_ => _i;
  static StreamingOutputCallResponse create() => new StreamingOutputCallResponse();
  StreamingOutputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallResponse> createRepeated() => new $pb.PbList<StreamingOutputCallResponse>();
  static StreamingOutputCallResponse getDefault() => _defaultInstance ??= create()..freeze();
  static StreamingOutputCallResponse _defaultInstance;
  static void $checkItem(StreamingOutputCallResponse v) {
    if (v is! StreamingOutputCallResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  Payload get payload => $_getN(0);
  set payload(Payload v) { setField(1, v); }
  bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);
}

class ReconnectParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ReconnectParams', package: const $pb.PackageName('grpc.testing'))
    ..a<int>(1, 'maxReconnectBackoffMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ReconnectParams() : super();
  ReconnectParams.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReconnectParams.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReconnectParams clone() => new ReconnectParams()..mergeFromMessage(this);
  ReconnectParams copyWith(void Function(ReconnectParams) updates) => super.copyWith((message) => updates(message as ReconnectParams));
  $pb.BuilderInfo get info_ => _i;
  static ReconnectParams create() => new ReconnectParams();
  ReconnectParams createEmptyInstance() => create();
  static $pb.PbList<ReconnectParams> createRepeated() => new $pb.PbList<ReconnectParams>();
  static ReconnectParams getDefault() => _defaultInstance ??= create()..freeze();
  static ReconnectParams _defaultInstance;
  static void $checkItem(ReconnectParams v) {
    if (v is! ReconnectParams) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get maxReconnectBackoffMs => $_get(0, 0);
  set maxReconnectBackoffMs(int v) { $_setSignedInt32(0, v); }
  bool hasMaxReconnectBackoffMs() => $_has(0);
  void clearMaxReconnectBackoffMs() => clearField(1);
}

class ReconnectInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ReconnectInfo', package: const $pb.PackageName('grpc.testing'))
    ..aOB(1, 'passed')
    ..p<int>(2, 'backoffMs', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  ReconnectInfo() : super();
  ReconnectInfo.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReconnectInfo.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReconnectInfo clone() => new ReconnectInfo()..mergeFromMessage(this);
  ReconnectInfo copyWith(void Function(ReconnectInfo) updates) => super.copyWith((message) => updates(message as ReconnectInfo));
  $pb.BuilderInfo get info_ => _i;
  static ReconnectInfo create() => new ReconnectInfo();
  ReconnectInfo createEmptyInstance() => create();
  static $pb.PbList<ReconnectInfo> createRepeated() => new $pb.PbList<ReconnectInfo>();
  static ReconnectInfo getDefault() => _defaultInstance ??= create()..freeze();
  static ReconnectInfo _defaultInstance;
  static void $checkItem(ReconnectInfo v) {
    if (v is! ReconnectInfo) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  bool get passed => $_get(0, false);
  set passed(bool v) { $_setBool(0, v); }
  bool hasPassed() => $_has(0);
  void clearPassed() => clearField(1);

  List<int> get backoffMs => $_getList(1);
}

