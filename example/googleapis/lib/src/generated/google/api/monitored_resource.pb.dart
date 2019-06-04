///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.api_monitored_resource;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'label.pb.dart';

class MonitoredResourceDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('MonitoredResourceDescriptor')
    ..aOS(1, 'type')
    ..aOS(2, 'displayName')
    ..aOS(3, 'description')
    ..pp<LabelDescriptor>(4, 'labels', PbFieldType.PM,
        LabelDescriptor.$checkItem, LabelDescriptor.create)
    ..aOS(5, 'name')
    ..hasRequiredFields = false;

  MonitoredResourceDescriptor() : super();
  MonitoredResourceDescriptor.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  MonitoredResourceDescriptor.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  MonitoredResourceDescriptor clone() =>
      MonitoredResourceDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResourceDescriptor create() => MonitoredResourceDescriptor();
  static PbList<MonitoredResourceDescriptor> createRepeated() =>
      PbList<MonitoredResourceDescriptor>();
  static MonitoredResourceDescriptor getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyMonitoredResourceDescriptor();
    return _defaultInstance;
  }

  static MonitoredResourceDescriptor _defaultInstance;
  static void $checkItem(MonitoredResourceDescriptor v) {
    if (v is! MonitoredResourceDescriptor)
      checkItemFailed(v, 'MonitoredResourceDescriptor');
  }

  String get type => $_getS(0, '');
  set type(String v) {
    $_setString(0, v);
  }

  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  String get displayName => $_getS(1, '');
  set displayName(String v) {
    $_setString(1, v);
  }

  bool hasDisplayName() => $_has(1);
  void clearDisplayName() => clearField(2);

  String get description => $_getS(2, '');
  set description(String v) {
    $_setString(2, v);
  }

  bool hasDescription() => $_has(2);
  void clearDescription() => clearField(3);

  List<LabelDescriptor> get labels => $_getList(3);

  String get name => $_getS(4, '');
  set name(String v) {
    $_setString(4, v);
  }

  bool hasName() => $_has(4);
  void clearName() => clearField(5);
}

class _ReadonlyMonitoredResourceDescriptor extends MonitoredResourceDescriptor
    with ReadonlyMessageMixin {}

class MonitoredResource_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('MonitoredResource_LabelsEntry')
    ..aOS(1, 'key')
    ..aOS(2, 'value')
    ..hasRequiredFields = false;

  MonitoredResource_LabelsEntry() : super();
  MonitoredResource_LabelsEntry.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  MonitoredResource_LabelsEntry.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  MonitoredResource_LabelsEntry clone() =>
      MonitoredResource_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResource_LabelsEntry create() =>
      MonitoredResource_LabelsEntry();
  static PbList<MonitoredResource_LabelsEntry> createRepeated() =>
      PbList<MonitoredResource_LabelsEntry>();
  static MonitoredResource_LabelsEntry getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyMonitoredResource_LabelsEntry();
    return _defaultInstance;
  }

  static MonitoredResource_LabelsEntry _defaultInstance;
  static void $checkItem(MonitoredResource_LabelsEntry v) {
    if (v is! MonitoredResource_LabelsEntry)
      checkItemFailed(v, 'MonitoredResource_LabelsEntry');
  }

  String get key => $_getS(0, '');
  set key(String v) {
    $_setString(0, v);
  }

  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  String get value => $_getS(1, '');
  set value(String v) {
    $_setString(1, v);
  }

  bool hasValue() => $_has(1);
  void clearValue() => clearField(2);
}

class _ReadonlyMonitoredResource_LabelsEntry
    extends MonitoredResource_LabelsEntry with ReadonlyMessageMixin {}

class MonitoredResource extends GeneratedMessage {
  static final BuilderInfo _i = BuilderInfo('MonitoredResource')
    ..aOS(1, 'type')
    ..pp<MonitoredResource_LabelsEntry>(
        2,
        'labels',
        PbFieldType.PM,
        MonitoredResource_LabelsEntry.$checkItem,
        MonitoredResource_LabelsEntry.create)
    ..hasRequiredFields = false;

  MonitoredResource() : super();
  MonitoredResource.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  MonitoredResource.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  MonitoredResource clone() => MonitoredResource()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MonitoredResource create() => MonitoredResource();
  static PbList<MonitoredResource> createRepeated() =>
      PbList<MonitoredResource>();
  static MonitoredResource getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = _ReadonlyMonitoredResource();
    return _defaultInstance;
  }

  static MonitoredResource _defaultInstance;
  static void $checkItem(MonitoredResource v) {
    if (v is! MonitoredResource) checkItemFailed(v, 'MonitoredResource');
  }

  String get type => $_getS(0, '');
  set type(String v) {
    $_setString(0, v);
  }

  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  List<MonitoredResource_LabelsEntry> get labels => $_getList(1);
}

class _ReadonlyMonitoredResource extends MonitoredResource
    with ReadonlyMessageMixin {}
