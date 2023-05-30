///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/safety.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'safety.pbenum.dart';

export 'safety.pbenum.dart';

class ContentFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ContentFilter',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..e<ContentFilter_BlockedReason>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'reason',
        $pb.PbFieldType.OE,
        defaultOrMaker: ContentFilter_BlockedReason.BLOCKED_REASON_UNSPECIFIED,
        valueOf: ContentFilter_BlockedReason.valueOf,
        enumValues: ContentFilter_BlockedReason.values)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  ContentFilter._() : super();
  factory ContentFilter({
    ContentFilter_BlockedReason? reason,
    $core.String? message,
  }) {
    final _result = create();
    if (reason != null) {
      _result.reason = reason;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ContentFilter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ContentFilter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ContentFilter clone() => ContentFilter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ContentFilter copyWith(void Function(ContentFilter) updates) =>
      super.copyWith((message) => updates(message as ContentFilter))
          as ContentFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContentFilter create() => ContentFilter._();
  ContentFilter createEmptyInstance() => create();
  static $pb.PbList<ContentFilter> createRepeated() =>
      $pb.PbList<ContentFilter>();
  @$core.pragma('dart2js:noInline')
  static ContentFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContentFilter>(create);
  static ContentFilter? _defaultInstance;

  @$pb.TagNumber(1)
  ContentFilter_BlockedReason get reason => $_getN(0);
  @$pb.TagNumber(1)
  set reason(ContentFilter_BlockedReason v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);

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

class SafetyFeedback extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SafetyFeedback',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOM<SafetyRating>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'rating',
        subBuilder: SafetyRating.create)
    ..aOM<SafetySetting>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'setting',
        subBuilder: SafetySetting.create)
    ..hasRequiredFields = false;

  SafetyFeedback._() : super();
  factory SafetyFeedback({
    SafetyRating? rating,
    SafetySetting? setting,
  }) {
    final _result = create();
    if (rating != null) {
      _result.rating = rating;
    }
    if (setting != null) {
      _result.setting = setting;
    }
    return _result;
  }
  factory SafetyFeedback.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SafetyFeedback.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SafetyFeedback clone() => SafetyFeedback()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SafetyFeedback copyWith(void Function(SafetyFeedback) updates) =>
      super.copyWith((message) => updates(message as SafetyFeedback))
          as SafetyFeedback; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SafetyFeedback create() => SafetyFeedback._();
  SafetyFeedback createEmptyInstance() => create();
  static $pb.PbList<SafetyFeedback> createRepeated() =>
      $pb.PbList<SafetyFeedback>();
  @$core.pragma('dart2js:noInline')
  static SafetyFeedback getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SafetyFeedback>(create);
  static SafetyFeedback? _defaultInstance;

  @$pb.TagNumber(1)
  SafetyRating get rating => $_getN(0);
  @$pb.TagNumber(1)
  set rating(SafetyRating v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRating() => $_has(0);
  @$pb.TagNumber(1)
  void clearRating() => clearField(1);
  @$pb.TagNumber(1)
  SafetyRating ensureRating() => $_ensure(0);

  @$pb.TagNumber(2)
  SafetySetting get setting => $_getN(1);
  @$pb.TagNumber(2)
  set setting(SafetySetting v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetting() => clearField(2);
  @$pb.TagNumber(2)
  SafetySetting ensureSetting() => $_ensure(1);
}

class SafetyRating extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SafetyRating',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..e<HarmCategory>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'category',
        $pb.PbFieldType.OE,
        defaultOrMaker: HarmCategory.HARM_CATEGORY_UNSPECIFIED,
        valueOf: HarmCategory.valueOf,
        enumValues: HarmCategory.values)
    ..e<SafetyRating_HarmProbability>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'probability',
        $pb.PbFieldType.OE,
        defaultOrMaker:
            SafetyRating_HarmProbability.HARM_PROBABILITY_UNSPECIFIED,
        valueOf: SafetyRating_HarmProbability.valueOf,
        enumValues: SafetyRating_HarmProbability.values)
    ..hasRequiredFields = false;

  SafetyRating._() : super();
  factory SafetyRating({
    HarmCategory? category,
    SafetyRating_HarmProbability? probability,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (probability != null) {
      _result.probability = probability;
    }
    return _result;
  }
  factory SafetyRating.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SafetyRating.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SafetyRating clone() => SafetyRating()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SafetyRating copyWith(void Function(SafetyRating) updates) =>
      super.copyWith((message) => updates(message as SafetyRating))
          as SafetyRating; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SafetyRating create() => SafetyRating._();
  SafetyRating createEmptyInstance() => create();
  static $pb.PbList<SafetyRating> createRepeated() =>
      $pb.PbList<SafetyRating>();
  @$core.pragma('dart2js:noInline')
  static SafetyRating getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SafetyRating>(create);
  static SafetyRating? _defaultInstance;

  @$pb.TagNumber(3)
  HarmCategory get category => $_getN(0);
  @$pb.TagNumber(3)
  set category(HarmCategory v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  SafetyRating_HarmProbability get probability => $_getN(1);
  @$pb.TagNumber(4)
  set probability(SafetyRating_HarmProbability v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasProbability() => $_has(1);
  @$pb.TagNumber(4)
  void clearProbability() => clearField(4);
}

class SafetySetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SafetySetting',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..e<HarmCategory>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'category',
        $pb.PbFieldType.OE,
        defaultOrMaker: HarmCategory.HARM_CATEGORY_UNSPECIFIED,
        valueOf: HarmCategory.valueOf,
        enumValues: HarmCategory.values)
    ..e<SafetySetting_HarmBlockThreshold>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'threshold',
        $pb.PbFieldType.OE,
        defaultOrMaker:
            SafetySetting_HarmBlockThreshold.HARM_BLOCK_THRESHOLD_UNSPECIFIED,
        valueOf: SafetySetting_HarmBlockThreshold.valueOf,
        enumValues: SafetySetting_HarmBlockThreshold.values)
    ..hasRequiredFields = false;

  SafetySetting._() : super();
  factory SafetySetting({
    HarmCategory? category,
    SafetySetting_HarmBlockThreshold? threshold,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (threshold != null) {
      _result.threshold = threshold;
    }
    return _result;
  }
  factory SafetySetting.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SafetySetting.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SafetySetting clone() => SafetySetting()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SafetySetting copyWith(void Function(SafetySetting) updates) =>
      super.copyWith((message) => updates(message as SafetySetting))
          as SafetySetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SafetySetting create() => SafetySetting._();
  SafetySetting createEmptyInstance() => create();
  static $pb.PbList<SafetySetting> createRepeated() =>
      $pb.PbList<SafetySetting>();
  @$core.pragma('dart2js:noInline')
  static SafetySetting getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SafetySetting>(create);
  static SafetySetting? _defaultInstance;

  @$pb.TagNumber(3)
  HarmCategory get category => $_getN(0);
  @$pb.TagNumber(3)
  set category(HarmCategory v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  SafetySetting_HarmBlockThreshold get threshold => $_getN(1);
  @$pb.TagNumber(4)
  set threshold(SafetySetting_HarmBlockThreshold v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasThreshold() => $_has(1);
  @$pb.TagNumber(4)
  void clearThreshold() => clearField(4);
}
