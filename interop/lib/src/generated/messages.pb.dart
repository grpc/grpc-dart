///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library grpc.testing_messages;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

class BoolValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BoolValue')
    ..a<bool>(1, 'value', PbFieldType.OB)
    ..hasRequiredFields = false;

  BoolValue() : super();
  BoolValue.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  BoolValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  BoolValue clone() => new BoolValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BoolValue create() => new BoolValue();
  static PbList<BoolValue> createRepeated() => new PbList<BoolValue>();
  static BoolValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBoolValue();
    return _defaultInstance;
  }

  static BoolValue _defaultInstance;
  static void $checkItem(BoolValue v) {
    if (v is! BoolValue) checkItemFailed(v, 'BoolValue');
  }

  bool get value => $_get(0, 1, false);
  set value(bool v) {
    $_setBool(0, 1, v);
  }

  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyBoolValue extends BoolValue with ReadonlyMessageMixin {}

class Payload extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Payload')
    ..e<PayloadType>(1, 'type', PbFieldType.OE, PayloadType.COMPRESSABLE,
        PayloadType.valueOf)
    ..a<List<int>>(2, 'body', PbFieldType.OY)
    ..hasRequiredFields = false;

  Payload() : super();
  Payload.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Payload.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Payload clone() => new Payload()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Payload create() => new Payload();
  static PbList<Payload> createRepeated() => new PbList<Payload>();
  static Payload getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPayload();
    return _defaultInstance;
  }

  static Payload _defaultInstance;
  static void $checkItem(Payload v) {
    if (v is! Payload) checkItemFailed(v, 'Payload');
  }

  PayloadType get type => $_get(0, 1, null);
  set type(PayloadType v) {
    setField(1, v);
  }

  bool hasType() => $_has(0, 1);
  void clearType() => clearField(1);

  List<int> get body => $_get(1, 2, null);
  set body(List<int> v) {
    $_setBytes(1, 2, v);
  }

  bool hasBody() => $_has(1, 2);
  void clearBody() => clearField(2);
}

class _ReadonlyPayload extends Payload with ReadonlyMessageMixin {}

class EchoStatus extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EchoStatus')
    ..a<int>(1, 'code', PbFieldType.O3)
    ..a<String>(2, 'message', PbFieldType.OS)
    ..hasRequiredFields = false;

  EchoStatus() : super();
  EchoStatus.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  EchoStatus.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  EchoStatus clone() => new EchoStatus()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EchoStatus create() => new EchoStatus();
  static PbList<EchoStatus> createRepeated() => new PbList<EchoStatus>();
  static EchoStatus getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEchoStatus();
    return _defaultInstance;
  }

  static EchoStatus _defaultInstance;
  static void $checkItem(EchoStatus v) {
    if (v is! EchoStatus) checkItemFailed(v, 'EchoStatus');
  }

  int get code => $_get(0, 1, 0);
  set code(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasCode() => $_has(0, 1);
  void clearCode() => clearField(1);

  String get message => $_get(1, 2, '');
  set message(String v) {
    $_setString(1, 2, v);
  }

  bool hasMessage() => $_has(1, 2);
  void clearMessage() => clearField(2);
}

class _ReadonlyEchoStatus extends EchoStatus with ReadonlyMessageMixin {}

class SimpleRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SimpleRequest')
    ..e<PayloadType>(1, 'responseType', PbFieldType.OE,
        PayloadType.COMPRESSABLE, PayloadType.valueOf)
    ..a<int>(2, 'responseSize', PbFieldType.O3)
    ..a<Payload>(
        3, 'payload', PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<bool>(4, 'fillUsername', PbFieldType.OB)
    ..a<bool>(5, 'fillOauthScope', PbFieldType.OB)
    ..a<BoolValue>(6, 'responseCompressed', PbFieldType.OM,
        BoolValue.getDefault, BoolValue.create)
    ..a<EchoStatus>(7, 'responseStatus', PbFieldType.OM, EchoStatus.getDefault,
        EchoStatus.create)
    ..a<BoolValue>(8, 'expectCompressed', PbFieldType.OM, BoolValue.getDefault,
        BoolValue.create)
    ..hasRequiredFields = false;

  SimpleRequest() : super();
  SimpleRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  SimpleRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  SimpleRequest clone() => new SimpleRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SimpleRequest create() => new SimpleRequest();
  static PbList<SimpleRequest> createRepeated() => new PbList<SimpleRequest>();
  static SimpleRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlySimpleRequest();
    return _defaultInstance;
  }

  static SimpleRequest _defaultInstance;
  static void $checkItem(SimpleRequest v) {
    if (v is! SimpleRequest) checkItemFailed(v, 'SimpleRequest');
  }

  PayloadType get responseType => $_get(0, 1, null);
  set responseType(PayloadType v) {
    setField(1, v);
  }

  bool hasResponseType() => $_has(0, 1);
  void clearResponseType() => clearField(1);

  int get responseSize => $_get(1, 2, 0);
  set responseSize(int v) {
    $_setUnsignedInt32(1, 2, v);
  }

  bool hasResponseSize() => $_has(1, 2);
  void clearResponseSize() => clearField(2);

  Payload get payload => $_get(2, 3, null);
  set payload(Payload v) {
    setField(3, v);
  }

  bool hasPayload() => $_has(2, 3);
  void clearPayload() => clearField(3);

  bool get fillUsername => $_get(3, 4, false);
  set fillUsername(bool v) {
    $_setBool(3, 4, v);
  }

  bool hasFillUsername() => $_has(3, 4);
  void clearFillUsername() => clearField(4);

  bool get fillOauthScope => $_get(4, 5, false);
  set fillOauthScope(bool v) {
    $_setBool(4, 5, v);
  }

  bool hasFillOauthScope() => $_has(4, 5);
  void clearFillOauthScope() => clearField(5);

  BoolValue get responseCompressed => $_get(5, 6, null);
  set responseCompressed(BoolValue v) {
    setField(6, v);
  }

  bool hasResponseCompressed() => $_has(5, 6);
  void clearResponseCompressed() => clearField(6);

  EchoStatus get responseStatus => $_get(6, 7, null);
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  bool hasResponseStatus() => $_has(6, 7);
  void clearResponseStatus() => clearField(7);

  BoolValue get expectCompressed => $_get(7, 8, null);
  set expectCompressed(BoolValue v) {
    setField(8, v);
  }

  bool hasExpectCompressed() => $_has(7, 8);
  void clearExpectCompressed() => clearField(8);
}

class _ReadonlySimpleRequest extends SimpleRequest with ReadonlyMessageMixin {}

class SimpleResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SimpleResponse')
    ..a<Payload>(
        1, 'payload', PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<String>(2, 'username', PbFieldType.OS)
    ..a<String>(3, 'oauthScope', PbFieldType.OS)
    ..hasRequiredFields = false;

  SimpleResponse() : super();
  SimpleResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  SimpleResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  SimpleResponse clone() => new SimpleResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SimpleResponse create() => new SimpleResponse();
  static PbList<SimpleResponse> createRepeated() =>
      new PbList<SimpleResponse>();
  static SimpleResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlySimpleResponse();
    return _defaultInstance;
  }

  static SimpleResponse _defaultInstance;
  static void $checkItem(SimpleResponse v) {
    if (v is! SimpleResponse) checkItemFailed(v, 'SimpleResponse');
  }

  Payload get payload => $_get(0, 1, null);
  set payload(Payload v) {
    setField(1, v);
  }

  bool hasPayload() => $_has(0, 1);
  void clearPayload() => clearField(1);

  String get username => $_get(1, 2, '');
  set username(String v) {
    $_setString(1, 2, v);
  }

  bool hasUsername() => $_has(1, 2);
  void clearUsername() => clearField(2);

  String get oauthScope => $_get(2, 3, '');
  set oauthScope(String v) {
    $_setString(2, 3, v);
  }

  bool hasOauthScope() => $_has(2, 3);
  void clearOauthScope() => clearField(3);
}

class _ReadonlySimpleResponse extends SimpleResponse with ReadonlyMessageMixin {
}

class StreamingInputCallRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingInputCallRequest')
    ..a<Payload>(
        1, 'payload', PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<BoolValue>(2, 'expectCompressed', PbFieldType.OM, BoolValue.getDefault,
        BoolValue.create)
    ..hasRequiredFields = false;

  StreamingInputCallRequest() : super();
  StreamingInputCallRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  StreamingInputCallRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  StreamingInputCallRequest clone() =>
      new StreamingInputCallRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingInputCallRequest create() => new StreamingInputCallRequest();
  static PbList<StreamingInputCallRequest> createRepeated() =>
      new PbList<StreamingInputCallRequest>();
  static StreamingInputCallRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyStreamingInputCallRequest();
    return _defaultInstance;
  }

  static StreamingInputCallRequest _defaultInstance;
  static void $checkItem(StreamingInputCallRequest v) {
    if (v is! StreamingInputCallRequest)
      checkItemFailed(v, 'StreamingInputCallRequest');
  }

  Payload get payload => $_get(0, 1, null);
  set payload(Payload v) {
    setField(1, v);
  }

  bool hasPayload() => $_has(0, 1);
  void clearPayload() => clearField(1);

  BoolValue get expectCompressed => $_get(1, 2, null);
  set expectCompressed(BoolValue v) {
    setField(2, v);
  }

  bool hasExpectCompressed() => $_has(1, 2);
  void clearExpectCompressed() => clearField(2);
}

