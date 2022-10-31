///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class PayloadType extends $pb.ProtobufEnum {
  static const PayloadType COMPRESSABLE = PayloadType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'COMPRESSABLE');

  static const $core.List<PayloadType> values = <PayloadType>[
    COMPRESSABLE,
  ];

  static final $core.Map<$core.int, PayloadType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PayloadType? valueOf($core.int value) => _byValue[value];

  const PayloadType._($core.int v, $core.String n) : super(v, n);
}
