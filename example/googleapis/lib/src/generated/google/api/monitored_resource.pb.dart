///
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pb.dart' as $0;
import '../protobuf/struct.pb.dart' as $1;

import 'launch_stage.pbenum.dart' as $2;

class MonitoredResourceDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'MonitoredResourceDescriptor',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.api'),
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
            : 'displayName')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..pc<$0.LabelDescriptor>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'labels',
        $pb.PbFieldType.PM,
        subBuilder: $0.LabelDescriptor.create)
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..e<$2.LaunchStage>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'launchStage',
        $pb.PbFieldType.OE,
        defaultOrMaker: $2.LaunchStage.LAUNCH_STAGE_UNSPECIFIED,
        valueOf: $2.LaunchStage.valueOf,
        enumValues: $2.LaunchStage.values)
    ..hasRequiredFields = false;

  MonitoredResourceDescriptor._() : super();
  factory MonitoredResourceDescriptor({
    $core.String? type,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$0.LabelDescriptor>? labels,
    $core.String? name,
    $2.LaunchStage? launchStage,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (description != null) {
      _result.description = description;
    }
    if (labels != null) {
      _result.labels.addAll(labels);
    }
    if (name != null) {
      _result.name = name;
    }
    if (launchStage != null) {
      _result.launchStage = launchStage;
    }
    return _result;
  }
  factory MonitoredResourceDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResourceDescriptor clone() =>
      MonitoredResourceDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResourceDescriptor copyWith(
          void Function(MonitoredResourceDescriptor) updates) =>
      super.copyWith(
              (message) => updates(message as MonitoredResourceDescriptor))
          as MonitoredResourceDescriptor; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor create() =>
      MonitoredResourceDescriptor._();
  MonitoredResourceDescriptor createEmptyInstance() => create();
  static $pb.PbList<MonitoredResourceDescriptor> createRepeated() =>
      $pb.PbList<MonitoredResourceDescriptor>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceDescriptor>(create);
  static MonitoredResourceDescriptor? _defaultInstance;

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
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

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

  @$pb.TagNumber(4)
  $core.List<$0.LabelDescriptor> get labels => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);

  @$pb.TagNumber(7)
  $2.LaunchStage get launchStage => $_getN(5);
  @$pb.TagNumber(7)
  set launchStage($2.LaunchStage v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLaunchStage() => $_has(5);
  @$pb.TagNumber(7)
  void clearLaunchStage() => clearField(7);
}

class MonitoredResource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'MonitoredResource',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.api'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'type')
    ..m<$core.String, $core.String>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'labels',
        entryClassName: 'MonitoredResource.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  MonitoredResource._() : super();
  factory MonitoredResource({
    $core.String? type,
    $core.Map<$core.String, $core.String>? labels,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (labels != null) {
      _result.labels.addAll(labels);
    }
    return _result;
  }
  factory MonitoredResource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResource clone() => MonitoredResource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResource copyWith(void Function(MonitoredResource) updates) =>
      super.copyWith((message) => updates(message as MonitoredResource))
          as MonitoredResource; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitoredResource create() => MonitoredResource._();
  MonitoredResource createEmptyInstance() => create();
  static $pb.PbList<MonitoredResource> createRepeated() =>
      $pb.PbList<MonitoredResource>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResource>(create);
  static MonitoredResource? _defaultInstance;

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
  $core.Map<$core.String, $core.String> get labels => $_getMap(1);
}

class MonitoredResourceMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'MonitoredResourceMetadata',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'google.api'),
      createEmptyInstance: create)
    ..aOM<$1.Struct>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'systemLabels',
        subBuilder: $1.Struct.create)
    ..m<$core.String, $core.String>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userLabels',
        entryClassName: 'MonitoredResourceMetadata.UserLabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  MonitoredResourceMetadata._() : super();
  factory MonitoredResourceMetadata({
    $1.Struct? systemLabels,
    $core.Map<$core.String, $core.String>? userLabels,
  }) {
    final _result = create();
    if (systemLabels != null) {
      _result.systemLabels = systemLabels;
    }
    if (userLabels != null) {
      _result.userLabels.addAll(userLabels);
    }
    return _result;
  }
  factory MonitoredResourceMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MonitoredResourceMetadata clone() =>
      MonitoredResourceMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MonitoredResourceMetadata copyWith(
          void Function(MonitoredResourceMetadata) updates) =>
      super.copyWith((message) => updates(message as MonitoredResourceMetadata))
          as MonitoredResourceMetadata; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata create() => MonitoredResourceMetadata._();
  MonitoredResourceMetadata createEmptyInstance() => create();
  static $pb.PbList<MonitoredResourceMetadata> createRepeated() =>
      $pb.PbList<MonitoredResourceMetadata>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceMetadata>(create);
  static MonitoredResourceMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Struct get systemLabels => $_getN(0);
  @$pb.TagNumber(1)
  set systemLabels($1.Struct v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSystemLabels() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystemLabels() => clearField(1);
  @$pb.TagNumber(1)
  $1.Struct ensureSystemLabels() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get userLabels => $_getMap(1);
}
