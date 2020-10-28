///
//  Generated code. Do not modify.
//  source: google/rpc/error_details.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/duration.pb.dart' as $1;

class RetryInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RetryInfo',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOM<$1.Duration>(1, 'retryDelay', subBuilder: $1.Duration.create)
    ..hasRequiredFields = false;

  RetryInfo._() : super();
  factory RetryInfo() => create();
  factory RetryInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RetryInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RetryInfo clone() => RetryInfo()..mergeFromMessage(this);
  RetryInfo copyWith(void Function(RetryInfo) updates) =>
      super.copyWith((message) => updates(message as RetryInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RetryInfo create() => RetryInfo._();
  RetryInfo createEmptyInstance() => create();
  static $pb.PbList<RetryInfo> createRepeated() => $pb.PbList<RetryInfo>();
  @$core.pragma('dart2js:noInline')
  static RetryInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RetryInfo>(create);
  static RetryInfo _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DebugInfo',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..pPS(1, 'stackEntries')
    ..aOS(2, 'detail')
    ..hasRequiredFields = false;

  DebugInfo._() : super();
  factory DebugInfo() => create();
  factory DebugInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  DebugInfo clone() => DebugInfo()..mergeFromMessage(this);
  DebugInfo copyWith(void Function(DebugInfo) updates) =>
      super.copyWith((message) => updates(message as DebugInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DebugInfo create() => DebugInfo._();
  DebugInfo createEmptyInstance() => create();
  static $pb.PbList<DebugInfo> createRepeated() => $pb.PbList<DebugInfo>();
  @$core.pragma('dart2js:noInline')
  static DebugInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebugInfo>(create);
  static DebugInfo _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QuotaFailure.Violation',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'subject')
    ..aOS(2, 'description')
    ..hasRequiredFields = false;

  QuotaFailure_Violation._() : super();
  factory QuotaFailure_Violation() => create();
  factory QuotaFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  QuotaFailure_Violation clone() =>
      QuotaFailure_Violation()..mergeFromMessage(this);
  QuotaFailure_Violation copyWith(
          void Function(QuotaFailure_Violation) updates) =>
      super.copyWith((message) => updates(message as QuotaFailure_Violation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuotaFailure_Violation create() => QuotaFailure_Violation._();
  QuotaFailure_Violation createEmptyInstance() => create();
  static $pb.PbList<QuotaFailure_Violation> createRepeated() =>
      $pb.PbList<QuotaFailure_Violation>();
  @$core.pragma('dart2js:noInline')
  static QuotaFailure_Violation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaFailure_Violation>(create);
  static QuotaFailure_Violation _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QuotaFailure',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..pc<QuotaFailure_Violation>(1, 'violations', $pb.PbFieldType.PM,
        subBuilder: QuotaFailure_Violation.create)
    ..hasRequiredFields = false;

  QuotaFailure._() : super();
  factory QuotaFailure() => create();
  factory QuotaFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  QuotaFailure clone() => QuotaFailure()..mergeFromMessage(this);
  QuotaFailure copyWith(void Function(QuotaFailure) updates) =>
      super.copyWith((message) => updates(message as QuotaFailure));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuotaFailure create() => QuotaFailure._();
  QuotaFailure createEmptyInstance() => create();
  static $pb.PbList<QuotaFailure> createRepeated() =>
      $pb.PbList<QuotaFailure>();
  @$core.pragma('dart2js:noInline')
  static QuotaFailure getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaFailure>(create);
  static QuotaFailure _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<QuotaFailure_Violation> get violations => $_getList(0);
}

class ErrorInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ErrorInfo',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'reason')
    ..aOS(2, 'domain')
    ..m<$core.String, $core.String>(3, 'metadata',
        entryClassName: 'ErrorInfo.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.rpc'))
    ..hasRequiredFields = false;

  ErrorInfo._() : super();
  factory ErrorInfo() => create();
  factory ErrorInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ErrorInfo clone() => ErrorInfo()..mergeFromMessage(this);
  ErrorInfo copyWith(void Function(ErrorInfo) updates) =>
      super.copyWith((message) => updates(message as ErrorInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ErrorInfo create() => ErrorInfo._();
  ErrorInfo createEmptyInstance() => create();
  static $pb.PbList<ErrorInfo> createRepeated() => $pb.PbList<ErrorInfo>();
  @$core.pragma('dart2js:noInline')
  static ErrorInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorInfo>(create);
  static ErrorInfo _defaultInstance;

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
      'PreconditionFailure.Violation',
      package: const $pb.PackageName('google.rpc'),
      createEmptyInstance: create)
    ..aOS(1, 'type')
    ..aOS(2, 'subject')
    ..aOS(3, 'description')
    ..hasRequiredFields = false;

  PreconditionFailure_Violation._() : super();
  factory PreconditionFailure_Violation() => create();
  factory PreconditionFailure_Violation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure_Violation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  PreconditionFailure_Violation clone() =>
      PreconditionFailure_Violation()..mergeFromMessage(this);
  PreconditionFailure_Violation copyWith(
          void Function(PreconditionFailure_Violation) updates) =>
      super.copyWith(
          (message) => updates(message as PreconditionFailure_Violation));
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
  static PreconditionFailure_Violation _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PreconditionFailure',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..pc<PreconditionFailure_Violation>(1, 'violations', $pb.PbFieldType.PM,
        subBuilder: PreconditionFailure_Violation.create)
    ..hasRequiredFields = false;

  PreconditionFailure._() : super();
  factory PreconditionFailure() => create();
  factory PreconditionFailure.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PreconditionFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  PreconditionFailure clone() => PreconditionFailure()..mergeFromMessage(this);
  PreconditionFailure copyWith(void Function(PreconditionFailure) updates) =>
      super.copyWith((message) => updates(message as PreconditionFailure));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure create() => PreconditionFailure._();
  PreconditionFailure createEmptyInstance() => create();
  static $pb.PbList<PreconditionFailure> createRepeated() =>
      $pb.PbList<PreconditionFailure>();
  @$core.pragma('dart2js:noInline')
  static PreconditionFailure getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreconditionFailure>(create);
  static PreconditionFailure _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PreconditionFailure_Violation> get violations => $_getList(0);
}

class BadRequest_FieldViolation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BadRequest.FieldViolation',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'field')
    ..aOS(2, 'description')
    ..hasRequiredFields = false;

  BadRequest_FieldViolation._() : super();
  factory BadRequest_FieldViolation() => create();
  factory BadRequest_FieldViolation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest_FieldViolation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  BadRequest_FieldViolation clone() =>
      BadRequest_FieldViolation()..mergeFromMessage(this);
  BadRequest_FieldViolation copyWith(
          void Function(BadRequest_FieldViolation) updates) =>
      super
          .copyWith((message) => updates(message as BadRequest_FieldViolation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BadRequest_FieldViolation create() => BadRequest_FieldViolation._();
  BadRequest_FieldViolation createEmptyInstance() => create();
  static $pb.PbList<BadRequest_FieldViolation> createRepeated() =>
      $pb.PbList<BadRequest_FieldViolation>();
  @$core.pragma('dart2js:noInline')
  static BadRequest_FieldViolation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest_FieldViolation>(create);
  static BadRequest_FieldViolation _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BadRequest',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..pc<BadRequest_FieldViolation>(1, 'fieldViolations', $pb.PbFieldType.PM,
        subBuilder: BadRequest_FieldViolation.create)
    ..hasRequiredFields = false;

  BadRequest._() : super();
  factory BadRequest() => create();
  factory BadRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BadRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  BadRequest clone() => BadRequest()..mergeFromMessage(this);
  BadRequest copyWith(void Function(BadRequest) updates) =>
      super.copyWith((message) => updates(message as BadRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BadRequest create() => BadRequest._();
  BadRequest createEmptyInstance() => create();
  static $pb.PbList<BadRequest> createRepeated() => $pb.PbList<BadRequest>();
  @$core.pragma('dart2js:noInline')
  static BadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BadRequest>(create);
  static BadRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BadRequest_FieldViolation> get fieldViolations => $_getList(0);
}

class RequestInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestInfo',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'requestId')
    ..aOS(2, 'servingData')
    ..hasRequiredFields = false;

  RequestInfo._() : super();
  factory RequestInfo() => create();
  factory RequestInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RequestInfo clone() => RequestInfo()..mergeFromMessage(this);
  RequestInfo copyWith(void Function(RequestInfo) updates) =>
      super.copyWith((message) => updates(message as RequestInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInfo create() => RequestInfo._();
  RequestInfo createEmptyInstance() => create();
  static $pb.PbList<RequestInfo> createRepeated() => $pb.PbList<RequestInfo>();
  @$core.pragma('dart2js:noInline')
  static RequestInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInfo>(create);
  static RequestInfo _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResourceInfo',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'resourceType')
    ..aOS(2, 'resourceName')
    ..aOS(3, 'owner')
    ..aOS(4, 'description')
    ..hasRequiredFields = false;

  ResourceInfo._() : super();
  factory ResourceInfo() => create();
  factory ResourceInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResourceInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ResourceInfo clone() => ResourceInfo()..mergeFromMessage(this);
  ResourceInfo copyWith(void Function(ResourceInfo) updates) =>
      super.copyWith((message) => updates(message as ResourceInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResourceInfo create() => ResourceInfo._();
  ResourceInfo createEmptyInstance() => create();
  static $pb.PbList<ResourceInfo> createRepeated() =>
      $pb.PbList<ResourceInfo>();
  @$core.pragma('dart2js:noInline')
  static ResourceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResourceInfo>(create);
  static ResourceInfo _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Help.Link',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'description')
    ..aOS(2, 'url')
    ..hasRequiredFields = false;

  Help_Link._() : super();
  factory Help_Link() => create();
  factory Help_Link.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help_Link.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Help_Link clone() => Help_Link()..mergeFromMessage(this);
  Help_Link copyWith(void Function(Help_Link) updates) =>
      super.copyWith((message) => updates(message as Help_Link));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Help_Link create() => Help_Link._();
  Help_Link createEmptyInstance() => create();
  static $pb.PbList<Help_Link> createRepeated() => $pb.PbList<Help_Link>();
  @$core.pragma('dart2js:noInline')
  static Help_Link getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help_Link>(create);
  static Help_Link _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Help',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..pc<Help_Link>(1, 'links', $pb.PbFieldType.PM,
        subBuilder: Help_Link.create)
    ..hasRequiredFields = false;

  Help._() : super();
  factory Help() => create();
  factory Help.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Help.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Help clone() => Help()..mergeFromMessage(this);
  Help copyWith(void Function(Help) updates) =>
      super.copyWith((message) => updates(message as Help));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Help create() => Help._();
  Help createEmptyInstance() => create();
  static $pb.PbList<Help> createRepeated() => $pb.PbList<Help>();
  @$core.pragma('dart2js:noInline')
  static Help getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Help>(create);
  static Help _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Help_Link> get links => $_getList(0);
}

class LocalizedMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LocalizedMessage',
      package: const $pb.PackageName('google.rpc'), createEmptyInstance: create)
    ..aOS(1, 'locale')
    ..aOS(2, 'message')
    ..hasRequiredFields = false;

  LocalizedMessage._() : super();
  factory LocalizedMessage() => create();
  factory LocalizedMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LocalizedMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  LocalizedMessage clone() => LocalizedMessage()..mergeFromMessage(this);
  LocalizedMessage copyWith(void Function(LocalizedMessage) updates) =>
      super.copyWith((message) => updates(message as LocalizedMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LocalizedMessage create() => LocalizedMessage._();
  LocalizedMessage createEmptyInstance() => create();
  static $pb.PbList<LocalizedMessage> createRepeated() =>
      $pb.PbList<LocalizedMessage>();
  @$core.pragma('dart2js:noInline')
  static LocalizedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocalizedMessage>(create);
  static LocalizedMessage _defaultInstance;

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
