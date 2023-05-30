///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/model.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Model extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Model',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'baseModelId')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'version')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'displayName')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..a<$core.int>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'inputTokenLimit',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'outputTokenLimit',
        $pb.PbFieldType.O3)
    ..pPS(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'supportedGenerationMethods')
    ..a<$core.double>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'temperature',
        $pb.PbFieldType.OF)
    ..a<$core.double>(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'topP',
        $pb.PbFieldType.OF)
    ..a<$core.int>(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'topK',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  Model._() : super();
  factory Model({
    $core.String? name,
    $core.String? baseModelId,
    $core.String? version,
    $core.String? displayName,
    $core.String? description,
    $core.int? inputTokenLimit,
    $core.int? outputTokenLimit,
    $core.Iterable<$core.String>? supportedGenerationMethods,
    $core.double? temperature,
    $core.double? topP,
    $core.int? topK,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (baseModelId != null) {
      _result.baseModelId = baseModelId;
    }
    if (version != null) {
      _result.version = version;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (description != null) {
      _result.description = description;
    }
    if (inputTokenLimit != null) {
      _result.inputTokenLimit = inputTokenLimit;
    }
    if (outputTokenLimit != null) {
      _result.outputTokenLimit = outputTokenLimit;
    }
    if (supportedGenerationMethods != null) {
      _result.supportedGenerationMethods.addAll(supportedGenerationMethods);
    }
    if (temperature != null) {
      _result.temperature = temperature;
    }
    if (topP != null) {
      _result.topP = topP;
    }
    if (topK != null) {
      _result.topK = topK;
    }
    return _result;
  }
  factory Model.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Model.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Model clone() => Model()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Model copyWith(void Function(Model) updates) =>
      super.copyWith((message) => updates(message as Model))
          as Model; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Model create() => Model._();
  Model createEmptyInstance() => create();
  static $pb.PbList<Model> createRepeated() => $pb.PbList<Model>();
  @$core.pragma('dart2js:noInline')
  static Model getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Model>(create);
  static Model? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get baseModelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set baseModelId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasBaseModelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseModelId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get version => $_getSZ(2);
  @$pb.TagNumber(3)
  set version($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get inputTokenLimit => $_getIZ(5);
  @$pb.TagNumber(6)
  set inputTokenLimit($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasInputTokenLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearInputTokenLimit() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get outputTokenLimit => $_getIZ(6);
  @$pb.TagNumber(7)
  set outputTokenLimit($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOutputTokenLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutputTokenLimit() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get supportedGenerationMethods => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get temperature => $_getN(8);
  @$pb.TagNumber(9)
  set temperature($core.double v) {
    $_setFloat(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasTemperature() => $_has(8);
  @$pb.TagNumber(9)
  void clearTemperature() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get topP => $_getN(9);
  @$pb.TagNumber(10)
  set topP($core.double v) {
    $_setFloat(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTopP() => $_has(9);
  @$pb.TagNumber(10)
  void clearTopP() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get topK => $_getIZ(10);
  @$pb.TagNumber(11)
  set topK($core.int v) {
    $_setSignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasTopK() => $_has(10);
  @$pb.TagNumber(11)
  void clearTopK() => clearField(11);
}
