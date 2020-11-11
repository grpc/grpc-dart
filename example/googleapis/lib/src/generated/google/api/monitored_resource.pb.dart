///
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pb.dart' as $0;
import '../protobuf/struct.pb.dart' as $1;

import 'launch_stage.pbenum.dart' as $2;

class MonitoredResourceDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'MonitoredResourceDescriptor',
      package: const $pb.PackageName('google.api'),
      createEmptyInstance: create)
    ..aOS(1, 'type')
    ..aOS(2, 'displayName')
    ..aOS(3, 'description')
    ..pc<$0.LabelDescriptor>(4, 'labels', $pb.PbFieldType.PM,
        subBuilder: $0.LabelDescriptor.create)
    ..aOS(5, 'name')
    ..e<$2.LaunchStage>(7, 'launchStage', $pb.PbFieldType.OE,
        defaultOrMaker: $2.LaunchStage.LAUNCH_STAGE_UNSPECIFIED,
        valueOf: $2.LaunchStage.valueOf,
        enumValues: $2.LaunchStage.values)
    ..hasRequiredFields = false;

  MonitoredResourceDescriptor._() : super();
  factory MonitoredResourceDescriptor() => create();
  factory MonitoredResourceDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  MonitoredResourceDescriptor clone() =>
      MonitoredResourceDescriptor()..mergeFromMessage(this);
  MonitoredResourceDescriptor copyWith(
          void Function(MonitoredResourceDescriptor) updates) =>
      super.copyWith(
          (message) => updates(message as MonitoredResourceDescriptor));
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
  static MonitoredResourceDescriptor _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MonitoredResource',
      package: const $pb.PackageName('google.api'), createEmptyInstance: create)
    ..aOS(1, 'type')
    ..m<$core.String, $core.String>(2, 'labels',
        entryClassName: 'MonitoredResource.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  MonitoredResource._() : super();
  factory MonitoredResource() => create();
  factory MonitoredResource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  MonitoredResource clone() => MonitoredResource()..mergeFromMessage(this);
  MonitoredResource copyWith(void Function(MonitoredResource) updates) =>
      super.copyWith((message) => updates(message as MonitoredResource));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitoredResource create() => MonitoredResource._();
  MonitoredResource createEmptyInstance() => create();
  static $pb.PbList<MonitoredResource> createRepeated() =>
      $pb.PbList<MonitoredResource>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResource>(create);
  static MonitoredResource _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MonitoredResourceMetadata',
      package: const $pb.PackageName('google.api'), createEmptyInstance: create)
    ..aOM<$1.Struct>(1, 'systemLabels', subBuilder: $1.Struct.create)
    ..m<$core.String, $core.String>(2, 'userLabels',
        entryClassName: 'MonitoredResourceMetadata.UserLabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  MonitoredResourceMetadata._() : super();
  factory MonitoredResourceMetadata() => create();
  factory MonitoredResourceMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MonitoredResourceMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  MonitoredResourceMetadata clone() =>
      MonitoredResourceMetadata()..mergeFromMessage(this);
  MonitoredResourceMetadata copyWith(
          void Function(MonitoredResourceMetadata) updates) =>
      super
          .copyWith((message) => updates(message as MonitoredResourceMetadata));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata create() => MonitoredResourceMetadata._();
  MonitoredResourceMetadata createEmptyInstance() => create();
  static $pb.PbList<MonitoredResourceMetadata> createRepeated() =>
      $pb.PbList<MonitoredResourceMetadata>();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceMetadata>(create);
  static MonitoredResourceMetadata _defaultInstance;

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
