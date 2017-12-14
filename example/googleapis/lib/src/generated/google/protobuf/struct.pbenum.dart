///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.protobuf_struct_pbenum;

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart';

class NullValue extends ProtobufEnum {
  static const NullValue NULL_VALUE = const NullValue._(0, 'NULL_VALUE');

  static const List<NullValue> values = const <NullValue>[
    NULL_VALUE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static NullValue valueOf(int value) => _byValue[value] as NullValue;
  static void $checkItem(NullValue v) {
    if (v is! NullValue) checkItemFailed(v, 'NullValue');
  }

  const NullValue._(int v, String n) : super(v, n);
}
