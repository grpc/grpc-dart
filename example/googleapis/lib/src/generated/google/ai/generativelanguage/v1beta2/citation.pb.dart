///
//  Generated code. Do not modify.
//  source: google/ai/generativelanguage/v1beta2/citation.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CitationMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CitationMetadata',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..pc<CitationSource>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'citationSources',
        $pb.PbFieldType.PM,
        subBuilder: CitationSource.create)
    ..hasRequiredFields = false;

  CitationMetadata._() : super();
  factory CitationMetadata({
    $core.Iterable<CitationSource>? citationSources,
  }) {
    final _result = create();
    if (citationSources != null) {
      _result.citationSources.addAll(citationSources);
    }
    return _result;
  }
  factory CitationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CitationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CitationMetadata clone() => CitationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CitationMetadata copyWith(void Function(CitationMetadata) updates) =>
      super.copyWith((message) => updates(message as CitationMetadata))
          as CitationMetadata; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CitationMetadata create() => CitationMetadata._();
  CitationMetadata createEmptyInstance() => create();
  static $pb.PbList<CitationMetadata> createRepeated() =>
      $pb.PbList<CitationMetadata>();
  @$core.pragma('dart2js:noInline')
  static CitationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CitationMetadata>(create);
  static CitationMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CitationSource> get citationSources => $_getList(0);
}

class CitationSource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CitationSource',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.ai.generativelanguage.v1beta2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'startIndex',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'endIndex',
        $pb.PbFieldType.O3)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'uri')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'license')
    ..hasRequiredFields = false;

  CitationSource._() : super();
  factory CitationSource({
    $core.int? startIndex,
    $core.int? endIndex,
    $core.String? uri,
    $core.String? license,
  }) {
    final _result = create();
    if (startIndex != null) {
      _result.startIndex = startIndex;
    }
    if (endIndex != null) {
      _result.endIndex = endIndex;
    }
    if (uri != null) {
      _result.uri = uri;
    }
    if (license != null) {
      _result.license = license;
    }
    return _result;
  }
  factory CitationSource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CitationSource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CitationSource clone() => CitationSource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CitationSource copyWith(void Function(CitationSource) updates) =>
      super.copyWith((message) => updates(message as CitationSource))
          as CitationSource; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CitationSource create() => CitationSource._();
  CitationSource createEmptyInstance() => create();
  static $pb.PbList<CitationSource> createRepeated() =>
      $pb.PbList<CitationSource>();
  @$core.pragma('dart2js:noInline')
  static CitationSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CitationSource>(create);
  static CitationSource? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get startIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set startIndex($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStartIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartIndex() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get endIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set endIndex($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEndIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get uri => $_getSZ(2);
  @$pb.TagNumber(3)
  set uri($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUri() => $_has(2);
  @$pb.TagNumber(3)
  void clearUri() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get license => $_getSZ(3);
  @$pb.TagNumber(4)
  set license($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLicense() => $_has(3);
  @$pb.TagNumber(4)
  void clearLicense() => clearField(4);
}
