// This is a generated file - do not edit.
//
// Generated from google/logging/v2/logging.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// An indicator of why entries were omitted.
class TailLogEntriesResponse_SuppressionInfo_Reason extends $pb.ProtobufEnum {
  /// Unexpected default.
  static const TailLogEntriesResponse_SuppressionInfo_Reason
      REASON_UNSPECIFIED = TailLogEntriesResponse_SuppressionInfo_Reason._(
          0, _omitEnumNames ? '' : 'REASON_UNSPECIFIED');

  /// Indicates suppression occurred due to relevant entries being
  /// received in excess of rate limits. For quotas and limits, see
  /// [Logging API quotas and
  /// limits](https://cloud.google.com/logging/quotas#api-limits).
  static const TailLogEntriesResponse_SuppressionInfo_Reason RATE_LIMIT =
      TailLogEntriesResponse_SuppressionInfo_Reason._(
          1, _omitEnumNames ? '' : 'RATE_LIMIT');

  /// Indicates suppression occurred due to the client not consuming
  /// responses quickly enough.
  static const TailLogEntriesResponse_SuppressionInfo_Reason NOT_CONSUMED =
      TailLogEntriesResponse_SuppressionInfo_Reason._(
          2, _omitEnumNames ? '' : 'NOT_CONSUMED');

  static const $core.List<TailLogEntriesResponse_SuppressionInfo_Reason>
      values = <TailLogEntriesResponse_SuppressionInfo_Reason>[
    REASON_UNSPECIFIED,
    RATE_LIMIT,
    NOT_CONSUMED,
  ];

  static final $core.List<TailLogEntriesResponse_SuppressionInfo_Reason?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TailLogEntriesResponse_SuppressionInfo_Reason? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TailLogEntriesResponse_SuppressionInfo_Reason._(
      super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
