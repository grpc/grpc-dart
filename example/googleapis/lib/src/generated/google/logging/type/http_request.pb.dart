///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library google.logging.type_http_request;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/duration.pb.dart' as $google$protobuf;

class HttpRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpRequest')
    ..aOS(1, 'requestMethod')
    ..aOS(2, 'requestUrl')
    ..aInt64(3, 'requestSize')
    ..a<int>(4, 'status', PbFieldType.O3)
    ..aInt64(5, 'responseSize')
    ..aOS(6, 'userAgent')
    ..aOS(7, 'remoteIp')
    ..aOS(8, 'referer')
    ..aOB(9, 'cacheHit')
    ..aOB(10, 'cacheValidatedWithOriginServer')
    ..aOB(11, 'cacheLookup')
    ..aInt64(12, 'cacheFillBytes')
    ..aOS(13, 'serverIp')
    ..a<$google$protobuf.Duration>(14, 'latency', PbFieldType.OM,
        $google$protobuf.Duration.getDefault, $google$protobuf.Duration.create)
    ..aOS(15, 'protocol')
    ..hasRequiredFields = false;

  HttpRequest() : super();
  HttpRequest.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  HttpRequest.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  HttpRequest clone() => new HttpRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpRequest create() => new HttpRequest();
  static PbList<HttpRequest> createRepeated() => new PbList<HttpRequest>();
  static HttpRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpRequest();
    return _defaultInstance;
  }

  static HttpRequest _defaultInstance;
  static void $checkItem(HttpRequest v) {
    if (v is! HttpRequest) checkItemFailed(v, 'HttpRequest');
  }

  String get requestMethod => $_getS(0, '');
  set requestMethod(String v) {
    $_setString(0, v);
  }

  bool hasRequestMethod() => $_has(0);
  void clearRequestMethod() => clearField(1);

  String get requestUrl => $_getS(1, '');
  set requestUrl(String v) {
    $_setString(1, v);
  }

  bool hasRequestUrl() => $_has(1);
  void clearRequestUrl() => clearField(2);

  Int64 get requestSize => $_getI64(2);
  set requestSize(Int64 v) {
    $_setInt64(2, v);
  }

  bool hasRequestSize() => $_has(2);
  void clearRequestSize() => clearField(3);

  int get status => $_get(3, 0);
  set status(int v) {
    $_setUnsignedInt32(3, v);
  }

  bool hasStatus() => $_has(3);
  void clearStatus() => clearField(4);

  Int64 get responseSize => $_getI64(4);
  set responseSize(Int64 v) {
    $_setInt64(4, v);
  }

  bool hasResponseSize() => $_has(4);
  void clearResponseSize() => clearField(5);

  String get userAgent => $_getS(5, '');
  set userAgent(String v) {
    $_setString(5, v);
  }

  bool hasUserAgent() => $_has(5);
  void clearUserAgent() => clearField(6);

  String get remoteIp => $_getS(6, '');
  set remoteIp(String v) {
    $_setString(6, v);
  }

  bool hasRemoteIp() => $_has(6);
  void clearRemoteIp() => clearField(7);

  String get referer => $_getS(7, '');
  set referer(String v) {
    $_setString(7, v);
  }

  bool hasReferer() => $_has(7);
  void clearReferer() => clearField(8);

  bool get cacheHit => $_get(8, false);
  set cacheHit(bool v) {
    $_setBool(8, v);
  }

  bool hasCacheHit() => $_has(8);
  void clearCacheHit() => clearField(9);

  bool get cacheValidatedWithOriginServer => $_get(9, false);
  set cacheValidatedWithOriginServer(bool v) {
    $_setBool(9, v);
  }

  bool hasCacheValidatedWithOriginServer() => $_has(9);
  void clearCacheValidatedWithOriginServer() => clearField(10);

  bool get cacheLookup => $_get(10, false);
  set cacheLookup(bool v) {
    $_setBool(10, v);
  }

  bool hasCacheLookup() => $_has(10);
  void clearCacheLookup() => clearField(11);

  Int64 get cacheFillBytes => $_getI64(11);
  set cacheFillBytes(Int64 v) {
    $_setInt64(11, v);
  }

  bool hasCacheFillBytes() => $_has(11);
  void clearCacheFillBytes() => clearField(12);

  String get serverIp => $_getS(12, '');
  set serverIp(String v) {
    $_setString(12, v);
  }

  bool hasServerIp() => $_has(12);
  void clearServerIp() => clearField(13);

  $google$protobuf.Duration get latency => $_getN(13);
  set latency($google$protobuf.Duration v) {
    setField(14, v);
  }

  bool hasLatency() => $_has(13);
  void clearLatency() => clearField(14);

  String get protocol => $_getS(14, '');
  set protocol(String v) {
    $_setString(14, v);
  }

  bool hasProtocol() => $_has(14);
  void clearProtocol() => clearField(15);
}

class _ReadonlyHttpRequest extends HttpRequest with ReadonlyMessageMixin {}
