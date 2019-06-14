///
//  Generated code. Do not modify.
//  source: messages.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class PayloadType extends $pb.ProtobufEnum {
  static const PayloadType COMPRESSABLE = PayloadType._(0, 'COMPRESSABLE');

  static const $core.List<PayloadType> values = <PayloadType>[
    COMPRESSABLE,
  ];

  static final $core.Map<$core.int, PayloadType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static PayloadType valueOf($core.int value) => _byValue[value];

  const PayloadType._($core.int v, $core.String n) : super(v, n);
}
