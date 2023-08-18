//
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'messages.pbenum.dart';

/// TODO(dgq): Go back to using well-known types once
/// https://github.com/grpc/grpc/issues/6980 has been fixed.
/// import "google/protobuf/wrappers.proto";
class BoolValue extends $pb.GeneratedMessage {
  factory BoolValue({
    $core.bool? value,
  }) {
    final result = create();
    if (value != null) {
      result.value = value;
    }
    return result;
  }
  BoolValue._() : super();
  factory BoolValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BoolValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BoolValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BoolValue clone() => BoolValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BoolValue copyWith(void Function(BoolValue) updates) =>
      super.copyWith((message) => updates(message as BoolValue)) as BoolValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BoolValue create() => BoolValue._();
  BoolValue createEmptyInstance() => create();
  static $pb.PbList<BoolValue> createRepeated() => $pb.PbList<BoolValue>();
  @$core.pragma('dart2js:noInline')
  static BoolValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BoolValue>(create);
  static BoolValue? _defaultInstance;

  /// The bool value.
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

/// A block of data, to simply increase gRPC message size.
class Payload extends $pb.GeneratedMessage {
  factory Payload({
    PayloadType? type,
    $core.List<$core.int>? body,
  }) {
    final result = create();
    if (type != null) {
      result.type = type;
    }
    if (body != null) {
      result.body = body;
    }
    return result;
  }
  Payload._() : super();
  factory Payload.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Payload.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Payload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Payload clone() => Payload()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Payload copyWith(void Function(Payload) updates) =>
      super.copyWith((message) => updates(message as Payload)) as Payload;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  Payload createEmptyInstance() => create();
  static $pb.PbList<Payload> createRepeated() => $pb.PbList<Payload>();
  @$core.pragma('dart2js:noInline')
  static Payload getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload>(create);
  static Payload? _defaultInstance;

  /// DEPRECATED, don't use. To be removed shortly.
  /// The type of data in body.
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

