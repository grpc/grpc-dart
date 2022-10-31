///
//  Generated code. Do not modify.
//  source: echo.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EchoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'EchoRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.gateway.testing'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  EchoRequest._() : super();
  factory EchoRequest({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory EchoRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EchoRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EchoRequest clone() => EchoRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EchoRequest copyWith(void Function(EchoRequest) updates) =>
      super.copyWith((message) => updates(message as EchoRequest))
          as EchoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EchoRequest create() => EchoRequest._();
  EchoRequest createEmptyInstance() => create();
  static $pb.PbList<EchoRequest> createRepeated() => $pb.PbList<EchoRequest>();
  @$core.pragma('dart2js:noInline')
  static EchoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoRequest>(create);
  static EchoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class EchoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'EchoResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.gateway.testing'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  EchoResponse._() : super();
  factory EchoResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory EchoResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EchoResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EchoResponse clone() => EchoResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EchoResponse copyWith(void Function(EchoResponse) updates) =>
      super.copyWith((message) => updates(message as EchoResponse))
          as EchoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EchoResponse create() => EchoResponse._();
  EchoResponse createEmptyInstance() => create();
  static $pb.PbList<EchoResponse> createRepeated() =>
      $pb.PbList<EchoResponse>();
  @$core.pragma('dart2js:noInline')
  static EchoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoResponse>(create);
  static EchoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class ServerStreamingEchoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ServerStreamingEchoRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.gateway.testing'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'messageCount',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'messageInterval',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  ServerStreamingEchoRequest._() : super();
  factory ServerStreamingEchoRequest({
    $core.String? message,
    $core.int? messageCount,
    $core.int? messageInterval,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (messageCount != null) {
      _result.messageCount = messageCount;
    }
    if (messageInterval != null) {
      _result.messageInterval = messageInterval;
    }
    return _result;
  }
  factory ServerStreamingEchoRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServerStreamingEchoRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServerStreamingEchoRequest clone() =>
      ServerStreamingEchoRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServerStreamingEchoRequest copyWith(
          void Function(ServerStreamingEchoRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ServerStreamingEchoRequest))
          as ServerStreamingEchoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ServerStreamingEchoRequest create() => ServerStreamingEchoRequest._();
  ServerStreamingEchoRequest createEmptyInstance() => create();
  static $pb.PbList<ServerStreamingEchoRequest> createRepeated() =>
      $pb.PbList<ServerStreamingEchoRequest>();
  @$core.pragma('dart2js:noInline')
  static ServerStreamingEchoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerStreamingEchoRequest>(create);
  static ServerStreamingEchoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get messageCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set messageCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessageCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get messageInterval => $_getIZ(2);
  @$pb.TagNumber(3)
  set messageInterval($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMessageInterval() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessageInterval() => clearField(3);
}

class ServerStreamingEchoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ServerStreamingEchoResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'grpc.gateway.testing'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  ServerStreamingEchoResponse._() : super();
  factory ServerStreamingEchoResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ServerStreamingEchoResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServerStreamingEchoResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServerStreamingEchoResponse clone() =>
      ServerStreamingEchoResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServerStreamingEchoResponse copyWith(
          void Function(ServerStreamingEchoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ServerStreamingEchoResponse))
          as ServerStreamingEchoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ServerStreamingEchoResponse create() =>
      ServerStreamingEchoResponse._();
  ServerStreamingEchoResponse createEmptyInstance() => create();
  static $pb.PbList<ServerStreamingEchoResponse> createRepeated() =>
      $pb.PbList<ServerStreamingEchoResponse>();
  @$core.pragma('dart2js:noInline')
  static ServerStreamingEchoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerStreamingEchoResponse>(create);
  static ServerStreamingEchoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}