class _ReadonlyStreamingInputCallRequest extends StreamingInputCallRequest
    with ReadonlyMessageMixin {}

class StreamingInputCallResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingInputCallResponse')
    ..a<int>(1, 'aggregatedPayloadSize', PbFieldType.O3)
    ..hasRequiredFields = false;

  StreamingInputCallResponse() : super();
  StreamingInputCallResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  StreamingInputCallResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  StreamingInputCallResponse clone() =>
      new StreamingInputCallResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingInputCallResponse create() =>
      new StreamingInputCallResponse();
  static PbList<StreamingInputCallResponse> createRepeated() =>
      new PbList<StreamingInputCallResponse>();
  static StreamingInputCallResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyStreamingInputCallResponse();
    return _defaultInstance;
  }

  static StreamingInputCallResponse _defaultInstance;
  static void $checkItem(StreamingInputCallResponse v) {
    if (v is! StreamingInputCallResponse)
      checkItemFailed(v, 'StreamingInputCallResponse');
  }

  int get aggregatedPayloadSize => $_get(0, 1, 0);
  set aggregatedPayloadSize(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasAggregatedPayloadSize() => $_has(0, 1);
  void clearAggregatedPayloadSize() => clearField(1);
}

class _ReadonlyStreamingInputCallResponse extends StreamingInputCallResponse
    with ReadonlyMessageMixin {}

class ResponseParameters extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResponseParameters')
    ..a<int>(1, 'size', PbFieldType.O3)
    ..a<int>(2, 'intervalUs', PbFieldType.O3)
    ..a<BoolValue>(
        3, 'compressed', PbFieldType.OM, BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false;

  ResponseParameters() : super();
  ResponseParameters.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ResponseParameters.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ResponseParameters clone() =>
      new ResponseParameters()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResponseParameters create() => new ResponseParameters();
  static PbList<ResponseParameters> createRepeated() =>
      new PbList<ResponseParameters>();
  static ResponseParameters getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyResponseParameters();
    return _defaultInstance;
  }

  static ResponseParameters _defaultInstance;
  static void $checkItem(ResponseParameters v) {
    if (v is! ResponseParameters) checkItemFailed(v, 'ResponseParameters');
  }

  int get size => $_get(0, 1, 0);
  set size(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasSize() => $_has(0, 1);
  void clearSize() => clearField(1);

  int get intervalUs => $_get(1, 2, 0);
  set intervalUs(int v) {
    $_setUnsignedInt32(1, 2, v);
  }

  bool hasIntervalUs() => $_has(1, 2);
  void clearIntervalUs() => clearField(2);

  BoolValue get compressed => $_get(2, 3, null);
  set compressed(BoolValue v) {
    setField(3, v);
  }

  bool hasCompressed() => $_has(2, 3);
  void clearCompressed() => clearField(3);
}

class _ReadonlyResponseParameters extends ResponseParameters
    with ReadonlyMessageMixin {}

class StreamingOutputCallRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingOutputCallRequest')
    ..e<PayloadType>(1, 'responseType', PbFieldType.OE,
        PayloadType.COMPRESSABLE, PayloadType.valueOf)
    ..pp<ResponseParameters>(2, 'responseParameters', PbFieldType.PM,
        ResponseParameters.$checkItem, ResponseParameters.create)
    ..a<Payload>(
        3, 'payload', PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<EchoStatus>(7, 'responseStatus', PbFieldType.OM, EchoStatus.getDefault,
        EchoStatus.create)
    ..hasRequiredFields = false;

  StreamingOutputCallRequest() : super();
  StreamingOutputCallRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  StreamingOutputCallRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  StreamingOutputCallRequest clone() =>
      new StreamingOutputCallRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingOutputCallRequest create() =>
      new StreamingOutputCallRequest();
  static PbList<StreamingOutputCallRequest> createRepeated() =>
      new PbList<StreamingOutputCallRequest>();
  static StreamingOutputCallRequest getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyStreamingOutputCallRequest();
    return _defaultInstance;
  }

  static StreamingOutputCallRequest _defaultInstance;
  static void $checkItem(StreamingOutputCallRequest v) {
    if (v is! StreamingOutputCallRequest)
      checkItemFailed(v, 'StreamingOutputCallRequest');
  }

  PayloadType get responseType => $_get(0, 1, null);
  set responseType(PayloadType v) {
    setField(1, v);
  }

  bool hasResponseType() => $_has(0, 1);
  void clearResponseType() => clearField(1);

  List<ResponseParameters> get responseParameters => $_get(1, 2, null);

  Payload get payload => $_get(2, 3, null);
  set payload(Payload v) {
    setField(3, v);
  }

  bool hasPayload() => $_has(2, 3);
  void clearPayload() => clearField(3);

  EchoStatus get responseStatus => $_get(3, 7, null);
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  bool hasResponseStatus() => $_has(3, 7);
  void clearResponseStatus() => clearField(7);
}

