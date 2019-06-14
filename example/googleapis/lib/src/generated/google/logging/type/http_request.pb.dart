///
//  Generated code. Do not modify.
//  source: google/logging/type/http_request.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $0;

class HttpRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HttpRequest',
      package: const $pb.PackageName('google.logging.type'))
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
    ..a<$0.Duration>(14, 'latency', $pb.PbFieldType.OM, $0.Duration.getDefault,
        $0.Duration.create)
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
  static HttpRequest getDefault() => _defaultInstance ??= create()..freeze();
  static HttpRequest _defaultInstance;

  $core.String get requestMethod => $_getS(0, '');
  set requestMethod($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasRequestMethod() => $_has(0);
  void clearRequestMethod() => clearField(1);

  $core.String get requestUrl => $_getS(1, '');
  set requestUrl($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasRequestUrl() => $_has(1);
  void clearRequestUrl() => clearField(2);

  Int64 get requestSize => $_getI64(2);
  set requestSize(Int64 v) {
    $_setInt64(2, v);
  }

  $core.bool hasRequestSize() => $_has(2);
  void clearRequestSize() => clearField(3);

  $core.int get status => $_get(3, 0);
  set status($core.int v) {
    $_setSignedInt32(3, v);
  }

  $core.bool hasStatus() => $_has(3);
  void clearStatus() => clearField(4);

  Int64 get responseSize => $_getI64(4);
  set responseSize(Int64 v) {
    $_setInt64(4, v);
  }

  $core.bool hasResponseSize() => $_has(4);
  void clearResponseSize() => clearField(5);

  $core.String get userAgent => $_getS(5, '');
  set userAgent($core.String v) {
    $_setString(5, v);
  }

  $core.bool hasUserAgent() => $_has(5);
  void clearUserAgent() => clearField(6);

  $core.String get remoteIp => $_getS(6, '');
  set remoteIp($core.String v) {
    $_setString(6, v);
  }

  $core.bool hasRemoteIp() => $_has(6);
  void clearRemoteIp() => clearField(7);

  $core.String get referer => $_getS(7, '');
  set referer($core.String v) {
    $_setString(7, v);
  }

  $core.bool hasReferer() => $_has(7);
  void clearReferer() => clearField(8);

  $core.bool get cacheHit => $_get(8, false);
  set cacheHit($core.bool v) {
    $_setBool(8, v);
  }

  $core.bool hasCacheHit() => $_has(8);
  void clearCacheHit() => clearField(9);

  $core.bool get cacheValidatedWithOriginServer => $_get(9, false);
  set cacheValidatedWithOriginServer($core.bool v) {
    $_setBool(9, v);
  }

  $core.bool hasCacheValidatedWithOriginServer() => $_has(9);
  void clearCacheValidatedWithOriginServer() => clearField(10);

  $core.bool get cacheLookup => $_get(10, false);
  set cacheLookup($core.bool v) {
    $_setBool(10, v);
  }

  $core.bool hasCacheLookup() => $_has(10);
  void clearCacheLookup() => clearField(11);

  Int64 get cacheFillBytes => $_getI64(11);
  set cacheFillBytes(Int64 v) {
    $_setInt64(11, v);
  }

  $core.bool hasCacheFillBytes() => $_has(11);
  void clearCacheFillBytes() => clearField(12);

  $core.String get serverIp => $_getS(12, '');
  set serverIp($core.String v) {
    $_setString(12, v);
  }

  $core.bool hasServerIp() => $_has(12);
  void clearServerIp() => clearField(13);

  $0.Duration get latency => $_getN(13);
  set latency($0.Duration v) {
    setField(14, v);
  }

  $core.bool hasLatency() => $_has(13);
  void clearLatency() => clearField(14);

  $core.String get protocol => $_getS(14, '');
  set protocol($core.String v) {
    $_setString(14, v);
  }

  $core.bool hasProtocol() => $_has(14);
  void clearProtocol() => clearField(15);
}
