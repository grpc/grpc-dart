///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

class BoolValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BoolValue',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'value')
    ..hasRequiredFields = false;

  BoolValue._() : super();
  factory BoolValue({
    $core.bool? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory BoolValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BoolValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BoolValue clone() => BoolValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BoolValue copyWith(void Function(BoolValue) updates) =>
      super.copyWith((message) => updates(message as BoolValue))
          as BoolValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BoolValue create() => BoolValue._();
  BoolValue createEmptyInstance() => create();
  static $pb.PbList<BoolValue> createRepeated() => $pb.PbList<BoolValue>();
  @$core.pragma('dart2js:noInline')
  static BoolValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BoolValue>(create);
  static BoolValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class Payload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Payload',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type',
        $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..a<$core.List<$core.int>>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'body',
        $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  Payload._() : super();
  factory Payload({
    PayloadType? type,
    $core.List<$core.int>? body,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (body != null) {
      _result.body = body;
    }
    return _result;
  }
  factory Payload.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Payload.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Payload clone() => Payload()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Payload copyWith(void Function(Payload) updates) =>
      super.copyWith((message) => updates(message as Payload))
          as Payload; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => $pb.PbList<Payload>();
  @$core.pragma('dart2js:noInline')
  static Payload getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload>(create);
  static Payload? _defaultInstance;

  @$pb.TagNumber(1)
  PayloadType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(PayloadType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get body => $_getN(1);
  @$pb.TagNumber(2)
  set body($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);
}

class EchoStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'EchoStatus',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'code',
        $pb.PbFieldType.O3)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  EchoStatus._() : super();
  factory EchoStatus({
    $core.int? code,
    $core.String? message,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory EchoStatus.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EchoStatus.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EchoStatus clone() => EchoStatus()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EchoStatus copyWith(void Function(EchoStatus) updates) =>
      super.copyWith((message) => updates(message as EchoStatus))
          as EchoStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EchoStatus create() => EchoStatus._();
  EchoStatus createEmptyInstance() => create();
  static $pb.PbList<EchoStatus> createRepeated() => $pb.PbList<EchoStatus>();
  @$core.pragma('dart2js:noInline')
  static EchoStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoStatus>(create);
  static EchoStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class SimpleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SimpleRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseType',
        $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseSize',
        $pb.PbFieldType.O3)
    ..aOM<Payload>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'payload',
        subBuilder: Payload.create)
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fillUsername')
    ..aOB(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fillOauthScope')
    ..aOM<BoolValue>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseCompressed',
        subBuilder: BoolValue.create)
    ..aOM<EchoStatus>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseStatus',
        subBuilder: EchoStatus.create)
    ..aOM<BoolValue>(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'expectCompressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  SimpleRequest._() : super();
  factory SimpleRequest({
    PayloadType? responseType,
    $core.int? responseSize,
    Payload? payload,
    $core.bool? fillUsername,
    $core.bool? fillOauthScope,
    BoolValue? responseCompressed,
    EchoStatus? responseStatus,
    BoolValue? expectCompressed,
  }) {
    final _result = create();
    if (responseType != null) {
      _result.responseType = responseType;
    }
    if (responseSize != null) {
      _result.responseSize = responseSize;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    if (fillUsername != null) {
      _result.fillUsername = fillUsername;
    }
    if (fillOauthScope != null) {
      _result.fillOauthScope = fillOauthScope;
    }
    if (responseCompressed != null) {
      _result.responseCompressed = responseCompressed;
    }
    if (responseStatus != null) {
      _result.responseStatus = responseStatus;
    }
    if (expectCompressed != null) {
      _result.expectCompressed = expectCompressed;
    }
    return _result;
  }
  factory SimpleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SimpleRequest clone() => SimpleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SimpleRequest copyWith(void Function(SimpleRequest) updates) =>
      super.copyWith((message) => updates(message as SimpleRequest))
          as SimpleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleRequest create() => SimpleRequest._();
  SimpleRequest createEmptyInstance() => create();
  static $pb.PbList<SimpleRequest> createRepeated() =>
      $pb.PbList<SimpleRequest>();
  @$core.pragma('dart2js:noInline')
  static SimpleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleRequest>(create);
  static SimpleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PayloadType get responseType => $_getN(0);
  @$pb.TagNumber(1)
  set responseType(PayloadType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResponseType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get responseSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set responseSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResponseSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponseSize() => clearField(2);

  @$pb.TagNumber(3)
  Payload get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload(Payload v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => clearField(3);
  @$pb.TagNumber(3)
  Payload ensurePayload() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get fillUsername => $_getBF(3);
  @$pb.TagNumber(4)
  set fillUsername($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFillUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearFillUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get fillOauthScope => $_getBF(4);
  @$pb.TagNumber(5)
  set fillOauthScope($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFillOauthScope() => $_has(4);
  @$pb.TagNumber(5)
  void clearFillOauthScope() => clearField(5);

  @$pb.TagNumber(6)
  BoolValue get responseCompressed => $_getN(5);
  @$pb.TagNumber(6)
  set responseCompressed(BoolValue v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasResponseCompressed() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponseCompressed() => clearField(6);
  @$pb.TagNumber(6)
  BoolValue ensureResponseCompressed() => $_ensure(5);

  @$pb.TagNumber(7)
  EchoStatus get responseStatus => $_getN(6);
  @$pb.TagNumber(7)
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasResponseStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearResponseStatus() => clearField(7);
  @$pb.TagNumber(7)
  EchoStatus ensureResponseStatus() => $_ensure(6);

  @$pb.TagNumber(8)
  BoolValue get expectCompressed => $_getN(7);
  @$pb.TagNumber(8)
  set expectCompressed(BoolValue v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasExpectCompressed() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpectCompressed() => clearField(8);
  @$pb.TagNumber(8)
  BoolValue ensureExpectCompressed() => $_ensure(7);
}

class SimpleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SimpleResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'payload',
        subBuilder: Payload.create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'username')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'oauthScope')
    ..hasRequiredFields = false;

  SimpleResponse._() : super();
  factory SimpleResponse({
    Payload? payload,
    $core.String? username,
    $core.String? oauthScope,
  }) {
    final _result = create();
    if (payload != null) {
      _result.payload = payload;
    }
    if (username != null) {
      _result.username = username;
    }
    if (oauthScope != null) {
      _result.oauthScope = oauthScope;
    }
    return _result;
  }
  factory SimpleResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SimpleResponse clone() => SimpleResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SimpleResponse copyWith(void Function(SimpleResponse) updates) =>
      super.copyWith((message) => updates(message as SimpleResponse))
          as SimpleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SimpleResponse create() => SimpleResponse._();
  SimpleResponse createEmptyInstance() => create();
  static $pb.PbList<SimpleResponse> createRepeated() =>
      $pb.PbList<SimpleResponse>();
  @$core.pragma('dart2js:noInline')
  static SimpleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleResponse>(create);
  static SimpleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => clearField(1);
  @$pb.TagNumber(1)
  Payload ensurePayload() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get oauthScope => $_getSZ(2);
  @$pb.TagNumber(3)
  set oauthScope($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOauthScope() => $_has(2);
  @$pb.TagNumber(3)
  void clearOauthScope() => clearField(3);
}

class StreamingInputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'StreamingInputCallRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'payload',
        subBuilder: Payload.create)
    ..aOM<BoolValue>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'expectCompressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  StreamingInputCallRequest._() : super();
  factory StreamingInputCallRequest({
    Payload? payload,
    BoolValue? expectCompressed,
  }) {
    final _result = create();
    if (payload != null) {
      _result.payload = payload;
    }
    if (expectCompressed != null) {
      _result.expectCompressed = expectCompressed;
    }
    return _result;
  }
  factory StreamingInputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StreamingInputCallRequest clone() =>
      StreamingInputCallRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StreamingInputCallRequest copyWith(
          void Function(StreamingInputCallRequest) updates) =>
      super.copyWith((message) => updates(message as StreamingInputCallRequest))
          as StreamingInputCallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallRequest create() => StreamingInputCallRequest._();
  StreamingInputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallRequest> createRepeated() =>
      $pb.PbList<StreamingInputCallRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingInputCallRequest>(create);
  static StreamingInputCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => clearField(1);
  @$pb.TagNumber(1)
  Payload ensurePayload() => $_ensure(0);

  @$pb.TagNumber(2)
  BoolValue get expectCompressed => $_getN(1);
  @$pb.TagNumber(2)
  set expectCompressed(BoolValue v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExpectCompressed() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpectCompressed() => clearField(2);
  @$pb.TagNumber(2)
  BoolValue ensureExpectCompressed() => $_ensure(1);
}

class StreamingInputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'StreamingInputCallResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'aggregatedPayloadSize',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  StreamingInputCallResponse._() : super();
  factory StreamingInputCallResponse({
    $core.int? aggregatedPayloadSize,
  }) {
    final _result = create();
    if (aggregatedPayloadSize != null) {
      _result.aggregatedPayloadSize = aggregatedPayloadSize;
    }
    return _result;
  }
  factory StreamingInputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StreamingInputCallResponse clone() =>
      StreamingInputCallResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StreamingInputCallResponse copyWith(
          void Function(StreamingInputCallResponse) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingInputCallResponse))
          as StreamingInputCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallResponse create() => StreamingInputCallResponse._();
  StreamingInputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingInputCallResponse> createRepeated() =>
      $pb.PbList<StreamingInputCallResponse>();
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingInputCallResponse>(create);
  static StreamingInputCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get aggregatedPayloadSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set aggregatedPayloadSize($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAggregatedPayloadSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearAggregatedPayloadSize() => clearField(1);
}

class ResponseParameters extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ResponseParameters',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'size',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'intervalUs',
        $pb.PbFieldType.O3)
    ..aOM<BoolValue>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'compressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  ResponseParameters._() : super();
  factory ResponseParameters({
    $core.int? size,
    $core.int? intervalUs,
    BoolValue? compressed,
  }) {
    final _result = create();
    if (size != null) {
      _result.size = size;
    }
    if (intervalUs != null) {
      _result.intervalUs = intervalUs;
    }
    if (compressed != null) {
      _result.compressed = compressed;
    }
    return _result;
  }
  factory ResponseParameters.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResponseParameters.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResponseParameters clone() => ResponseParameters()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResponseParameters copyWith(void Function(ResponseParameters) updates) =>
      super.copyWith((message) => updates(message as ResponseParameters))
          as ResponseParameters; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResponseParameters create() => ResponseParameters._();
  ResponseParameters createEmptyInstance() => create();
  static $pb.PbList<ResponseParameters> createRepeated() =>
      $pb.PbList<ResponseParameters>();
  @$core.pragma('dart2js:noInline')
  static ResponseParameters getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResponseParameters>(create);
  static ResponseParameters? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get size => $_getIZ(0);
  @$pb.TagNumber(1)
  set size($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get intervalUs => $_getIZ(1);
  @$pb.TagNumber(2)
  set intervalUs($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIntervalUs() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntervalUs() => clearField(2);

  @$pb.TagNumber(3)
  BoolValue get compressed => $_getN(2);
  @$pb.TagNumber(3)
  set compressed(BoolValue v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCompressed() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompressed() => clearField(3);
  @$pb.TagNumber(3)
  BoolValue ensureCompressed() => $_ensure(2);
}

class StreamingOutputCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'StreamingOutputCallRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseType',
        $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..pc<ResponseParameters>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseParameters',
        $pb.PbFieldType.PM,
        subBuilder: ResponseParameters.create)
    ..aOM<Payload>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'payload',
        subBuilder: Payload.create)
    ..aOM<EchoStatus>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'responseStatus',
        subBuilder: EchoStatus.create)
    ..hasRequiredFields = false;

  StreamingOutputCallRequest._() : super();
  factory StreamingOutputCallRequest({
    PayloadType? responseType,
    $core.Iterable<ResponseParameters>? responseParameters,
    Payload? payload,
    EchoStatus? responseStatus,
  }) {
    final _result = create();
    if (responseType != null) {
      _result.responseType = responseType;
    }
    if (responseParameters != null) {
      _result.responseParameters.addAll(responseParameters);
    }
    if (payload != null) {
      _result.payload = payload;
    }
    if (responseStatus != null) {
      _result.responseStatus = responseStatus;
    }
    return _result;
  }
  factory StreamingOutputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StreamingOutputCallRequest clone() =>
      StreamingOutputCallRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StreamingOutputCallRequest copyWith(
          void Function(StreamingOutputCallRequest) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingOutputCallRequest))
          as StreamingOutputCallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallRequest create() => StreamingOutputCallRequest._();
  StreamingOutputCallRequest createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallRequest> createRepeated() =>
      $pb.PbList<StreamingOutputCallRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingOutputCallRequest>(create);
  static StreamingOutputCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PayloadType get responseType => $_getN(0);
  @$pb.TagNumber(1)
  set responseType(PayloadType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResponseType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ResponseParameters> get responseParameters => $_getList(1);

  @$pb.TagNumber(3)
  Payload get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload(Payload v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => clearField(3);
  @$pb.TagNumber(3)
  Payload ensurePayload() => $_ensure(2);

  @$pb.TagNumber(7)
  EchoStatus get responseStatus => $_getN(3);
  @$pb.TagNumber(7)
  set responseStatus(EchoStatus v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasResponseStatus() => $_has(3);
  @$pb.TagNumber(7)
  void clearResponseStatus() => clearField(7);
  @$pb.TagNumber(7)
  EchoStatus ensureResponseStatus() => $_ensure(3);
}

class StreamingOutputCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'StreamingOutputCallResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'payload',
        subBuilder: Payload.create)
    ..hasRequiredFields = false;

  StreamingOutputCallResponse._() : super();
  factory StreamingOutputCallResponse({
    Payload? payload,
  }) {
    final _result = create();
    if (payload != null) {
      _result.payload = payload;
    }
    return _result;
  }
  factory StreamingOutputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StreamingOutputCallResponse clone() =>
      StreamingOutputCallResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StreamingOutputCallResponse copyWith(
          void Function(StreamingOutputCallResponse) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingOutputCallResponse))
          as StreamingOutputCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallResponse create() =>
      StreamingOutputCallResponse._();
  StreamingOutputCallResponse createEmptyInstance() => create();
  static $pb.PbList<StreamingOutputCallResponse> createRepeated() =>
      $pb.PbList<StreamingOutputCallResponse>();
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingOutputCallResponse>(create);
  static StreamingOutputCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => clearField(1);
  @$pb.TagNumber(1)
  Payload ensurePayload() => $_ensure(0);
}

class ReconnectParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ReconnectParams',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'maxReconnectBackoffMs',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ReconnectParams._() : super();
  factory ReconnectParams({
    $core.int? maxReconnectBackoffMs,
  }) {
    final _result = create();
    if (maxReconnectBackoffMs != null) {
      _result.maxReconnectBackoffMs = maxReconnectBackoffMs;
    }
    return _result;
  }
  factory ReconnectParams.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectParams.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReconnectParams clone() => ReconnectParams()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReconnectParams copyWith(void Function(ReconnectParams) updates) =>
      super.copyWith((message) => updates(message as ReconnectParams))
          as ReconnectParams; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconnectParams create() => ReconnectParams._();
  ReconnectParams createEmptyInstance() => create();
  static $pb.PbList<ReconnectParams> createRepeated() =>
      $pb.PbList<ReconnectParams>();
  @$core.pragma('dart2js:noInline')
  static ReconnectParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconnectParams>(create);
  static ReconnectParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get maxReconnectBackoffMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set maxReconnectBackoffMs($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMaxReconnectBackoffMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxReconnectBackoffMs() => clearField(1);
}

class ReconnectInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ReconnectInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'passed')
    ..p<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'backoffMs',
        $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  ReconnectInfo._() : super();
  factory ReconnectInfo({
    $core.bool? passed,
    $core.Iterable<$core.int>? backoffMs,
  }) {
    final _result = create();
    if (passed != null) {
      _result.passed = passed;
    }
    if (backoffMs != null) {
      _result.backoffMs.addAll(backoffMs);
    }
    return _result;
  }
  factory ReconnectInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReconnectInfo clone() => ReconnectInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReconnectInfo copyWith(void Function(ReconnectInfo) updates) =>
      super.copyWith((message) => updates(message as ReconnectInfo))
          as ReconnectInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconnectInfo create() => ReconnectInfo._();
  ReconnectInfo createEmptyInstance() => create();
  static $pb.PbList<ReconnectInfo> createRepeated() =>
      $pb.PbList<ReconnectInfo>();
  @$core.pragma('dart2js:noInline')
  static ReconnectInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconnectInfo>(create);
  static ReconnectInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get passed => $_getBF(0);
  @$pb.TagNumber(1)
  set passed($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPassed() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassed() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get backoffMs => $_getList(1);
}
