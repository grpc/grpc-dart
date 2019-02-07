///
//  Generated code. Do not modify.
//  source: messages.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class PayloadType extends $pb.ProtobufEnum {
  static const PayloadType COMPRESSABLE = const PayloadType._(0, 'COMPRESSABLE');

  static const List<PayloadType> values = const <PayloadType> [
    COMPRESSABLE,
  ];

  static final Map<int, PayloadType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PayloadType valueOf(int value) => _byValue[value];
  static void $checkItem(PayloadType v) {
    if (v is! PayloadType) $pb.checkItemFailed(v, 'PayloadType');
  }

  const PayloadType._(int v, String n) : super(v, n);
}

