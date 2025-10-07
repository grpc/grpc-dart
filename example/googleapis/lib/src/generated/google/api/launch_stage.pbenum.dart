// This is a generated file - do not edit.
//
// Generated from google/api/launch_stage.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The launch stage as defined by [Google Cloud Platform
/// Launch Stages](https://cloud.google.com/terms/launch-stages).
class LaunchStage extends $pb.ProtobufEnum {
  /// Do not use this default value.
  static const LaunchStage LAUNCH_STAGE_UNSPECIFIED =
      LaunchStage._(0, _omitEnumNames ? '' : 'LAUNCH_STAGE_UNSPECIFIED');

  /// The feature is not yet implemented. Users can not use it.
  static const LaunchStage UNIMPLEMENTED =
      LaunchStage._(6, _omitEnumNames ? '' : 'UNIMPLEMENTED');

  /// Prelaunch features are hidden from users and are only visible internally.
  static const LaunchStage PRELAUNCH =
      LaunchStage._(7, _omitEnumNames ? '' : 'PRELAUNCH');

  /// Early Access features are limited to a closed group of testers. To use
  /// these features, you must sign up in advance and sign a Trusted Tester
  /// agreement (which includes confidentiality provisions). These features may
  /// be unstable, changed in backward-incompatible ways, and are not
  /// guaranteed to be released.
  static const LaunchStage EARLY_ACCESS =
      LaunchStage._(1, _omitEnumNames ? '' : 'EARLY_ACCESS');

  /// Alpha is a limited availability test for releases before they are cleared
  /// for widespread use. By Alpha, all significant design issues are resolved
  /// and we are in the process of verifying functionality. Alpha customers
  /// need to apply for access, agree to applicable terms, and have their
  /// projects allowlisted. Alpha releases don't have to be feature complete,
  /// no SLAs are provided, and there are no technical support obligations, but
  /// they will be far enough along that customers can actually use them in
  /// test environments or for limited-use tests -- just like they would in
  /// normal production cases.
  static const LaunchStage ALPHA =
      LaunchStage._(2, _omitEnumNames ? '' : 'ALPHA');

  /// Beta is the point at which we are ready to open a release for any
  /// customer to use. There are no SLA or technical support obligations in a
  /// Beta release. Products will be complete from a feature perspective, but
  /// may have some open outstanding issues. Beta releases are suitable for
  /// limited production use cases.
  static const LaunchStage BETA =
      LaunchStage._(3, _omitEnumNames ? '' : 'BETA');

  /// GA features are open to all developers and are considered stable and
  /// fully qualified for production use.
  static const LaunchStage GA = LaunchStage._(4, _omitEnumNames ? '' : 'GA');

  /// Deprecated features are scheduled to be shut down and removed. For more
  /// information, see the "Deprecation Policy" section of our [Terms of
  /// Service](https://cloud.google.com/terms/)
  /// and the [Google Cloud Platform Subject to the Deprecation
  /// Policy](https://cloud.google.com/terms/deprecation) documentation.
  static const LaunchStage DEPRECATED =
      LaunchStage._(5, _omitEnumNames ? '' : 'DEPRECATED');

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

  static final $core.List<LaunchStage?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static LaunchStage? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LaunchStage._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