  /// Primary contents of payload.
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

/// A protobuf representation for grpc status. This is used by test
/// clients to specify a status that the server should attempt to return.
class EchoStatus extends $pb.GeneratedMessage {
  factory EchoStatus({
    $core.int? code,
    $core.String? message,
  }) {
    final result = create();
    if (code != null) {
      result.code = code;
    }
    if (message != null) {
      result.message = message;
    }
    return result;
  }
  EchoStatus._() : super();
  factory EchoStatus.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EchoStatus.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EchoStatus clone() => EchoStatus()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EchoStatus copyWith(void Function(EchoStatus) updates) =>
      super.copyWith((message) => updates(message as EchoStatus)) as EchoStatus;

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

/// Unary request.
class SimpleRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (responseType != null) {
      result.responseType = responseType;
    }
    if (responseSize != null) {
      result.responseSize = responseSize;
    }
    if (payload != null) {
      result.payload = payload;
    }
    if (fillUsername != null) {
      result.fillUsername = fillUsername;
    }
    if (fillOauthScope != null) {
      result.fillOauthScope = fillOauthScope;
    }
    if (responseCompressed != null) {
      result.responseCompressed = responseCompressed;
    }
    if (responseStatus != null) {
      result.responseStatus = responseStatus;
    }
    if (expectCompressed != null) {
      result.expectCompressed = expectCompressed;
    }
    return result;
  }
  SimpleRequest._() : super();
  factory SimpleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(
        1, _omitFieldNames ? '' : 'responseType', $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'responseSize', $pb.PbFieldType.O3)
    ..aOM<Payload>(3, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOB(4, _omitFieldNames ? '' : 'fillUsername')
    ..aOB(5, _omitFieldNames ? '' : 'fillOauthScope')
    ..aOM<BoolValue>(6, _omitFieldNames ? '' : 'responseCompressed',
        subBuilder: BoolValue.create)
    ..aOM<EchoStatus>(7, _omitFieldNames ? '' : 'responseStatus',
        subBuilder: EchoStatus.create)
    ..aOM<BoolValue>(8, _omitFieldNames ? '' : 'expectCompressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SimpleRequest clone() => SimpleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SimpleRequest copyWith(void Function(SimpleRequest) updates) =>
      super.copyWith((message) => updates(message as SimpleRequest))
          as SimpleRequest;

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

  /// DEPRECATED, don't use. To be removed shortly.
  /// Desired payload type in the response from the server.
  /// If response_type is RANDOM, server randomly chooses one from other formats.
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

  /// Desired payload size in the response from the server.
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

  /// Optional input payload sent along with the request.
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

  /// Whether SimpleResponse should include username.
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

  /// Whether SimpleResponse should include OAuth scope.
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

  /// Whether to request the server to compress the response. This field is
  /// "nullable" in order to interoperate seamlessly with clients not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the response's compression status.
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

  /// Whether server should return a given status
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

  /// Whether the server should expect this request to be compressed.
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

/// Unary response, as configured by the request.
class SimpleResponse extends $pb.GeneratedMessage {
  factory SimpleResponse({
    Payload? payload,
    $core.String? username,
    $core.String? oauthScope,
  }) {
    final result = create();
    if (payload != null) {
      result.payload = payload;
    }
    if (username != null) {
      result.username = username;
    }
    if (oauthScope != null) {
      result.oauthScope = oauthScope;
    }
    return result;
  }
  SimpleResponse._() : super();
  factory SimpleResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SimpleResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'oauthScope')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SimpleResponse clone() => SimpleResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SimpleResponse copyWith(void Function(SimpleResponse) updates) =>
      super.copyWith((message) => updates(message as SimpleResponse))
          as SimpleResponse;

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

  /// Payload to increase message size.
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

  /// The user the request came from, for verifying authentication was
  /// successful when the client expected it.
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

  /// OAuth scope.
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

/// Client-streaming request.
class StreamingInputCallRequest extends $pb.GeneratedMessage {
  factory StreamingInputCallRequest({
    Payload? payload,
    BoolValue? expectCompressed,
  }) {
    final result = create();
    if (payload != null) {
      result.payload = payload;
    }
    if (expectCompressed != null) {
      result.expectCompressed = expectCompressed;
    }
    return result;
  }
  StreamingInputCallRequest._() : super();
  factory StreamingInputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingInputCallRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOM<BoolValue>(2, _omitFieldNames ? '' : 'expectCompressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

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
          as StreamingInputCallRequest;

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

  /// Optional input payload sent along with the request.
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

  /// Whether the server should expect this request to be compressed. This field
  /// is "nullable" in order to interoperate seamlessly with servers not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the request's compression status.
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

/// Client-streaming response.
class StreamingInputCallResponse extends $pb.GeneratedMessage {
  factory StreamingInputCallResponse({
    $core.int? aggregatedPayloadSize,
  }) {
    final result = create();
    if (aggregatedPayloadSize != null) {
      result.aggregatedPayloadSize = aggregatedPayloadSize;
    }
    return result;
  }
  StreamingInputCallResponse._() : super();
  factory StreamingInputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingInputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingInputCallResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'aggregatedPayloadSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

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
          as StreamingInputCallResponse;

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

  /// Aggregated size of payloads received from the client.
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

/// Configuration for a particular response.
class ResponseParameters extends $pb.GeneratedMessage {
  factory ResponseParameters({
    $core.int? size,
    $core.int? intervalUs,
    BoolValue? compressed,
  }) {
    final result = create();
    if (size != null) {
      result.size = size;
    }
    if (intervalUs != null) {
      result.intervalUs = intervalUs;
    }
    if (compressed != null) {
      result.compressed = compressed;
    }
    return result;
  }
  ResponseParameters._() : super();
  factory ResponseParameters.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResponseParameters.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResponseParameters',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'size', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'intervalUs', $pb.PbFieldType.O3)
    ..aOM<BoolValue>(3, _omitFieldNames ? '' : 'compressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResponseParameters clone() => ResponseParameters()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResponseParameters copyWith(void Function(ResponseParameters) updates) =>
      super.copyWith((message) => updates(message as ResponseParameters))
          as ResponseParameters;

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

  /// Desired payload sizes in responses from the server.
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

  /// Desired interval between consecutive responses in the response stream in
  /// microseconds.
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

  /// Whether to request the server to compress the response. This field is
  /// "nullable" in order to interoperate seamlessly with clients not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the response's compression status.
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

/// Server-streaming request.
class StreamingOutputCallRequest extends $pb.GeneratedMessage {
  factory StreamingOutputCallRequest({
    PayloadType? responseType,
    $core.Iterable<ResponseParameters>? responseParameters,
    Payload? payload,
    EchoStatus? responseStatus,
  }) {
    final result = create();
    if (responseType != null) {
      result.responseType = responseType;
    }
    if (responseParameters != null) {
      result.responseParameters.addAll(responseParameters);
    }
    if (payload != null) {
      result.payload = payload;
    }
    if (responseStatus != null) {
      result.responseStatus = responseStatus;
    }
    return result;
  }
  StreamingOutputCallRequest._() : super();
  factory StreamingOutputCallRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingOutputCallRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..e<PayloadType>(
        1, _omitFieldNames ? '' : 'responseType', $pb.PbFieldType.OE,
        defaultOrMaker: PayloadType.COMPRESSABLE,
        valueOf: PayloadType.valueOf,
        enumValues: PayloadType.values)
    ..pc<ResponseParameters>(
        2, _omitFieldNames ? '' : 'responseParameters', $pb.PbFieldType.PM,
        subBuilder: ResponseParameters.create)
    ..aOM<Payload>(3, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOM<EchoStatus>(7, _omitFieldNames ? '' : 'responseStatus',
        subBuilder: EchoStatus.create)
    ..hasRequiredFields = false;

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
          as StreamingOutputCallRequest;

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

  /// DEPRECATED, don't use. To be removed shortly.
  /// Desired payload type in the response from the server.
  /// If response_type is RANDOM, the payload from each response in the stream
  /// might be of different types. This is to simulate a mixed type of payload
  /// stream.
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

  /// Configuration for each expected response message.
  @$pb.TagNumber(2)
  $core.List<ResponseParameters> get responseParameters => $_getList(1);

  /// Optional input payload sent along with the request.
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

  /// Whether server should return a given status.
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

/// Server-streaming response, as configured by the request and parameters.
class StreamingOutputCallResponse extends $pb.GeneratedMessage {
  factory StreamingOutputCallResponse({
    Payload? payload,
  }) {
    final result = create();
    if (payload != null) {
      result.payload = payload;
    }
    return result;
  }
  StreamingOutputCallResponse._() : super();
  factory StreamingOutputCallResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StreamingOutputCallResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingOutputCallResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..hasRequiredFields = false;

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
          as StreamingOutputCallResponse;

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

  /// Payload to increase response size.
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

/// For reconnect interop test only.
/// Client tells server what reconnection parameters it used.
class ReconnectParams extends $pb.GeneratedMessage {
  factory ReconnectParams({
    $core.int? maxReconnectBackoffMs,
  }) {
    final result = create();
    if (maxReconnectBackoffMs != null) {
      result.maxReconnectBackoffMs = maxReconnectBackoffMs;
    }
    return result;
  }
  ReconnectParams._() : super();
  factory ReconnectParams.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectParams.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconnectParams',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'maxReconnectBackoffMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReconnectParams clone() => ReconnectParams()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReconnectParams copyWith(void Function(ReconnectParams) updates) =>
      super.copyWith((message) => updates(message as ReconnectParams))
          as ReconnectParams;

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

/// For reconnect interop test only.
/// Server tells client whether its reconnects are following the spec and the
/// reconnect backoffs it saw.
class ReconnectInfo extends $pb.GeneratedMessage {
  factory ReconnectInfo({
    $core.bool? passed,
    $core.Iterable<$core.int>? backoffMs,
  }) {
    final result = create();
    if (passed != null) {
      result.passed = passed;
    }
    if (backoffMs != null) {
      result.backoffMs.addAll(backoffMs);
    }
    return result;
  }
  ReconnectInfo._() : super();
  factory ReconnectInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReconnectInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconnectInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'passed')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'backoffMs', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReconnectInfo clone() => ReconnectInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReconnectInfo copyWith(void Function(ReconnectInfo) updates) =>
      super.copyWith((message) => updates(message as ReconnectInfo))
          as ReconnectInfo;

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

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