class _ReadonlyStreamingOutputCallRequest extends StreamingOutputCallRequest
    with ReadonlyMessageMixin {}

class StreamingOutputCallResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StreamingOutputCallResponse')
    ..a<Payload>(
        1, 'payload', PbFieldType.OM, Payload.getDefault, Payload.create)
    ..hasRequiredFields = false;

  StreamingOutputCallResponse() : super();
  StreamingOutputCallResponse.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  StreamingOutputCallResponse.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  StreamingOutputCallResponse clone() =>
      new StreamingOutputCallResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StreamingOutputCallResponse create() =>
      new StreamingOutputCallResponse();
  static PbList<StreamingOutputCallResponse> createRepeated() =>
      new PbList<StreamingOutputCallResponse>();
  static StreamingOutputCallResponse getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyStreamingOutputCallResponse();
    return _defaultInstance;
  }

  static StreamingOutputCallResponse _defaultInstance;
  static void $checkItem(StreamingOutputCallResponse v) {
    if (v is! StreamingOutputCallResponse)
      checkItemFailed(v, 'StreamingOutputCallResponse');
  }

  Payload get payload => $_get(0, 1, null);
  set payload(Payload v) {
    setField(1, v);
  }

  bool hasPayload() => $_has(0, 1);
  void clearPayload() => clearField(1);
}

class _ReadonlyStreamingOutputCallResponse extends StreamingOutputCallResponse
    with ReadonlyMessageMixin {}

class ReconnectParams extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReconnectParams')
    ..a<int>(1, 'maxReconnectBackoffMs', PbFieldType.O3)
    ..hasRequiredFields = false;

  ReconnectParams() : super();
  ReconnectParams.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ReconnectParams.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ReconnectParams clone() => new ReconnectParams()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReconnectParams create() => new ReconnectParams();
  static PbList<ReconnectParams> createRepeated() =>
      new PbList<ReconnectParams>();
  static ReconnectParams getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyReconnectParams();
    return _defaultInstance;
  }

  static ReconnectParams _defaultInstance;
  static void $checkItem(ReconnectParams v) {
    if (v is! ReconnectParams) checkItemFailed(v, 'ReconnectParams');
  }

  int get maxReconnectBackoffMs => $_get(0, 1, 0);
  set maxReconnectBackoffMs(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasMaxReconnectBackoffMs() => $_has(0, 1);
  void clearMaxReconnectBackoffMs() => clearField(1);
}

class _ReadonlyReconnectParams extends ReconnectParams
    with ReadonlyMessageMixin {}

class ReconnectInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReconnectInfo')
    ..a<bool>(1, 'passed', PbFieldType.OB)
    ..p<int>(2, 'backoffMs', PbFieldType.P3)
    ..hasRequiredFields = false;

  ReconnectInfo() : super();
  ReconnectInfo.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ReconnectInfo.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ReconnectInfo clone() => new ReconnectInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReconnectInfo create() => new ReconnectInfo();
  static PbList<ReconnectInfo> createRepeated() => new PbList<ReconnectInfo>();
  static ReconnectInfo getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyReconnectInfo();
    return _defaultInstance;
  }

  static ReconnectInfo _defaultInstance;
  static void $checkItem(ReconnectInfo v) {
    if (v is! ReconnectInfo) checkItemFailed(v, 'ReconnectInfo');
  }

  bool get passed => $_get(0, 1, false);
  set passed(bool v) {
    $_setBool(0, 1, v);
  }

  bool hasPassed() => $_has(0, 1);
  void clearPassed() => clearField(1);

  List<int> get backoffMs => $_get(1, 2, null);
}

class _ReadonlyReconnectInfo extends ReconnectInfo with ReadonlyMessageMixin {}
