///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.api_label;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

import 'label.pbenum.dart';

export 'label.pbenum.dart';

class LabelDescriptor extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LabelDescriptor')
    ..aOS(1, 'key')
    ..e<LabelDescriptor_ValueType>(
        2,
        'valueType',
        PbFieldType.OE,
        LabelDescriptor_ValueType.STRING,
        LabelDescriptor_ValueType.valueOf,
        LabelDescriptor_ValueType.values)
    ..aOS(3, 'description')
    ..hasRequiredFields = false;

  LabelDescriptor() : super();
  LabelDescriptor.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  LabelDescriptor.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  LabelDescriptor clone() => new LabelDescriptor()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LabelDescriptor create() => new LabelDescriptor();
  static PbList<LabelDescriptor> createRepeated() =>
      new PbList<LabelDescriptor>();
  static LabelDescriptor getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyLabelDescriptor();
    return _defaultInstance;
  }

  static LabelDescriptor _defaultInstance;
  static void $checkItem(LabelDescriptor v) {
    if (v is! LabelDescriptor) checkItemFailed(v, 'LabelDescriptor');
  }

  String get key => $_getS(0, '');
  set key(String v) {
    $_setString(0, v);
  }

  bool hasKey() => $_has(0);
  void clearKey() => clearField(1);

  LabelDescriptor_ValueType get valueType => $_getN(1);
  set valueType(LabelDescriptor_ValueType v) {
    setField(2, v);
  }

  bool hasValueType() => $_has(1);
  void clearValueType() => clearField(2);

  String get description => $_getS(2, '');
  set description(String v) {
    $_setString(2, v);
  }

  bool hasDescription() => $_has(2);
  void clearDescription() => clearField(3);
}

class _ReadonlyLabelDescriptor extends LabelDescriptor
    with ReadonlyMessageMixin {}
