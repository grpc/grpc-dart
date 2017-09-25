///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library grpc.testing_messages_pbenum;

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart';

class PayloadType extends ProtobufEnum {
  static const PayloadType COMPRESSABLE =
      const PayloadType._(0, 'COMPRESSABLE');

  static const List<PayloadType> values = const <PayloadType>[
    COMPRESSABLE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static PayloadType valueOf(int value) => _byValue[value] as PayloadType;
  static void $checkItem(PayloadType v) {
    if (v is! PayloadType) checkItemFailed(v, 'PayloadType');
  }

  const PayloadType._(int v, String n) : super(v, n);
}
