///
//  Generated code. Do not modify.
//  source: google/protobuf/any.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

class Any extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Any', package: const $pb.PackageName('google.protobuf'))
        ..aOS(1, 'typeUrl')
        ..a<$core.List<$core.int>>(2, 'value', $pb.PbFieldType.OY)
        ..hasRequiredFields = false;

  Any._() : super();
  factory Any() => create();
  factory Any.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Any.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Any clone() => Any()..mergeFromMessage(this);
  Any copyWith(void Function(Any) updates) =>
      super.copyWith((message) => updates(message as Any));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Any create() => Any._();
  Any createEmptyInstance() => create();
  static $pb.PbList<Any> createRepeated() => $pb.PbList<Any>();
  static Any getDefault() => _defaultInstance ??= create()..freeze();
  static Any _defaultInstance;

  $core.String get typeUrl => $_getS(0, '');
  set typeUrl($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasTypeUrl() => $_has(0);
  void clearTypeUrl() => clearField(1);

  $core.List<$core.int> get value => $_getN(1);
  set value($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  $core.bool hasValue() => $_has(1);
  void clearValue() => clearField(2);

  /// Unpacks the message in [value] into [instance].
  ///
  /// Throws a [InvalidProtocolBufferException] if [typeUrl] does not correspond
  /// to the type of [instance].
  ///
  /// A typical usage would be `any.unpackInto(Message())`.
  ///
  /// Returns [instance].
  T unpackInto<T extends $pb.GeneratedMessage>(T instance,
      {$pb.ExtensionRegistry extensionRegistry = $pb.ExtensionRegistry.EMPTY}) {
    $pb.unpackIntoHelper(value, instance, typeUrl,
        extensionRegistry: extensionRegistry);
    return instance;
  }

  /// Returns `true` if the encoded message matches the type of [instance].
  ///
  /// Can be used with a default instance:
  /// `any.canUnpackInto(Message.getDefault())`
  $core.bool canUnpackInto($pb.GeneratedMessage instance) {
    return $pb.canUnpackIntoHelper(instance, typeUrl);
  }

  /// Creates a new [Any] encoding [message].
  ///
  /// The [typeUrl] will be [typeUrlPrefix]/`fullName` where `fullName` is
  /// the fully qualified name of the type of [message].
  static Any pack($pb.GeneratedMessage message,
      {$core.String typeUrlPrefix = 'type.googleapis.com'}) {
    return Any()
      ..value = message.writeToBuffer()
      ..typeUrl = '${typeUrlPrefix}/${message.info_.qualifiedMessageName}';
  }
}
