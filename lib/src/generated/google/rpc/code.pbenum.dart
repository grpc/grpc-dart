///
//  Generated code. Do not modify.
//  source: google/rpc/code.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Code extends $pb.ProtobufEnum {
  static const Code OK = Code._(0, 'OK');
  static const Code CANCELLED = Code._(1, 'CANCELLED');
  static const Code UNKNOWN = Code._(2, 'UNKNOWN');
  static const Code INVALID_ARGUMENT = Code._(3, 'INVALID_ARGUMENT');
  static const Code DEADLINE_EXCEEDED = Code._(4, 'DEADLINE_EXCEEDED');
  static const Code NOT_FOUND = Code._(5, 'NOT_FOUND');
  static const Code ALREADY_EXISTS = Code._(6, 'ALREADY_EXISTS');
  static const Code PERMISSION_DENIED = Code._(7, 'PERMISSION_DENIED');
  static const Code UNAUTHENTICATED = Code._(16, 'UNAUTHENTICATED');
  static const Code RESOURCE_EXHAUSTED = Code._(8, 'RESOURCE_EXHAUSTED');
  static const Code FAILED_PRECONDITION = Code._(9, 'FAILED_PRECONDITION');
  static const Code ABORTED = Code._(10, 'ABORTED');
  static const Code OUT_OF_RANGE = Code._(11, 'OUT_OF_RANGE');
  static const Code UNIMPLEMENTED = Code._(12, 'UNIMPLEMENTED');
  static const Code INTERNAL = Code._(13, 'INTERNAL');
  static const Code UNAVAILABLE = Code._(14, 'UNAVAILABLE');
  static const Code DATA_LOSS = Code._(15, 'DATA_LOSS');

  static const $core.List<Code> values = <Code>[
    OK,
    CANCELLED,
    UNKNOWN,
    INVALID_ARGUMENT,
    DEADLINE_EXCEEDED,
    NOT_FOUND,
    ALREADY_EXISTS,
    PERMISSION_DENIED,
    UNAUTHENTICATED,
    RESOURCE_EXHAUSTED,
    FAILED_PRECONDITION,
    ABORTED,
    OUT_OF_RANGE,
    UNIMPLEMENTED,
    INTERNAL,
    UNAVAILABLE,
    DATA_LOSS,
  ];

  static final $core.Map<$core.int, Code> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Code valueOf($core.int value) => _byValue[value];

  const Code._($core.int v, $core.String n) : super(v, n);
}
