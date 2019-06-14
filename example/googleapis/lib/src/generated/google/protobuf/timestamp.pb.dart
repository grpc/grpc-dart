///
//  Generated code. Do not modify.
//  source: google/protobuf/timestamp.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core show DateTime, Duration;

class Timestamp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Timestamp',
      package: const $pb.PackageName('google.protobuf'))
    ..aInt64(1, 'seconds')
    ..a<$core.int>(2, 'nanos', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  Timestamp._() : super();
  factory Timestamp() => create();
  factory Timestamp.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Timestamp.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Timestamp clone() => Timestamp()..mergeFromMessage(this);
  Timestamp copyWith(void Function(Timestamp) updates) =>
      super.copyWith((message) => updates(message as Timestamp));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Timestamp create() => Timestamp._();
  Timestamp createEmptyInstance() => create();
  static $pb.PbList<Timestamp> createRepeated() => $pb.PbList<Timestamp>();
  static Timestamp getDefault() => _defaultInstance ??= create()..freeze();
  static Timestamp _defaultInstance;

  Int64 get seconds => $_getI64(0);
  set seconds(Int64 v) {
    $_setInt64(0, v);
  }

  $core.bool hasSeconds() => $_has(0);
  void clearSeconds() => clearField(1);

  $core.int get nanos => $_get(1, 0);
  set nanos($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasNanos() => $_has(1);
  void clearNanos() => clearField(2);

  /// Converts an instance to [DateTime].
  ///
  /// The result is in UTC time zone and has microsecond precision, as
  /// [DateTime] does not support nanosecond precision.
  $core.DateTime toDateTime() => $core.DateTime.fromMicrosecondsSinceEpoch(
      seconds.toInt() * $core.Duration.microsecondsPerSecond + nanos ~/ 1000,
      isUtc: true);

  /// Creates a new instance from [dateTime].
  ///
  /// Time zone information will not be preserved.
  static Timestamp fromDateTime($core.DateTime dateTime) {
    $core.int micros = dateTime.microsecondsSinceEpoch;
    return Timestamp()
      ..seconds = Int64(micros ~/ $core.Duration.microsecondsPerSecond)
      ..nanos = (micros % $core.Duration.microsecondsPerSecond).toInt() * 1000;
  }
}
