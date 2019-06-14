///
//  Generated code. Do not modify.
//  source: google/api/launch_stage.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class LaunchStage extends $pb.ProtobufEnum {
  static const LaunchStage LAUNCH_STAGE_UNSPECIFIED =
      LaunchStage._(0, 'LAUNCH_STAGE_UNSPECIFIED');
  static const LaunchStage EARLY_ACCESS = LaunchStage._(1, 'EARLY_ACCESS');
  static const LaunchStage ALPHA = LaunchStage._(2, 'ALPHA');
  static const LaunchStage BETA = LaunchStage._(3, 'BETA');
  static const LaunchStage GA = LaunchStage._(4, 'GA');
  static const LaunchStage DEPRECATED = LaunchStage._(5, 'DEPRECATED');

  static const $core.List<LaunchStage> values = <LaunchStage>[
    LAUNCH_STAGE_UNSPECIFIED,
    EARLY_ACCESS,
    ALPHA,
    BETA,
    GA,
    DEPRECATED,
  ];

  static final $core.Map<$core.int, LaunchStage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LaunchStage valueOf($core.int value) => _byValue[value];

  const LaunchStage._($core.int v, $core.String n) : super(v, n);
}
