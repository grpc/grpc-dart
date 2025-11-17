// This is a generated file - do not edit.
//
// Generated from google/api/monitored_resource.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/struct.pb.dart' as $1;
import 'label.pb.dart' as $0;
import 'launch_stage.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// An object that describes the schema of a
/// [MonitoredResource][google.api.MonitoredResource] object using a type name
/// and a set of labels.  For example, the monitored resource descriptor for
/// Google Compute Engine VM instances has a type of
/// `"gce_instance"` and specifies the use of the labels `"instance_id"` and
/// `"zone"` to identify particular VM instances.
///
/// Different APIs can support different monitored resource types. APIs generally
/// provide a `list` method that returns the monitored resource descriptors used
/// by the API.
class MonitoredResourceDescriptor extends $pb.GeneratedMessage {
  factory MonitoredResourceDescriptor({
    $core.String? type,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$0.LabelDescriptor>? labels,
    $core.String? name,
    $2.LaunchStage? launchStage,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (displayName != null) result.displayName = displayName;
    if (description != null) result.description = description;
    if (labels != null) result.labels.addAll(labels);
    if (name != null) result.name = name;
    if (launchStage != null) result.launchStage = launchStage;
    return result;
  }

  MonitoredResourceDescriptor._();

  factory MonitoredResourceDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonitoredResourceDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResourceDescriptor',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPM<$0.LabelDescriptor>(4, _omitFieldNames ? '' : 'labels',
        subBuilder: $0.LabelDescriptor.create)
    ..aOS(5, _omitFieldNames ? '' : 'name')
    ..aE<$2.LaunchStage>(7, _omitFieldNames ? '' : 'launchStage',
        enumValues: $2.LaunchStage.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResourceDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResourceDescriptor copyWith(
          void Function(MonitoredResourceDescriptor) updates) =>
      super.copyWith(
              (message) => updates(message as MonitoredResourceDescriptor))
          as MonitoredResourceDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor create() =>
      MonitoredResourceDescriptor._();
  @$core.override
  MonitoredResourceDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceDescriptor>(create);
  static MonitoredResourceDescriptor? _defaultInstance;

  /// Required. The monitored resource type. For example, the type
  /// `"cloudsql_database"` represents databases in Google Cloud SQL.
  ///  For a list of types, see [Monitored resource
  ///  types](https://cloud.google.com/monitoring/api/resources)
  /// and [Logging resource
  /// types](https://cloud.google.com/logging/docs/api/v2/resource-list).
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// Optional. A concise name for the monitored resource type that might be
  /// displayed in user interfaces. It should be a Title Cased Noun Phrase,
  /// without any article or other determiners. For example,
  /// `"Google Cloud SQL Database"`.
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  /// Optional. A detailed description of the monitored resource type that might
  /// be used in documentation.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  /// Required. A set of labels used to describe instances of this monitored
  /// resource type. For example, an individual Google Cloud SQL database is
  /// identified by values for the labels `"database_id"` and `"zone"`.
  @$pb.TagNumber(4)
  $pb.PbList<$0.LabelDescriptor> get labels => $_getList(3);

  /// Optional. The resource name of the monitored resource descriptor:
  /// `"projects/{project_id}/monitoredResourceDescriptors/{type}"` where
  /// {type} is the value of the `type` field in this object and
  /// {project_id} is a project ID that provides API-specific context for
  /// accessing the type.  APIs that do not use project information can use the
  /// resource name format `"monitoredResourceDescriptors/{type}"`.
  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => $_clearField(5);

  /// Optional. The launch stage of the monitored resource definition.
  @$pb.TagNumber(7)
  $2.LaunchStage get launchStage => $_getN(5);
  @$pb.TagNumber(7)
  set launchStage($2.LaunchStage value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLaunchStage() => $_has(5);
  @$pb.TagNumber(7)
  void clearLaunchStage() => $_clearField(7);
}

/// An object representing a resource that can be used for monitoring, logging,
/// billing, or other purposes. Examples include virtual machine instances,
/// databases, and storage devices such as disks. The `type` field identifies a
/// [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor] object
/// that describes the resource's schema. Information in the `labels` field
/// identifies the actual resource and its attributes according to the schema.
/// For example, a particular Compute Engine VM instance could be represented by
/// the following object, because the
/// [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor] for
/// `"gce_instance"` has labels
/// `"project_id"`, `"instance_id"` and `"zone"`:
///
///     { "type": "gce_instance",
///       "labels": { "project_id": "my-project",
///                   "instance_id": "12345678901234",
///                   "zone": "us-central1-a" }}
class MonitoredResource extends $pb.GeneratedMessage {
  factory MonitoredResource({
    $core.String? type,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (labels != null) result.labels.addEntries(labels);
    return result;
  }

  MonitoredResource._();

  factory MonitoredResource.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonitoredResource.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResource',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'labels',
        entryClassName: 'MonitoredResource.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResource clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResource copyWith(void Function(MonitoredResource) updates) =>
      super.copyWith((message) => updates(message as MonitoredResource))
          as MonitoredResource;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResource create() => MonitoredResource._();
  @$core.override
  MonitoredResource createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MonitoredResource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResource>(create);
  static MonitoredResource? _defaultInstance;

  /// Required. The monitored resource type. This field must match
  /// the `type` field of a
  /// [MonitoredResourceDescriptor][google.api.MonitoredResourceDescriptor]
  /// object. For example, the type of a Compute Engine VM instance is
  /// `gce_instance`. Some descriptors include the service name in the type; for
  /// example, the type of a Datastream stream is
  /// `datastream.googleapis.com/Stream`.
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// Required. Values for all of the labels listed in the associated monitored
  /// resource descriptor. For example, Compute Engine VM instances use the
  /// labels `"project_id"`, `"instance_id"`, and `"zone"`.
  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(1);
}

/// Auxiliary metadata for a [MonitoredResource][google.api.MonitoredResource]
/// object. [MonitoredResource][google.api.MonitoredResource] objects contain the
/// minimum set of information to uniquely identify a monitored resource
/// instance. There is some other useful auxiliary metadata. Monitoring and
/// Logging use an ingestion pipeline to extract metadata for cloud resources of
/// all types, and store the metadata in this message.
class MonitoredResourceMetadata extends $pb.GeneratedMessage {
  factory MonitoredResourceMetadata({
    $1.Struct? systemLabels,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? userLabels,
  }) {
    final result = create();
    if (systemLabels != null) result.systemLabels = systemLabels;
    if (userLabels != null) result.userLabels.addEntries(userLabels);
    return result;
  }

  MonitoredResourceMetadata._();

  factory MonitoredResourceMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MonitoredResourceMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MonitoredResourceMetadata',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOM<$1.Struct>(1, _omitFieldNames ? '' : 'systemLabels',
        subBuilder: $1.Struct.create)
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'userLabels',
        entryClassName: 'MonitoredResourceMetadata.UserLabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResourceMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MonitoredResourceMetadata copyWith(
          void Function(MonitoredResourceMetadata) updates) =>
      super.copyWith((message) => updates(message as MonitoredResourceMetadata))
          as MonitoredResourceMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata create() => MonitoredResourceMetadata._();
  @$core.override
  MonitoredResourceMetadata createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MonitoredResourceMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MonitoredResourceMetadata>(create);
  static MonitoredResourceMetadata? _defaultInstance;

  /// Output only. Values for predefined system metadata labels.
  /// System labels are a kind of metadata extracted by Google, including
  /// "machine_image", "vpc", "subnet_id",
  /// "security_group", "name", etc.
  /// System label values can be only strings, Boolean values, or a list of
  /// strings. For example:
  ///
  ///     { "name": "my-test-instance",
  ///       "security_group": ["a", "b", "c"],
  ///       "spot_instance": false }
  @$pb.TagNumber(1)
  $1.Struct get systemLabels => $_getN(0);
  @$pb.TagNumber(1)
  set systemLabels($1.Struct value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSystemLabels() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystemLabels() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Struct ensureSystemLabels() => $_ensure(0);

  /// Output only. A map of user-defined metadata labels.
  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get userLabels => $_getMap(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
