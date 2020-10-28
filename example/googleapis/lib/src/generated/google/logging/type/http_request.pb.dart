///
//  Generated code. Do not modify.
//  source: google/logging/type/http_request.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $0;

class HttpRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HttpRequest',
      package: const $pb.PackageName('google.logging.type'),
      createEmptyInstance: create)
    ..aOS(1, 'requestMethod')
    ..aOS(2, 'requestUrl')
    ..aInt64(3, 'requestSize')
    ..a<$core.int>(4, 'status', $pb.PbFieldType.O3)
    ..aInt64(5, 'responseSize')
    ..aOS(6, 'userAgent')
    ..aOS(7, 'remoteIp')
    ..aOS(8, 'referer')
    ..aOB(9, 'cacheHit')
    ..aOB(10, 'cacheValidatedWithOriginServer')
    ..aOB(11, 'cacheLookup')
    ..aInt64(12, 'cacheFillBytes')
    ..aOS(13, 'serverIp')
    ..aOM<$0.Duration>(14, 'latency', subBuilder: $0.Duration.create)
    ..aOS(15, 'protocol')
    ..hasRequiredFields = false;

  HttpRequest._() : super();
  factory HttpRequest() => create();
  factory HttpRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory HttpRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  HttpRequest clone() => HttpRequest()..mergeFromMessage(this);
  HttpRequest copyWith(void Function(HttpRequest) updates) =>
      super.copyWith((message) => updates(message as HttpRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HttpRequest create() => HttpRequest._();
  HttpRequest createEmptyInstance() => create();
  static $pb.PbList<HttpRequest> createRepeated() => $pb.PbList<HttpRequest>();
  @$core.pragma('dart2js:noInline')
  static HttpRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HttpRequest>(create);
  static HttpRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestMethod => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestMethod($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequestMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get requestUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRequestUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestUrl() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get requestSize => $_getI64(2);
  @$pb.TagNumber(3)
  set requestSize($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequestSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get status => $_getIZ(3);
  @$pb.TagNumber(4)
  set status($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get responseSize => $_getI64(4);
  @$pb.TagNumber(5)
  set responseSize($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasResponseSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponseSize() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get userAgent => $_getSZ(5);
  @$pb.TagNumber(6)
  set userAgent($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUserAgent() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserAgent() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get remoteIp => $_getSZ(6);
  @$pb.TagNumber(7)
  set remoteIp($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasRemoteIp() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemoteIp() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get referer => $_getSZ(7);
  @$pb.TagNumber(8)
  set referer($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasReferer() => $_has(7);
  @$pb.TagNumber(8)
  void clearReferer() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get cacheHit => $_getBF(8);
  @$pb.TagNumber(9)
  set cacheHit($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCacheHit() => $_has(8);
  @$pb.TagNumber(9)
  void clearCacheHit() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get cacheValidatedWithOriginServer => $_getBF(9);
  @$pb.TagNumber(10)
  set cacheValidatedWithOriginServer($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasCacheValidatedWithOriginServer() => $_has(9);
  @$pb.TagNumber(10)
  void clearCacheValidatedWithOriginServer() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get cacheLookup => $_getBF(10);
  @$pb.TagNumber(11)
  set cacheLookup($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasCacheLookup() => $_has(10);
  @$pb.TagNumber(11)
  void clearCacheLookup() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get cacheFillBytes => $_getI64(11);
  @$pb.TagNumber(12)
  set cacheFillBytes($fixnum.Int64 v) {
    $_setInt64(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasCacheFillBytes() => $_has(11);
  @$pb.TagNumber(12)
  void clearCacheFillBytes() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get serverIp => $_getSZ(12);
  @$pb.TagNumber(13)
  set serverIp($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasServerIp() => $_has(12);
  @$pb.TagNumber(13)
  void clearServerIp() => clearField(13);

  @$pb.TagNumber(14)
  $0.Duration get latency => $_getN(13);
  @$pb.TagNumber(14)
  set latency($0.Duration v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasLatency() => $_has(13);
  @$pb.TagNumber(14)
  void clearLatency() => clearField(14);
  @$pb.TagNumber(14)
  $0.Duration ensureLatency() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.String get protocol => $_getSZ(14);
  @$pb.TagNumber(15)
  set protocol($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasProtocol() => $_has(14);
  @$pb.TagNumber(15)
  void clearProtocol() => clearField(15);
}
