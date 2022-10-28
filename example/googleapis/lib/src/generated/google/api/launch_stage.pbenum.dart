///
//  Generated code. Do not modify.
//  source: google/api/launch_stage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class LaunchStage extends $pb.ProtobufEnum {
  static const LaunchStage LAUNCH_STAGE_UNSPECIFIED = LaunchStage._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'LAUNCH_STAGE_UNSPECIFIED');
  static const LaunchStage UNIMPLEMENTED = LaunchStage._(
      6,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'UNIMPLEMENTED');
  static const LaunchStage PRELAUNCH = LaunchStage._(
      7,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'PRELAUNCH');
  static const LaunchStage EARLY_ACCESS = LaunchStage._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'EARLY_ACCESS');
  static const LaunchStage ALPHA = LaunchStage._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'ALPHA');
  static const LaunchStage BETA = LaunchStage._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'BETA');
  static const LaunchStage GA = LaunchStage._(4,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GA');
  static const LaunchStage DEPRECATED = LaunchStage._(
      5,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'DEPRECATED');

  static const $core.List<LaunchStage> values = <LaunchStage>[
    LAUNCH_STAGE_UNSPECIFIED,
    UNIMPLEMENTED,
    PRELAUNCH,
    EARLY_ACCESS,
    ALPHA,
    BETA,
    GA,
    DEPRECATED,
  ];

  static final $core.Map<$core.int, LaunchStage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LaunchStage? valueOf($core.int value) => _byValue[value];

  const LaunchStage._($core.int v, $core.String n) : super(v, n);
}
