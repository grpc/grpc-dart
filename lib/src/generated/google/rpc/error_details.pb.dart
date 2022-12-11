///
//  Generated code. Do not modify.
//  source: google/rpc/error_details.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/duration.pb.dart' as $1;

class RetryInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RetryInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOM<$1.Duration>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'retryDelay',
        subBuilder: $1.Duration.create)
    ..hasRequiredFields = false;

  RetryInfo._() : super();
  factory RetryInfo({
    $1.Duration? retryDelay,
  }) {
    final _result = create();
    if (retryDelay != null) {
      _result.retryDelay = retryDelay;
    }
    return _result;
  }
  factory RetryInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RetryInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RetryInfo clone() => RetryInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RetryInfo copyWith(void Function(RetryInfo) updates) =>
      super.copyWith((message) => updates(message as RetryInfo))
          as RetryInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RetryInfo create() => RetryInfo._();
  RetryInfo createEmptyInstance() => create();
  static $pb.PbList<RetryInfo> createRepeated() => $pb.PbList<RetryInfo>();
  @$core.pragma('dart2js:noInline')
  static RetryInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RetryInfo>(create);
  static RetryInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Duration get retryDelay => $_getN(0);
  @$pb.TagNumber(1)
  set retryDelay($1.Duration v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRetryDelay() => $_has(0);
  @$pb.TagNumber(1)
  void clearRetryDelay() => clearField(1);
  @$pb.TagNumber(1)
  $1.Duration ensureRetryDelay() => $_ensure(0);
}

class DebugInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'DebugInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..pPS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'stackEntries')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'detail')
    ..hasRequiredFields = false;

  DebugInfo._() : super();
  factory DebugInfo({
    $core.Iterable<$core.String>? stackEntries,
    $core.String? detail,
  }) {
    final _result = create();
    if (stackEntries != null) {
      _result.stackEntries.addAll(stackEntries);
    }
    if (detail != null) {
      _result.detail = detail;
    }
    return _result;
  }
  factory DebugInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DebugInfo clone() => DebugInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DebugInfo copyWith(void Function(DebugInfo) updates) =>
      super.copyWith((message) => updates(message as DebugInfo))
          as DebugInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DebugInfo create() => DebugInfo._();
  DebugInfo createEmptyInstance() => create();
  static $pb.PbList<DebugInfo> createRepeated() => $pb.PbList<DebugInfo>();
  @$core.pragma('dart2js:noInline')
  static DebugInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebugInfo>(create);
  static DebugInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get stackEntries => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get detail => $_getSZ(1);
  @$pb.TagNumber(2)
  set detail($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDetail() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetail() => clearField(2);
}

