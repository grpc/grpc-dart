///
//  Generated code. Do not modify.
//  source: google/api/monitored_resource.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'label.pb.dart' as $0;
import '../protobuf/struct.pb.dart' as $1;

import 'launch_stage.pbenum.dart' as $2;

class MonitoredResourceDescriptor extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      'MonitoredResourceDescriptor',
      package: const $pb.PackageName('google.api'))
    ..aOS(1, 'type')
    ..aOS(2, 'displayName')
    ..aOS(3, 'description')
    ..pc<$0.LabelDescriptor>(
        4, 'labels', $pb.PbFieldType.PM, $0.LabelDescriptor.create)
    ..aOS(5, 'name')
    ..e<$2.LaunchStage>(
        7,
        'launchStage',
        $pb.PbFieldType.OE,
        $2.LaunchStage.LAUNCH_STAGE_UNSPECIFIED,
        $2.LaunchStage.valueOf,
        $2.LaunchStage.values)
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
  static MonitoredResourceDescriptor getDefault() =>
      _defaultInstance ??= create()..freeze();
  static MonitoredResourceDescriptor _defaultInstance;

  $core.String get type => $_getS(0, '');
  set type($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.String get displayName => $_getS(1, '');
  set displayName($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasDisplayName() => $_has(1);
  void clearDisplayName() => clearField(2);

  $core.String get description => $_getS(2, '');
  set description($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasDescription() => $_has(2);
  void clearDescription() => clearField(3);

  $core.List<$0.LabelDescriptor> get labels => $_getList(3);

  $core.String get name => $_getS(4, '');
  set name($core.String v) {
    $_setString(4, v);
  }

  $core.bool hasName() => $_has(4);
  void clearName() => clearField(5);

  $2.LaunchStage get launchStage => $_getN(5);
  set launchStage($2.LaunchStage v) {
    setField(7, v);
  }

  $core.bool hasLaunchStage() => $_has(5);
  void clearLaunchStage() => clearField(7);
}

class MonitoredResource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MonitoredResource',
      package: const $pb.PackageName('google.api'))
    ..aOS(1, 'type')
    ..m<$core.String, $core.String>(
        2,
        'labels',
        'MonitoredResource.LabelsEntry',
        $pb.PbFieldType.OS,
        $pb.PbFieldType.OS,
        null,
        null,
        null,
        const $pb.PackageName('google.api'))
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
  static MonitoredResource getDefault() =>
      _defaultInstance ??= create()..freeze();
  static MonitoredResource _defaultInstance;

  $core.String get type => $_getS(0, '');
  set type($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.Map<$core.String, $core.String> get labels => $_getMap(1);
}

class MonitoredResourceMetadata extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MonitoredResourceMetadata',
      package: const $pb.PackageName('google.api'))
    ..a<$1.Struct>(1, 'systemLabels', $pb.PbFieldType.OM, $1.Struct.getDefault,
        $1.Struct.create)
    ..m<$core.String, $core.String>(
        2,
        'userLabels',
        'MonitoredResourceMetadata.UserLabelsEntry',
        $pb.PbFieldType.OS,
        $pb.PbFieldType.OS,
        null,
        null,
        null,
        const $pb.PackageName('google.api'))
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
  static MonitoredResourceMetadata getDefault() =>
      _defaultInstance ??= create()..freeze();
  static MonitoredResourceMetadata _defaultInstance;

  $1.Struct get systemLabels => $_getN(0);
  set systemLabels($1.Struct v) {
    setField(1, v);
  }

  $core.bool hasSystemLabels() => $_has(0);
  void clearSystemLabels() => clearField(1);

  $core.Map<$core.String, $core.String> get userLabels => $_getMap(1);
}
