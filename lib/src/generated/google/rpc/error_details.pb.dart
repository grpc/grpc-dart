//
//  Generated code. Do not modify.
//  source: google/rpc/error_details.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/duration.pb.dart' as $1;

///  Describes when the clients can retry a failed request. Clients could ignore
///  the recommendation here or retry when this information is missing from error
///  responses.
///
///  It's always recommended that clients should use exponential backoff when
///  retrying.
///
///  Clients should wait until `retry_delay` amount of time has passed since
///  receiving the error response before retrying.  If retrying requests also
///  fail, clients should use an exponential backoff scheme to gradually increase
///  the delay between retries based on `retry_delay`, until either a maximum
///  number of retries have been reached or a maximum retry delay cap has been
///  reached.
class RetryInfo extends $pb.GeneratedMessage {
  factory RetryInfo({
    $1.Duration? retryDelay,
  }) {
    final result = create();
    if (retryDelay != null) {
      result.retryDelay = retryDelay;
    }
    return result;
  }
  RetryInfo._() : super();
  factory RetryInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RetryInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetryInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOM<$1.Duration>(1, _omitFieldNames ? '' : 'retryDelay',
        subBuilder: $1.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RetryInfo clone() => RetryInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RetryInfo copyWith(void Function(RetryInfo) updates) =>
      super.copyWith((message) => updates(message as RetryInfo)) as RetryInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetryInfo create() => RetryInfo._();
  RetryInfo createEmptyInstance() => create();
  static $pb.PbList<RetryInfo> createRepeated() => $pb.PbList<RetryInfo>();
  @$core.pragma('dart2js:noInline')
  static RetryInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RetryInfo>(create);
  static RetryInfo? _defaultInstance;

  /// Clients should wait at least this long between retrying the same request.
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

/// Describes additional debugging info.
class DebugInfo extends $pb.GeneratedMessage {
  factory DebugInfo({
    $core.Iterable<$core.String>? stackEntries,
    $core.String? detail,
  }) {
    final result = create();
    if (stackEntries != null) {
      result.stackEntries.addAll(stackEntries);
    }
    if (detail != null) {
      result.detail = detail;
    }
    return result;
  }
  DebugInfo._() : super();
  factory DebugInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebugInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'stackEntries')
    ..aOS(2, _omitFieldNames ? '' : 'detail')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DebugInfo clone() => DebugInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DebugInfo copyWith(void Function(DebugInfo) updates) =>
      super.copyWith((message) => updates(message as DebugInfo)) as DebugInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugInfo create() => DebugInfo._();
  DebugInfo createEmptyInstance() => create();
  static $pb.PbList<DebugInfo> createRepeated() => $pb.PbList<DebugInfo>();
  @$core.pragma('dart2js:noInline')
  static DebugInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebugInfo>(create);
  static DebugInfo? _defaultInstance;

  /// The stack trace entries indicating where the error occurred.
  @$pb.TagNumber(1)
  $core.List<$core.String> get stackEntries => $_getList(0);

  /// Additional debugging information provided by the server.
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

/// A message type used to describe a single quota violation.  For example, a
/// daily quota or a custom quota that was exceeded.
class QuotaFailure_Violation extends $pb.GeneratedMessage {
  factory QuotaFailure_Violation({
    $core.String? subject,
    $core.String? description,
  }) {
    final result = create();
    if (subject != null) {
      result.subject = subject;
    }
    if (description != null) {
      result.description = description;
    }
    return result;
  }
  QuotaFailure_Violation._() : super();
  factory QuotaFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaFailure.Violation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subject')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

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
          as QuotaFailure_Violation;

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

  /// The subject on which the quota check failed.
  /// For example, "clientip:<ip address of client>" or "project:<Google
  /// developer project id>".
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

  ///  A description of how the quota check failed. Clients can use this
  ///  description to find more about the quota configuration in the service's
  ///  public documentation, or find the relevant quota limit to adjust through
  ///  developer console.
  ///
  ///  For example: "Service disabled" or "Daily Limit for read operations
  ///  exceeded".
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

///  Describes how a quota check failed.
///
///  For example if a daily limit was exceeded for the calling project,
///  a service could respond with a QuotaFailure detail containing the project
///  id and the description of the quota limit that was exceeded.  If the
///  calling project hasn't enabled the service in the developer console, then
///  a service could respond with the project id and set `service_disabled`
///  to true.
///
///  Also see RetryInfo and Help types for other details about handling a
///  quota failure.
class QuotaFailure extends $pb.GeneratedMessage {
  factory QuotaFailure({
    $core.Iterable<QuotaFailure_Violation>? violations,
  }) {
    final result = create();
    if (violations != null) {
      result.violations.addAll(violations);
    }
    return result;
  }
  QuotaFailure._() : super();
  factory QuotaFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaFailure',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<QuotaFailure_Violation>(
        1, _omitFieldNames ? '' : 'violations', $pb.PbFieldType.PM,
        subBuilder: QuotaFailure_Violation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaFailure clone() => QuotaFailure()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaFailure copyWith(void Function(QuotaFailure) updates) =>
      super.copyWith((message) => updates(message as QuotaFailure))
          as QuotaFailure;

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

  /// Describes all quota violations.
  @$pb.TagNumber(1)
  $core.List<QuotaFailure_Violation> get violations => $_getList(0);
}

///  Describes the cause of the error with structured details.
///
///  Example of an error when contacting the "pubsub.googleapis.com" API when it
///  is not enabled:
///
///      { "reason": "API_DISABLED"
///        "domain": "googleapis.com"
///        "metadata": {
///          "resource": "projects/123",
///          "service": "pubsub.googleapis.com"
///        }
///      }
///
///  This response indicates that the pubsub.googleapis.com API is not enabled.
///
///  Example of an error that is returned when attempting to create a Spanner
///  instance in a region that is out of stock:
///
///      { "reason": "STOCKOUT"
///        "domain": "spanner.googleapis.com",
///        "metadata": {
///          "availableRegions": "us-central1,us-east2"
///        }
///      }
class ErrorInfo extends $pb.GeneratedMessage {
  factory ErrorInfo({
    $core.String? reason,
    $core.String? domain,
    $core.Map<$core.String, $core.String>? metadata,
  }) {
    final result = create();
    if (reason != null) {
      result.reason = reason;
    }
    if (domain != null) {
      result.domain = domain;
    }
    if (metadata != null) {
      result.metadata.addAll(metadata);
    }
    return result;
  }
  ErrorInfo._() : super();
  factory ErrorInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reason')
    ..aOS(2, _omitFieldNames ? '' : 'domain')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ErrorInfo.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ErrorInfo clone() => ErrorInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ErrorInfo copyWith(void Function(ErrorInfo) updates) =>
      super.copyWith((message) => updates(message as ErrorInfo)) as ErrorInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorInfo create() => ErrorInfo._();
  ErrorInfo createEmptyInstance() => create();
  static $pb.PbList<ErrorInfo> createRepeated() => $pb.PbList<ErrorInfo>();
  @$core.pragma('dart2js:noInline')
  static ErrorInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorInfo>(create);
  static ErrorInfo? _defaultInstance;

  /// The reason of the error. This is a constant value that identifies the
  /// proximate cause of the error. Error reasons are unique within a particular
  /// domain of errors. This should be at most 63 characters and match
  /// /[A-Z0-9_]+/.
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

  /// The logical grouping to which the "reason" belongs. The error domain
  /// is typically the registered service name of the tool or product that
  /// generates the error. Example: "pubsub.googleapis.com". If the error is
  /// generated by some common infrastructure, the error domain must be a
  /// globally unique value that identifies the infrastructure. For Google API
  /// infrastructure, the error domain is "googleapis.com".
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

  ///  Additional structured details about this error.
  ///
  ///  Keys should match /[a-zA-Z0-9-_]/ and be limited to 64 characters in
  ///  length. When identifying the current value of an exceeded limit, the units
  ///  should be contained in the key, not the value.  For example, rather than
  ///  {"instanceLimit": "100/request"}, should be returned as,
  ///  {"instanceLimitPerRequest": "100"}, if the client exceeds the number of
  ///  instances that can be created in a single (batch) request.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(2);
}

/// A message type used to describe a single precondition failure.
class PreconditionFailure_Violation extends $pb.GeneratedMessage {
  factory PreconditionFailure_Violation({
    $core.String? type,
    $core.String? subject,
    $core.String? description,
  }) {
    final result = create();
    if (type != null) {
      result.type = type;
    }
    if (subject != null) {
      result.subject = subject;
    }
    if (description != null) {
      result.description = description;
    }
    return result;
  }
  PreconditionFailure_Violation._() : super();
  factory PreconditionFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreconditionFailure.Violation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'subject')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

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
          as PreconditionFailure_Violation;

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

  /// The type of PreconditionFailure. We recommend using a service-specific
  /// enum type to define the supported precondition violation subjects. For
  /// example, "TOS" for "Terms of Service violation".
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

  /// The subject, relative to the type, that failed.
  /// For example, "google.com/cloud" relative to the "TOS" type would indicate
  /// which terms of service is being referenced.
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

  ///  A description of how the precondition failed. Developers can use this
  ///  description to understand how to fix the failure.
  ///
  ///  For example: "Terms of service not accepted".
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

///  Describes what preconditions have failed.
///
///  For example, if an RPC failed because it required the Terms of Service to be
///  acknowledged, it could list the terms of service violation in the
///  PreconditionFailure message.
class PreconditionFailure extends $pb.GeneratedMessage {
  factory PreconditionFailure({
    $core.Iterable<PreconditionFailure_Violation>? violations,
  }) {
    final result = create();
    if (violations != null) {
      result.violations.addAll(violations);
    }
    return result;
  }
  PreconditionFailure._() : super();
  factory PreconditionFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreconditionFailure',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<PreconditionFailure_Violation>(
        1, _omitFieldNames ? '' : 'violations', $pb.PbFieldType.PM,
        subBuilder: PreconditionFailure_Violation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PreconditionFailure clone() => PreconditionFailure()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PreconditionFailure copyWith(void Function(PreconditionFailure) updates) =>
      super.copyWith((message) => updates(message as PreconditionFailure))
          as PreconditionFailure;

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

  /// Describes all precondition violations.
  @$pb.TagNumber(1)
  $core.List<PreconditionFailure_Violation> get violations => $_getList(0);
}

/// A message type used to describe a single bad request field.
class BadRequest_FieldViolation extends $pb.GeneratedMessage {
  factory BadRequest_FieldViolation({
    $core.String? field_1,
    $core.String? description,
  }) {
    final result = create();
    if (field_1 != null) {
      result.field_1 = field_1;
    }
    if (description != null) {
      result.description = description;
    }
    return result;
  }
  BadRequest_FieldViolation._() : super();
  factory BadRequest_FieldViolation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest_FieldViolation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BadRequest.FieldViolation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

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
          as BadRequest_FieldViolation;

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

  /// A path leading to a field in the request body. The value will be a
  /// sequence of dot-separated identifiers that identify a protocol buffer
  /// field. E.g., "field_violations.field" would identify this field.
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

  /// A description of why the request element is bad.
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

/// Describes violations in a client request. This error type focuses on the
/// syntactic aspects of the request.
class BadRequest extends $pb.GeneratedMessage {
  factory BadRequest({
    $core.Iterable<BadRequest_FieldViolation>? fieldViolations,
  }) {
    final result = create();
    if (fieldViolations != null) {
      result.fieldViolations.addAll(fieldViolations);
    }
    return result;
  }
  BadRequest._() : super();
  factory BadRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<BadRequest_FieldViolation>(
        1, _omitFieldNames ? '' : 'fieldViolations', $pb.PbFieldType.PM,
        subBuilder: BadRequest_FieldViolation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BadRequest clone() => BadRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BadRequest copyWith(void Function(BadRequest) updates) =>
      super.copyWith((message) => updates(message as BadRequest)) as BadRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BadRequest create() => BadRequest._();
  BadRequest createEmptyInstance() => create();
  static $pb.PbList<BadRequest> createRepeated() => $pb.PbList<BadRequest>();
  @$core.pragma('dart2js:noInline')
  static BadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest>(create);
  static BadRequest? _defaultInstance;

  /// Describes all violations in a client request.
  @$pb.TagNumber(1)
  $core.List<BadRequest_FieldViolation> get fieldViolations => $_getList(0);
}

/// Contains metadata about the request that clients can attach when filing a bug
/// or providing other forms of feedback.
class RequestInfo extends $pb.GeneratedMessage {
  factory RequestInfo({
    $core.String? requestId,
    $core.String? servingData,
  }) {
    final result = create();
    if (requestId != null) {
      result.requestId = requestId;
    }
    if (servingData != null) {
      result.servingData = servingData;
    }
    return result;
  }
  RequestInfo._() : super();
  factory RequestInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..aOS(2, _omitFieldNames ? '' : 'servingData')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RequestInfo clone() => RequestInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RequestInfo copyWith(void Function(RequestInfo) updates) =>
      super.copyWith((message) => updates(message as RequestInfo))
          as RequestInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInfo create() => RequestInfo._();
  RequestInfo createEmptyInstance() => create();
  static $pb.PbList<RequestInfo> createRepeated() => $pb.PbList<RequestInfo>();
  @$core.pragma('dart2js:noInline')
  static RequestInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInfo>(create);
  static RequestInfo? _defaultInstance;

  /// An opaque string that should only be interpreted by the service generating
  /// it. For example, it can be used to identify requests in the service's logs.
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

  /// Any data that was used to serve this request. For example, an encrypted
  /// stack trace that can be sent back to the service provider for debugging.
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

/// Describes the resource that is being accessed.
class ResourceInfo extends $pb.GeneratedMessage {
  factory ResourceInfo({
    $core.String? resourceType,
    $core.String? resourceName,
    $core.String? owner,
    $core.String? description,
  }) {
    final result = create();
    if (resourceType != null) {
      result.resourceType = resourceType;
    }
    if (resourceName != null) {
      result.resourceName = resourceName;
    }
    if (owner != null) {
      result.owner = owner;
    }
    if (description != null) {
      result.description = description;
    }
    return result;
  }
  ResourceInfo._() : super();
  factory ResourceInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResourceInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResourceInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resourceType')
    ..aOS(2, _omitFieldNames ? '' : 'resourceName')
    ..aOS(3, _omitFieldNames ? '' : 'owner')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResourceInfo clone() => ResourceInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResourceInfo copyWith(void Function(ResourceInfo) updates) =>
      super.copyWith((message) => updates(message as ResourceInfo))
          as ResourceInfo;

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

  /// A name for the type of resource being accessed, e.g. "sql table",
  /// "cloud storage bucket", "file", "Google calendar"; or the type URL
  /// of the resource: e.g. "type.googleapis.com/google.pubsub.v1.Topic".
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

  /// The name of the resource being accessed.  For example, a shared calendar
  /// name: "example.com_4fghdhgsrgh@group.calendar.google.com", if the current
  /// error is [google.rpc.Code.PERMISSION_DENIED][google.rpc.Code.PERMISSION_DENIED].
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

  /// The owner of the resource (optional).
  /// For example, "user:<owner email>" or "project:<Google developer project
  /// id>".
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

  /// Describes what error is encountered when accessing this resource.
  /// For example, updating a cloud project may require the `writer` permission
  /// on the developer console project.
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

/// Describes a URL link.
class Help_Link extends $pb.GeneratedMessage {
  factory Help_Link({
    $core.String? description,
    $core.String? url,
  }) {
    final result = create();
    if (description != null) {
      result.description = description;
    }
    if (url != null) {
      result.url = url;
    }
    return result;
  }
  Help_Link._() : super();
  factory Help_Link.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help_Link.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Help.Link',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Help_Link clone() => Help_Link()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Help_Link copyWith(void Function(Help_Link) updates) =>
      super.copyWith((message) => updates(message as Help_Link)) as Help_Link;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Help_Link create() => Help_Link._();
  Help_Link createEmptyInstance() => create();
  static $pb.PbList<Help_Link> createRepeated() => $pb.PbList<Help_Link>();
  @$core.pragma('dart2js:noInline')
  static Help_Link getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help_Link>(create);
  static Help_Link? _defaultInstance;

  /// Describes what the link offers.
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

  /// The URL of the link.
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

///  Provides links to documentation or for performing an out of band action.
///
///  For example, if a quota check failed with an error indicating the calling
///  project hasn't enabled the accessed service, this can contain a URL pointing
///  directly to the right place in the developer console to flip the bit.
class Help extends $pb.GeneratedMessage {
  factory Help({
    $core.Iterable<Help_Link>? links,
  }) {
    final result = create();
    if (links != null) {
      result.links.addAll(links);
    }
    return result;
  }
  Help._() : super();
  factory Help.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Help',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..pc<Help_Link>(1, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PM,
        subBuilder: Help_Link.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Help clone() => Help()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Help copyWith(void Function(Help) updates) =>
      super.copyWith((message) => updates(message as Help)) as Help;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Help create() => Help._();
  Help createEmptyInstance() => create();
  static $pb.PbList<Help> createRepeated() => $pb.PbList<Help>();
  @$core.pragma('dart2js:noInline')
  static Help getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help>(create);
  static Help? _defaultInstance;

  /// URL(s) pointing to additional information on handling the current error.
  @$pb.TagNumber(1)
  $core.List<Help_Link> get links => $_getList(0);
}

/// Provides a localized error message that is safe to return to the user
/// which can be attached to an RPC error.
class LocalizedMessage extends $pb.GeneratedMessage {
  factory LocalizedMessage({
    $core.String? locale,
    $core.String? message,
  }) {
    final result = create();
    if (locale != null) {
      result.locale = locale;
    }
    if (message != null) {
      result.message = message;
    }
    return result;
  }
  LocalizedMessage._() : super();
  factory LocalizedMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LocalizedMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocalizedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LocalizedMessage clone() => LocalizedMessage()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LocalizedMessage copyWith(void Function(LocalizedMessage) updates) =>
      super.copyWith((message) => updates(message as LocalizedMessage))
          as LocalizedMessage;

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

  /// The locale used following the specification defined at
  /// http://www.rfc-editor.org/rfc/bcp/bcp47.txt.
  /// Examples are: "en-US", "fr-CH", "es-MX"
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

  /// The localized error message in the above locale.
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

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