class QuotaFailure_Violation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'QuotaFailure.Violation',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'subject')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..hasRequiredFields = false;

  QuotaFailure_Violation._() : super();
  factory QuotaFailure_Violation({
    $core.String? subject,
    $core.String? description,
  }) {
    final _result = create();
    if (subject != null) {
      _result.subject = subject;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory QuotaFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaFailure_Violation clone() =>
      QuotaFailure_Violation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaFailure_Violation copyWith(
          void Function(QuotaFailure_Violation) updates) =>
      super.copyWith((message) => updates(message as QuotaFailure_Violation))
          as QuotaFailure_Violation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuotaFailure_Violation create() => QuotaFailure_Violation._();
  QuotaFailure_Violation createEmptyInstance() => create();
  static $pb.PbList<QuotaFailure_Violation> createRepeated() =>
      $pb.PbList<QuotaFailure_Violation>();
  @$core.pragma('dart2js:noInline')
  static QuotaFailure_Violation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaFailure_Violation>(create);
  static QuotaFailure_Violation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subject => $_getSZ(0);
  @$pb.TagNumber(1)
  set subject($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSubject() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubject() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class QuotaFailure extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'QuotaFailure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<QuotaFailure_Violation>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'violations',
        $pb.PbFieldType.PM,
        subBuilder: QuotaFailure_Violation.create)
    ..hasRequiredFields = false;

  QuotaFailure._() : super();
  factory QuotaFailure({
    $core.Iterable<QuotaFailure_Violation>? violations,
  }) {
    final _result = create();
    if (violations != null) {
      _result.violations.addAll(violations);
    }
    return _result;
  }
  factory QuotaFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaFailure clone() => QuotaFailure()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaFailure copyWith(void Function(QuotaFailure) updates) =>
      super.copyWith((message) => updates(message as QuotaFailure))
          as QuotaFailure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuotaFailure create() => QuotaFailure._();
  QuotaFailure createEmptyInstance() => create();
  static $pb.PbList<QuotaFailure> createRepeated() =>
      $pb.PbList<QuotaFailure>();
  @$core.pragma('dart2js:noInline')
  static QuotaFailure getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaFailure>(create);
  static QuotaFailure? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<QuotaFailure_Violation> get violations => $_getList(0);
}

class ErrorInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ErrorInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'reason')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'domain')
    ..m<$core.String, $core.String>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'metadata',
        entryClassName: 'ErrorInfo.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc'))
    ..hasRequiredFields = false;

  ErrorInfo._() : super();
  factory ErrorInfo({
    $core.String? reason,
    $core.String? domain,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final _result = create();
    if (reason != null) {
      _result.reason = reason;
    }
    if (domain != null) {
      _result.domain = domain;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    return _result;
  }
  factory ErrorInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ErrorInfo clone() => ErrorInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ErrorInfo copyWith(void Function(ErrorInfo) updates) =>
      super.copyWith((message) => updates(message as ErrorInfo))
          as ErrorInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorInfo create() => ErrorInfo._();
  ErrorInfo createEmptyInstance() => create();
  static $pb.PbList<ErrorInfo> createRepeated() => $pb.PbList<ErrorInfo>();
  @$core.pragma('dart2js:noInline')
  static ErrorInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorInfo>(create);
  static ErrorInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reason => $_getSZ(0);
  @$pb.TagNumber(1)
  set reason($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get domain => $_getSZ(1);
  @$pb.TagNumber(2)
  set domain($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDomain() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomain() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

class PreconditionFailure_Violation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'PreconditionFailure.Violation',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'subject')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..hasRequiredFields = false;

  PreconditionFailure_Violation._() : super();
  factory PreconditionFailure_Violation({
    $core.String? type,
    $core.String? subject,
    $core.String? description,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory PreconditionFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PreconditionFailure_Violation clone() =>
      PreconditionFailure_Violation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PreconditionFailure_Violation copyWith(
          void Function(PreconditionFailure_Violation) updates) =>
      super.copyWith(
              (message) => updates(message as PreconditionFailure_Violation))
          as PreconditionFailure_Violation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure_Violation create() =>
      PreconditionFailure_Violation._();
  PreconditionFailure_Violation createEmptyInstance() => create();
  static $pb.PbList<PreconditionFailure_Violation> createRepeated() =>
      $pb.PbList<PreconditionFailure_Violation>();
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure_Violation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreconditionFailure_Violation>(create);
  static PreconditionFailure_Violation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get subject => $_getSZ(1);
  @$pb.TagNumber(2)
  set subject($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class PreconditionFailure extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'PreconditionFailure',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<PreconditionFailure_Violation>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'violations',
        $pb.PbFieldType.PM,
        subBuilder: PreconditionFailure_Violation.create)
    ..hasRequiredFields = false;

  PreconditionFailure._() : super();
  factory PreconditionFailure({
    $core.Iterable<PreconditionFailure_Violation>? violations,
  }) {
    final _result = create();
    if (violations != null) {
      _result.violations.addAll(violations);
    }
    return _result;
  }
  factory PreconditionFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PreconditionFailure clone() => PreconditionFailure()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PreconditionFailure copyWith(void Function(PreconditionFailure) updates) =>
      super.copyWith((message) => updates(message as PreconditionFailure))
          as PreconditionFailure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure create() => PreconditionFailure._();
  PreconditionFailure createEmptyInstance() => create();
  static $pb.PbList<PreconditionFailure> createRepeated() =>
      $pb.PbList<PreconditionFailure>();
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreconditionFailure>(create);
  static PreconditionFailure? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PreconditionFailure_Violation> get violations => $_getList(0);
}

class BadRequest_FieldViolation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BadRequest.FieldViolation',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'field')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..hasRequiredFields = false;

  BadRequest_FieldViolation._() : super();
  factory BadRequest_FieldViolation({
    $core.String? field_1,
    $core.String? description,
  }) {
    final _result = create();
    if (field_1 != null) {
      _result.field_1 = field_1;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory BadRequest_FieldViolation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest_FieldViolation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BadRequest_FieldViolation clone() =>
      BadRequest_FieldViolation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BadRequest_FieldViolation copyWith(
          void Function(BadRequest_FieldViolation) updates) =>
      super.copyWith((message) => updates(message as BadRequest_FieldViolation))
          as BadRequest_FieldViolation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BadRequest_FieldViolation create() => BadRequest_FieldViolation._();
  BadRequest_FieldViolation createEmptyInstance() => create();
  static $pb.PbList<BadRequest_FieldViolation> createRepeated() =>
      $pb.PbList<BadRequest_FieldViolation>();
  @$core.pragma('dart2js:noInline')
  static BadRequest_FieldViolation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest_FieldViolation>(create);
  static BadRequest_FieldViolation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class BadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'BadRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<BadRequest_FieldViolation>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'fieldViolations',
        $pb.PbFieldType.PM,
        subBuilder: BadRequest_FieldViolation.create)
    ..hasRequiredFields = false;

  BadRequest._() : super();
  factory BadRequest({
    $core.Iterable<BadRequest_FieldViolation>? fieldViolations,
  }) {
    final _result = create();
    if (fieldViolations != null) {
      _result.fieldViolations.addAll(fieldViolations);
    }
    return _result;
  }
  factory BadRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BadRequest clone() => BadRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BadRequest copyWith(void Function(BadRequest) updates) =>
      super.copyWith((message) => updates(message as BadRequest))
          as BadRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BadRequest create() => BadRequest._();
  BadRequest createEmptyInstance() => create();
  static $pb.PbList<BadRequest> createRepeated() => $pb.PbList<BadRequest>();
  @$core.pragma('dart2js:noInline')
  static BadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest>(create);
  static BadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BadRequest_FieldViolation> get fieldViolations => $_getList(0);
}

class RequestInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RequestInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'requestId')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'servingData')
    ..hasRequiredFields = false;

  RequestInfo._() : super();
  factory RequestInfo({
    $core.String? requestId,
    $core.String? servingData,
  }) {
    final _result = create();
    if (requestId != null) {
      _result.requestId = requestId;
    }
    if (servingData != null) {
      _result.servingData = servingData;
    }
    return _result;
  }
  factory RequestInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RequestInfo clone() => RequestInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RequestInfo copyWith(void Function(RequestInfo) updates) =>
      super.copyWith((message) => updates(message as RequestInfo))
          as RequestInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInfo create() => RequestInfo._();
  RequestInfo createEmptyInstance() => create();
  static $pb.PbList<RequestInfo> createRepeated() => $pb.PbList<RequestInfo>();
  @$core.pragma('dart2js:noInline')
  static RequestInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInfo>(create);
  static RequestInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get servingData => $_getSZ(1);
  @$pb.TagNumber(2)
  set servingData($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasServingData() => $_has(1);
  @$pb.TagNumber(2)
  void clearServingData() => clearField(2);
}

class ResourceInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ResourceInfo',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceType')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'resourceName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'owner')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..hasRequiredFields = false;

  ResourceInfo._() : super();
  factory ResourceInfo({
    $core.String? resourceType,
    $core.String? resourceName,
    $core.String? owner,
    $core.String? description,
  }) {
    final _result = create();
    if (resourceType != null) {
      _result.resourceType = resourceType;
    }
    if (resourceName != null) {
      _result.resourceName = resourceName;
    }
    if (owner != null) {
      _result.owner = owner;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory ResourceInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResourceInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResourceInfo clone() => ResourceInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResourceInfo copyWith(void Function(ResourceInfo) updates) =>
      super.copyWith((message) => updates(message as ResourceInfo))
          as ResourceInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResourceInfo create() => ResourceInfo._();
  ResourceInfo createEmptyInstance() => create();
  static $pb.PbList<ResourceInfo> createRepeated() =>
      $pb.PbList<ResourceInfo>();
  @$core.pragma('dart2js:noInline')
  static ResourceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResourceInfo>(create);
  static ResourceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get resourceType => $_getSZ(0);
  @$pb.TagNumber(1)
  set resourceType($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResourceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResourceType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get resourceName => $_getSZ(1);
  @$pb.TagNumber(2)
  set resourceName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResourceName() => $_has(1);
  @$pb.TagNumber(2)
  void clearResourceName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get owner => $_getSZ(2);
  @$pb.TagNumber(3)
  set owner($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOwner() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwner() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);
}

class Help_Link extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Help.Link',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'url')
    ..hasRequiredFields = false;

  Help_Link._() : super();
  factory Help_Link({
    $core.String? description,
    $core.String? url,
  }) {
    final _result = create();
    if (description != null) {
      _result.description = description;
    }
    if (url != null) {
      _result.url = url;
    }
    return _result;
  }
  factory Help_Link.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help_Link.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Help_Link clone() => Help_Link()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Help_Link copyWith(void Function(Help_Link) updates) =>
      super.copyWith((message) => updates(message as Help_Link))
          as Help_Link; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Help_Link create() => Help_Link._();
  Help_Link createEmptyInstance() => create();
  static $pb.PbList<Help_Link> createRepeated() => $pb.PbList<Help_Link>();
  @$core.pragma('dart2js:noInline')
  static Help_Link getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help_Link>(create);
  static Help_Link? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);
}

class Help extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Help',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<Help_Link>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'links',
        $pb.PbFieldType.PM,
        subBuilder: Help_Link.create)
    ..hasRequiredFields = false;

  Help._() : super();
  factory Help({
    $core.Iterable<Help_Link>? links,
  }) {
    final _result = create();
    if (links != null) {
      _result.links.addAll(links);
    }
    return _result;
  }
  factory Help.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Help clone() => Help()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Help copyWith(void Function(Help) updates) =>
      super.copyWith((message) => updates(message as Help))
          as Help; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Help create() => Help._();
  Help createEmptyInstance() => create();
  static $pb.PbList<Help> createRepeated() => $pb.PbList<Help>();
  @$core.pragma('dart2js:noInline')
  static Help getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help>(create);
  static Help? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Help_Link> get links => $_getList(0);
}

class LocalizedMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'LocalizedMessage',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'locale')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  LocalizedMessage._() : super();
  factory LocalizedMessage({
    $core.String? locale,
    $core.String? message,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory LocalizedMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LocalizedMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LocalizedMessage clone() => LocalizedMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LocalizedMessage copyWith(void Function(LocalizedMessage) updates) =>
      super.copyWith((message) => updates(message as LocalizedMessage))
          as LocalizedMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LocalizedMessage create() => LocalizedMessage._();
  LocalizedMessage createEmptyInstance() => create();
  static $pb.PbList<LocalizedMessage> createRepeated() =>
      $pb.PbList<LocalizedMessage>();
  @$core.pragma('dart2js:noInline')
  static LocalizedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocalizedMessage>(create);
  static LocalizedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);

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
