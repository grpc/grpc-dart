// This is a generated file - do not edit.
//
// Generated from messages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'messages.pbenum.dart';

/// TODO(dgq): Go back to using well-known types once
/// https://github.com/grpc/grpc/issues/6980 has been fixed.
/// import "google/protobuf/wrappers.proto";
class BoolValue extends $pb.GeneratedMessage {
  factory BoolValue({
    $core.bool? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  BoolValue._();

  factory BoolValue.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BoolValue.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BoolValue',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BoolValue clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BoolValue copyWith(void Function(BoolValue) updates) =>
      super.copyWith((message) => updates(message as BoolValue)) as BoolValue;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BoolValue create() => BoolValue._();
  @$core.override
  BoolValue createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BoolValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BoolValue>(create);
  static BoolValue? _defaultInstance;

  /// The bool value.
  @$pb.TagNumber(1)
  $core.bool get value => $_getBF(0);
  @$pb.TagNumber(1)
  set value($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

/// A block of data, to simply increase gRPC message size.
class Payload extends $pb.GeneratedMessage {
  factory Payload({
    PayloadType? type,
    $core.List<$core.int>? body,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (body != null) result.body = body;
    return result;
  }

  Payload._();

  factory Payload.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Payload.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Payload',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aE<PayloadType>(1, _omitFieldNames ? '' : 'type',
        enumValues: PayloadType.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Payload clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Payload copyWith(void Function(Payload) updates) =>
      super.copyWith((message) => updates(message as Payload)) as Payload;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Payload create() => Payload._();
  @$core.override
  Payload createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Payload getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payload>(create);
  static Payload? _defaultInstance;

  /// DEPRECATED, don't use. To be removed shortly.
  /// The type of data in body.
  @$pb.TagNumber(1)
  PayloadType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(PayloadType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// Primary contents of payload.
  @$pb.TagNumber(2)
  $core.List<$core.int> get body => $_getN(1);
  @$pb.TagNumber(2)
  set body($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => $_clearField(2);
}

/// A protobuf representation for grpc status. This is used by test
/// clients to specify a status that the server should attempt to return.
class EchoStatus extends $pb.GeneratedMessage {
  factory EchoStatus({
    $core.int? code,
    $core.String? message,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    return result;
  }

  EchoStatus._();

  factory EchoStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EchoStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoStatus copyWith(void Function(EchoStatus) updates) =>
      super.copyWith((message) => updates(message as EchoStatus)) as EchoStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoStatus create() => EchoStatus._();
  @$core.override
  EchoStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EchoStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoStatus>(create);
  static EchoStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
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
    if (responseType != null) result.responseType = responseType;
    if (responseSize != null) result.responseSize = responseSize;
    if (payload != null) result.payload = payload;
    if (fillUsername != null) result.fillUsername = fillUsername;
    if (fillOauthScope != null) result.fillOauthScope = fillOauthScope;
    if (responseCompressed != null)
      result.responseCompressed = responseCompressed;
    if (responseStatus != null) result.responseStatus = responseStatus;
    if (expectCompressed != null) result.expectCompressed = expectCompressed;
    return result;
  }

  SimpleRequest._();

  factory SimpleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aE<PayloadType>(1, _omitFieldNames ? '' : 'responseType',
        enumValues: PayloadType.values)
    ..aI(2, _omitFieldNames ? '' : 'responseSize')
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

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleRequest copyWith(void Function(SimpleRequest) updates) =>
      super.copyWith((message) => updates(message as SimpleRequest))
          as SimpleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleRequest create() => SimpleRequest._();
  @$core.override
  SimpleRequest createEmptyInstance() => create();
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
  set responseType(PayloadType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseType() => $_clearField(1);

  /// Desired payload size in the response from the server.
  @$pb.TagNumber(2)
  $core.int get responseSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set responseSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResponseSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponseSize() => $_clearField(2);

  /// Optional input payload sent along with the request.
  @$pb.TagNumber(3)
  Payload get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload(Payload value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField(3);
  @$pb.TagNumber(3)
  Payload ensurePayload() => $_ensure(2);

  /// Whether SimpleResponse should include username.
  @$pb.TagNumber(4)
  $core.bool get fillUsername => $_getBF(3);
  @$pb.TagNumber(4)
  set fillUsername($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFillUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearFillUsername() => $_clearField(4);

  /// Whether SimpleResponse should include OAuth scope.
  @$pb.TagNumber(5)
  $core.bool get fillOauthScope => $_getBF(4);
  @$pb.TagNumber(5)
  set fillOauthScope($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFillOauthScope() => $_has(4);
  @$pb.TagNumber(5)
  void clearFillOauthScope() => $_clearField(5);

  /// Whether to request the server to compress the response. This field is
  /// "nullable" in order to interoperate seamlessly with clients not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the response's compression status.
  @$pb.TagNumber(6)
  BoolValue get responseCompressed => $_getN(5);
  @$pb.TagNumber(6)
  set responseCompressed(BoolValue value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasResponseCompressed() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponseCompressed() => $_clearField(6);
  @$pb.TagNumber(6)
  BoolValue ensureResponseCompressed() => $_ensure(5);

  /// Whether server should return a given status
  @$pb.TagNumber(7)
  EchoStatus get responseStatus => $_getN(6);
  @$pb.TagNumber(7)
  set responseStatus(EchoStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasResponseStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearResponseStatus() => $_clearField(7);
  @$pb.TagNumber(7)
  EchoStatus ensureResponseStatus() => $_ensure(6);

  /// Whether the server should expect this request to be compressed.
  @$pb.TagNumber(8)
  BoolValue get expectCompressed => $_getN(7);
  @$pb.TagNumber(8)
  set expectCompressed(BoolValue value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasExpectCompressed() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpectCompressed() => $_clearField(8);
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
    if (payload != null) result.payload = payload;
    if (username != null) result.username = username;
    if (oauthScope != null) result.oauthScope = oauthScope;
    return result;
  }

  SimpleResponse._();

  factory SimpleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'oauthScope')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleResponse copyWith(void Function(SimpleResponse) updates) =>
      super.copyWith((message) => updates(message as SimpleResponse))
          as SimpleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleResponse create() => SimpleResponse._();
  @$core.override
  SimpleResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SimpleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleResponse>(create);
  static SimpleResponse? _defaultInstance;

  /// Payload to increase message size.
  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);
  @$pb.TagNumber(1)
  Payload ensurePayload() => $_ensure(0);

  /// The user the request came from, for verifying authentication was
  /// successful when the client expected it.
  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  /// OAuth scope.
  @$pb.TagNumber(3)
  $core.String get oauthScope => $_getSZ(2);
  @$pb.TagNumber(3)
  set oauthScope($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOauthScope() => $_has(2);
  @$pb.TagNumber(3)
  void clearOauthScope() => $_clearField(3);
}

/// Client-streaming request.
class StreamingInputCallRequest extends $pb.GeneratedMessage {
  factory StreamingInputCallRequest({
    Payload? payload,
    BoolValue? expectCompressed,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (expectCompressed != null) result.expectCompressed = expectCompressed;
    return result;
  }

  StreamingInputCallRequest._();

  factory StreamingInputCallRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingInputCallRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingInputCallRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOM<BoolValue>(2, _omitFieldNames ? '' : 'expectCompressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingInputCallRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingInputCallRequest copyWith(
          void Function(StreamingInputCallRequest) updates) =>
      super.copyWith((message) => updates(message as StreamingInputCallRequest))
          as StreamingInputCallRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingInputCallRequest create() => StreamingInputCallRequest._();
  @$core.override
  StreamingInputCallRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingInputCallRequest>(create);
  static StreamingInputCallRequest? _defaultInstance;

  /// Optional input payload sent along with the request.
  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);
  @$pb.TagNumber(1)
  Payload ensurePayload() => $_ensure(0);

  /// Whether the server should expect this request to be compressed. This field
  /// is "nullable" in order to interoperate seamlessly with servers not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the request's compression status.
  @$pb.TagNumber(2)
  BoolValue get expectCompressed => $_getN(1);
  @$pb.TagNumber(2)
  set expectCompressed(BoolValue value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasExpectCompressed() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpectCompressed() => $_clearField(2);
  @$pb.TagNumber(2)
  BoolValue ensureExpectCompressed() => $_ensure(1);
}

/// Client-streaming response.
class StreamingInputCallResponse extends $pb.GeneratedMessage {
  factory StreamingInputCallResponse({
    $core.int? aggregatedPayloadSize,
  }) {
    final result = create();
    if (aggregatedPayloadSize != null)
      result.aggregatedPayloadSize = aggregatedPayloadSize;
    return result;
  }

  StreamingInputCallResponse._();

  factory StreamingInputCallResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingInputCallResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingInputCallResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'aggregatedPayloadSize')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingInputCallResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingInputCallResponse copyWith(
          void Function(StreamingInputCallResponse) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingInputCallResponse))
          as StreamingInputCallResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingInputCallResponse create() => StreamingInputCallResponse._();
  @$core.override
  StreamingInputCallResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingInputCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingInputCallResponse>(create);
  static StreamingInputCallResponse? _defaultInstance;

  /// Aggregated size of payloads received from the client.
  @$pb.TagNumber(1)
  $core.int get aggregatedPayloadSize => $_getIZ(0);
  @$pb.TagNumber(1)
  set aggregatedPayloadSize($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAggregatedPayloadSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearAggregatedPayloadSize() => $_clearField(1);
}

/// Configuration for a particular response.
class ResponseParameters extends $pb.GeneratedMessage {
  factory ResponseParameters({
    $core.int? size,
    $core.int? intervalUs,
    BoolValue? compressed,
  }) {
    final result = create();
    if (size != null) result.size = size;
    if (intervalUs != null) result.intervalUs = intervalUs;
    if (compressed != null) result.compressed = compressed;
    return result;
  }

  ResponseParameters._();

  factory ResponseParameters.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResponseParameters.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResponseParameters',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'size')
    ..aI(2, _omitFieldNames ? '' : 'intervalUs')
    ..aOM<BoolValue>(3, _omitFieldNames ? '' : 'compressed',
        subBuilder: BoolValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseParameters clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResponseParameters copyWith(void Function(ResponseParameters) updates) =>
      super.copyWith((message) => updates(message as ResponseParameters))
          as ResponseParameters;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseParameters create() => ResponseParameters._();
  @$core.override
  ResponseParameters createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResponseParameters getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResponseParameters>(create);
  static ResponseParameters? _defaultInstance;

  /// Desired payload sizes in responses from the server.
  @$pb.TagNumber(1)
  $core.int get size => $_getIZ(0);
  @$pb.TagNumber(1)
  set size($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => $_clearField(1);

  /// Desired interval between consecutive responses in the response stream in
  /// microseconds.
  @$pb.TagNumber(2)
  $core.int get intervalUs => $_getIZ(1);
  @$pb.TagNumber(2)
  set intervalUs($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIntervalUs() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntervalUs() => $_clearField(2);

  /// Whether to request the server to compress the response. This field is
  /// "nullable" in order to interoperate seamlessly with clients not able to
  /// implement the full compression tests by introspecting the call to verify
  /// the response's compression status.
  @$pb.TagNumber(3)
  BoolValue get compressed => $_getN(2);
  @$pb.TagNumber(3)
  set compressed(BoolValue value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCompressed() => $_has(2);
  @$pb.TagNumber(3)
  void clearCompressed() => $_clearField(3);
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
    if (responseType != null) result.responseType = responseType;
    if (responseParameters != null)
      result.responseParameters.addAll(responseParameters);
    if (payload != null) result.payload = payload;
    if (responseStatus != null) result.responseStatus = responseStatus;
    return result;
  }

  StreamingOutputCallRequest._();

  factory StreamingOutputCallRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingOutputCallRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingOutputCallRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aE<PayloadType>(1, _omitFieldNames ? '' : 'responseType',
        enumValues: PayloadType.values)
    ..pPM<ResponseParameters>(2, _omitFieldNames ? '' : 'responseParameters',
        subBuilder: ResponseParameters.create)
    ..aOM<Payload>(3, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..aOM<EchoStatus>(7, _omitFieldNames ? '' : 'responseStatus',
        subBuilder: EchoStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingOutputCallRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingOutputCallRequest copyWith(
          void Function(StreamingOutputCallRequest) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingOutputCallRequest))
          as StreamingOutputCallRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallRequest create() => StreamingOutputCallRequest._();
  @$core.override
  StreamingOutputCallRequest createEmptyInstance() => create();
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
  set responseType(PayloadType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResponseType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseType() => $_clearField(1);

  /// Configuration for each expected response message.
  @$pb.TagNumber(2)
  $pb.PbList<ResponseParameters> get responseParameters => $_getList(1);

  /// Optional input payload sent along with the request.
  @$pb.TagNumber(3)
  Payload get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload(Payload value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField(3);
  @$pb.TagNumber(3)
  Payload ensurePayload() => $_ensure(2);

  /// Whether server should return a given status.
  @$pb.TagNumber(7)
  EchoStatus get responseStatus => $_getN(3);
  @$pb.TagNumber(7)
  set responseStatus(EchoStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasResponseStatus() => $_has(3);
  @$pb.TagNumber(7)
  void clearResponseStatus() => $_clearField(7);
  @$pb.TagNumber(7)
  EchoStatus ensureResponseStatus() => $_ensure(3);
}

/// Server-streaming response, as configured by the request and parameters.
class StreamingOutputCallResponse extends $pb.GeneratedMessage {
  factory StreamingOutputCallResponse({
    Payload? payload,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    return result;
  }

  StreamingOutputCallResponse._();

  factory StreamingOutputCallResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StreamingOutputCallResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamingOutputCallResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOM<Payload>(1, _omitFieldNames ? '' : 'payload',
        subBuilder: Payload.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingOutputCallResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamingOutputCallResponse copyWith(
          void Function(StreamingOutputCallResponse) updates) =>
      super.copyWith(
              (message) => updates(message as StreamingOutputCallResponse))
          as StreamingOutputCallResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallResponse create() =>
      StreamingOutputCallResponse._();
  @$core.override
  StreamingOutputCallResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StreamingOutputCallResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamingOutputCallResponse>(create);
  static StreamingOutputCallResponse? _defaultInstance;

  /// Payload to increase response size.
  @$pb.TagNumber(1)
  Payload get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload(Payload value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);
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
    if (maxReconnectBackoffMs != null)
      result.maxReconnectBackoffMs = maxReconnectBackoffMs;
    return result;
  }

  ReconnectParams._();

  factory ReconnectParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReconnectParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconnectParams',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'maxReconnectBackoffMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconnectParams clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconnectParams copyWith(void Function(ReconnectParams) updates) =>
      super.copyWith((message) => updates(message as ReconnectParams))
          as ReconnectParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconnectParams create() => ReconnectParams._();
  @$core.override
  ReconnectParams createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReconnectParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconnectParams>(create);
  static ReconnectParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get maxReconnectBackoffMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set maxReconnectBackoffMs($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMaxReconnectBackoffMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxReconnectBackoffMs() => $_clearField(1);
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
    if (passed != null) result.passed = passed;
    if (backoffMs != null) result.backoffMs.addAll(backoffMs);
    return result;
  }

  ReconnectInfo._();

  factory ReconnectInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReconnectInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReconnectInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.testing'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'passed')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'backoffMs', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconnectInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconnectInfo copyWith(void Function(ReconnectInfo) updates) =>
      super.copyWith((message) => updates(message as ReconnectInfo))
          as ReconnectInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconnectInfo create() => ReconnectInfo._();
  @$core.override
  ReconnectInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReconnectInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReconnectInfo>(create);
  static ReconnectInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get passed => $_getBF(0);
  @$pb.TagNumber(1)
  set passed($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPassed() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassed() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get backoffMs => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
