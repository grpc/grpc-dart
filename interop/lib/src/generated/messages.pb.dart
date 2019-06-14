///
//  Generated code. Do not modify.
//  source: messages.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

class BoolValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BoolValue',
      package: const $pb.PackageName('grpc.testing'))
    ..aOB(1, 'value')
    ..hasRequiredFields = false;

  BoolValue._() : super();
  factory BoolValue() => create();
  factory BoolValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BoolValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  BoolValue clone() => BoolValue()..mergeFromMessage(this);
  BoolValue copyWith(void Function(BoolValue) updates) =>
      super.copyWith((message) => updates(message as BoolValue));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BoolValue create() => BoolValue._();
  BoolValue createEmptyInstance() => create();
  static $pb.PbList<BoolValue> createRepeated() => $pb.PbList<BoolValue>();
  static BoolValue getDefault() => _defaultInstance ??= create()..freeze();
  static BoolValue _defaultInstance;

  $core.bool get value => $_get(0, false);
  set value($core.bool v) {
    $_setBool(0, v);
  }

  $core.bool hasValue() => $_has(0);
  void clearValue() => clearField(1);
}

class Payload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Payload', package: const $pb.PackageName('grpc.testing'))
        ..e<PayloadType>(1, 'type', $pb.PbFieldType.OE,
            PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
        ..a<$core.List<$core.int>>(2, 'body', $pb.PbFieldType.OY)
        ..hasRequiredFields = false;

  Payload._() : super();
  factory Payload() => create();
  factory Payload.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Payload.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Payload clone() => Payload()..mergeFromMessage(this);
  Payload copyWith(void Function(Payload) updates) =>
      super.copyWith((message) => updates(message as Payload));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => $pb.PbList<Payload>();
  static Payload getDefault() => _defaultInstance ??= create()..freeze();
  static Payload _defaultInstance;

  PayloadType get type => $_getN(0);
  set type(PayloadType v) {
    setField(1, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.List<$core.int> get body => $_getN(1);
  set body($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  $core.bool hasBody() => $_has(1);
  void clearBody() => clearField(2);
}

class EchoStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('EchoStatus',
      package: const $pb.PackageName('grpc.testing'))
    ..a<$core.int>(1, 'code', $pb.PbFieldType.O3)
    ..aOS(2, 'message')
    ..hasRequiredFields = false;

  EchoStatus._() : super();
  factory EchoStatus() => create();
  factory EchoStatus.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EchoStatus.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  EchoStatus clone() => EchoStatus()..mergeFromMessage(this);
  EchoStatus copyWith(void Function(EchoStatus) updates) =>
      super.copyWith((message) => updates(message as EchoStatus));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EchoStatus create() => EchoStatus._();
  EchoStatus createEmptyInstance() => create();
  static $pb.PbList<EchoStatus> createRepeated() => $pb.PbList<EchoStatus>();
  static EchoStatus getDefault() => _defaultInstance ??= create()..freeze();
  static EchoStatus _defaultInstance;

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
}

class SimpleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SimpleRequest',
      package: const $pb.PackageName('grpc.testing'))
    ..e<PayloadType>(1, 'responseType', $pb.PbFieldType.OE,
        PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
    ..a<$core.int>(2, 'responseSize', $pb.PbFieldType.O3)
    ..a<Payload>(
        3, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..aOB(4, 'fillUsername')
    ..aOB(5, 'fillOauthScope')
    ..a<BoolValue>(6, 'responseCompressed', $pb.PbFieldType.OM,
        BoolValue.getDefault, BoolValue.create)
    ..a<EchoStatus>(7, 'responseStatus', $pb.PbFieldType.OM,
        EchoStatus.getDefault, EchoStatus.create)
    ..a<BoolValue>(8, 'expectCompressed', $pb.PbFieldType.OM,
        BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false;

  SimpleRequest._() : super();
  factory SimpleRequest() => create();
  factory SimpleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  SimpleRequest clone() => SimpleRequest()..mergeFromMessage(this);
  SimpleRequest copyWith(void Function(SimpleRequest) updates) =>
      super.copyWith((message) => updates(message as SimpleRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleRequest create() => SimpleRequest._();
  SimpleRequest createEmptyInstance() => create();
  static $pb.PbList<SimpleRequest> createRepeated() =>
      $pb.PbList<SimpleRequest>();
  static SimpleRequest getDefault() => _defaultInstance ??= create()..freeze();
  static SimpleRequest _defaultInstance;

  PayloadType get responseType => $_getN(0);
  set responseType(PayloadType v) {
    setField(1, v);
  }

  $core.bool hasResponseType() => $_has(0);
  void clearResponseType() => clearField(1);

  $core.int get responseSize => $_get(1, 0);
  set responseSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasResponseSize() => $_has(1);
  void clearResponseSize() => clearField(2);

  Payload get payload => $_getN(2);
  set payload(Payload v) {
    setField(3, v);
  }

  $core.bool hasPayload() => $_has(2);
  void clearPayload() => clearField(3);

  $core.bool get fillUsername => $_get(3, false);
  set fillUsername($core.bool v) {
    $_setBool(3, v);
  }

  $core.bool hasFillUsername() => $_has(3);
  void clearFillUsername() => clearField(4);

  $core.bool get fillOauthScope => $_get(4, false);
  set fillOauthScope($core.bool v) {
    $_setBool(4, v);
  }

  $core.bool hasFillOauthScope() => $_has(4);
  void clearFillOauthScope() => clearField(5);

  BoolValue get responseCompressed => $_getN(5);
  set responseCompressed(BoolValue v) {
    setField(6, v);
  }

  $core.bool hasResponseCompressed() => $_has(5);
  void clearResponseCompressed() => clearField(6);

  EchoStatus get responseStatus => $_getN(6);
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  $core.bool hasResponseStatus() => $_has(6);
  void clearResponseStatus() => clearField(7);

  BoolValue get expectCompressed => $_getN(7);
  set expectCompressed(BoolValue v) {
    setField(8, v);
  }

  $core.bool hasExpectCompressed() => $_has(7);
  void clearExpectCompressed() => clearField(8);
}

class SimpleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SimpleResponse',
      package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(
        1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..aOS(2, 'username')
    ..aOS(3, 'oauthScope')
    ..hasRequiredFields = false;

  SimpleResponse._() : super();
  factory SimpleResponse() => create();
  factory SimpleResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  SimpleResponse clone() => SimpleResponse()..mergeFromMessage(this);
  SimpleResponse copyWith(void Function(SimpleResponse) updates) =>
      super.copyWith((message) => updates(message as SimpleResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleResponse create() => SimpleResponse._();
  SimpleResponse createEmptyInstance() => create();
  static $pb.PbList<SimpleResponse> createRepeated() =>
      $pb.PbList<SimpleResponse>();
  static SimpleResponse getDefault() => _defaultInstance ??= create()..freeze();
  static SimpleResponse _defaultInstance;

  Payload get payload => $_getN(0);
  set payload(Payload v) {
    setField(1, v);
  }

  $core.bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);

  $core.String get username => $_getS(1, '');
  set username($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasUsername() => $_has(1);
  void clearUsername() => clearField(2);

  $core.String get oauthScope => $_getS(2, '');
  set oauthScope($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasOauthScope() => $_has(2);
  void clearOauthScope() => clearField(3);
}

class StreamingInputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StreamingInputCallRequest',
      package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(
        1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<BoolValue>(2, 'expectCompressed', $pb.PbFieldType.OM,
        BoolValue.getDefault, BoolValue.create)
    ..hasRequiredFields = false;

  StreamingInputCallRequest._() : super();
  factory StreamingInputCallRequest() => create();
  factory StreamingInputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StreamingInputCallRequest clone() =>
      StreamingInputCallRequest()..mergeFromMessage(this);
  StreamingInputCallRequest copyWith(
          void Function(StreamingInputCallRequest) updates) =>
      super
          .copyWith((message) => updates(message as StreamingInputCallRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallRequest create() => StreamingInputCallRequest._();
  StreamingInputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallRequest> createRepeated() =>
      $pb.PbList<StreamingInputCallRequest>();
  static StreamingInputCallRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static StreamingInputCallRequest _defaultInstance;

  Payload get payload => $_getN(0);
  set payload(Payload v) {
    setField(1, v);
  }

  $core.bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);

  BoolValue get expectCompressed => $_getN(1);
  set expectCompressed(BoolValue v) {
    setField(2, v);
  }

  $core.bool hasExpectCompressed() => $_has(1);
  void clearExpectCompressed() => clearField(2);
}

class StreamingInputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'StreamingInputCallResponse',
      package: const $pb.PackageName('grpc.testing'))
    ..a<$core.int>(1, 'aggregatedPayloadSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  StreamingInputCallResponse._() : super();
  factory StreamingInputCallResponse() => create();
  factory StreamingInputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StreamingInputCallResponse clone() =>
      StreamingInputCallResponse()..mergeFromMessage(this);
  StreamingInputCallResponse copyWith(
          void Function(StreamingInputCallResponse) updates) =>
      super.copyWith(
          (message) => updates(message as StreamingInputCallResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallResponse create() => StreamingInputCallResponse._();
  StreamingInputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallResponse> createRepeated() =>
      $pb.PbList<StreamingInputCallResponse>();
  static StreamingInputCallResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static StreamingInputCallResponse _defaultInstance;

  $core.int get aggregatedPayloadSize => $_get(0, 0);
  set aggregatedPayloadSize($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasAggregatedPayloadSize() => $_has(0);
  void clearAggregatedPayloadSize() => clearField(1);
}

class ResponseParameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResponseParameters',
      package: const $pb.PackageName('grpc.testing'))
    ..a<$core.int>(1, 'size', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'intervalUs', $pb.PbFieldType.O3)
    ..a<BoolValue>(3, 'compressed', $pb.PbFieldType.OM, BoolValue.getDefault,
        BoolValue.create)
    ..hasRequiredFields = false;

  ResponseParameters._() : super();
  factory ResponseParameters() => create();
  factory ResponseParameters.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResponseParameters.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ResponseParameters clone() => ResponseParameters()..mergeFromMessage(this);
  ResponseParameters copyWith(void Function(ResponseParameters) updates) =>
      super.copyWith((message) => updates(message as ResponseParameters));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResponseParameters create() => ResponseParameters._();
  ResponseParameters createEmptyInstance() => create();
  static $pb.PbList<ResponseParameters> createRepeated() =>
      $pb.PbList<ResponseParameters>();
  static ResponseParameters getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ResponseParameters _defaultInstance;

  $core.int get size => $_get(0, 0);
  set size($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasSize() => $_has(0);
  void clearSize() => clearField(1);

  $core.int get intervalUs => $_get(1, 0);
  set intervalUs($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasIntervalUs() => $_has(1);
  void clearIntervalUs() => clearField(2);

  BoolValue get compressed => $_getN(2);
  set compressed(BoolValue v) {
    setField(3, v);
  }

  $core.bool hasCompressed() => $_has(2);
  void clearCompressed() => clearField(3);
}

class StreamingOutputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'StreamingOutputCallRequest',
      package: const $pb.PackageName('grpc.testing'))
    ..e<PayloadType>(1, 'responseType', $pb.PbFieldType.OE,
        PayloadType.COMPRESSABLE, PayloadType.valueOf, PayloadType.values)
    ..pc<ResponseParameters>(
        2, 'responseParameters', $pb.PbFieldType.PM, ResponseParameters.create)
    ..a<Payload>(
        3, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..a<EchoStatus>(7, 'responseStatus', $pb.PbFieldType.OM,
        EchoStatus.getDefault, EchoStatus.create)
    ..hasRequiredFields = false;

  StreamingOutputCallRequest._() : super();
  factory StreamingOutputCallRequest() => create();
  factory StreamingOutputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StreamingOutputCallRequest clone() =>
      StreamingOutputCallRequest()..mergeFromMessage(this);
  StreamingOutputCallRequest copyWith(
          void Function(StreamingOutputCallRequest) updates) =>
      super.copyWith(
          (message) => updates(message as StreamingOutputCallRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallRequest create() => StreamingOutputCallRequest._();
  StreamingOutputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallRequest> createRepeated() =>
      $pb.PbList<StreamingOutputCallRequest>();
  static StreamingOutputCallRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static StreamingOutputCallRequest _defaultInstance;

  PayloadType get responseType => $_getN(0);
  set responseType(PayloadType v) {
    setField(1, v);
  }

  $core.bool hasResponseType() => $_has(0);
  void clearResponseType() => clearField(1);

  $core.List<ResponseParameters> get responseParameters => $_getList(1);

  Payload get payload => $_getN(2);
  set payload(Payload v) {
    setField(3, v);
  }

  $core.bool hasPayload() => $_has(2);
  void clearPayload() => clearField(3);

  EchoStatus get responseStatus => $_getN(3);
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  $core.bool hasResponseStatus() => $_has(3);
  void clearResponseStatus() => clearField(7);
}

class StreamingOutputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'StreamingOutputCallResponse',
      package: const $pb.PackageName('grpc.testing'))
    ..a<Payload>(
        1, 'payload', $pb.PbFieldType.OM, Payload.getDefault, Payload.create)
    ..hasRequiredFields = false;

  StreamingOutputCallResponse._() : super();
  factory StreamingOutputCallResponse() => create();
  factory StreamingOutputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  StreamingOutputCallResponse clone() =>
      StreamingOutputCallResponse()..mergeFromMessage(this);
  StreamingOutputCallResponse copyWith(
          void Function(StreamingOutputCallResponse) updates) =>
      super.copyWith(
          (message) => updates(message as StreamingOutputCallResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallResponse create() =>
      StreamingOutputCallResponse._();
  StreamingOutputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallResponse> createRepeated() =>
      $pb.PbList<StreamingOutputCallResponse>();
  static StreamingOutputCallResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static StreamingOutputCallResponse _defaultInstance;

  Payload get payload => $_getN(0);
  set payload(Payload v) {
    setField(1, v);
  }

  $core.bool hasPayload() => $_has(0);
  void clearPayload() => clearField(1);
}

class ReconnectParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReconnectParams',
      package: const $pb.PackageName('grpc.testing'))
    ..a<$core.int>(1, 'maxReconnectBackoffMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ReconnectParams._() : super();
  factory ReconnectParams() => create();
  factory ReconnectParams.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectParams.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ReconnectParams clone() => ReconnectParams()..mergeFromMessage(this);
  ReconnectParams copyWith(void Function(ReconnectParams) updates) =>
      super.copyWith((message) => updates(message as ReconnectParams));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconnectParams create() => ReconnectParams._();
  ReconnectParams createEmptyInstance() => create();
  static $pb.PbList<ReconnectParams> createRepeated() =>
      $pb.PbList<ReconnectParams>();
  static ReconnectParams getDefault() =>
      _defaultInstance ??= create()..freeze();
  static ReconnectParams _defaultInstance;

  $core.int get maxReconnectBackoffMs => $_get(0, 0);
  set maxReconnectBackoffMs($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasMaxReconnectBackoffMs() => $_has(0);
  void clearMaxReconnectBackoffMs() => clearField(1);
}

class ReconnectInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ReconnectInfo',
      package: const $pb.PackageName('grpc.testing'))
    ..aOB(1, 'passed')
    ..p<$core.int>(2, 'backoffMs', $pb.PbFieldType.P3)
    ..hasRequiredFields = false;

  ReconnectInfo._() : super();
  factory ReconnectInfo() => create();
  factory ReconnectInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ReconnectInfo clone() => ReconnectInfo()..mergeFromMessage(this);
  ReconnectInfo copyWith(void Function(ReconnectInfo) updates) =>
      super.copyWith((message) => updates(message as ReconnectInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconnectInfo create() => ReconnectInfo._();
  ReconnectInfo createEmptyInstance() => create();
  static $pb.PbList<ReconnectInfo> createRepeated() =>
      $pb.PbList<ReconnectInfo>();
  static ReconnectInfo getDefault() => _defaultInstance ??= create()..freeze();
  static ReconnectInfo _defaultInstance;

  $core.bool get passed => $_get(0, false);
  set passed($core.bool v) {
    $_setBool(0, v);
  }

  $core.bool hasPassed() => $_has(0);
  void clearPassed() => clearField(1);

  $core.List<$core.int> get backoffMs => $_getList(1);
}
