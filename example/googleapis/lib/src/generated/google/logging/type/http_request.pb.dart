// This is a generated file - do not edit.
//
// Generated from google/logging/type/http_request.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// A common proto for logging HTTP requests. Only contains semantics
/// defined by the HTTP specification. Product-specific logging
/// information MUST be defined in a separate message.
class HttpRequest extends $pb.GeneratedMessage {
  factory HttpRequest({
    $core.String? requestMethod,
    $core.String? requestUrl,
    $fixnum.Int64? requestSize,
    $core.int? status,
    $fixnum.Int64? responseSize,
    $core.String? userAgent,
    $core.String? remoteIp,
    $core.String? referer,
    $core.bool? cacheHit,
    $core.bool? cacheValidatedWithOriginServer,
    $core.bool? cacheLookup,
    $fixnum.Int64? cacheFillBytes,
    $core.String? serverIp,
    $0.Duration? latency,
    $core.String? protocol,
  }) {
    final result = create();
    if (requestMethod != null) result.requestMethod = requestMethod;
    if (requestUrl != null) result.requestUrl = requestUrl;
    if (requestSize != null) result.requestSize = requestSize;
    if (status != null) result.status = status;
    if (responseSize != null) result.responseSize = responseSize;
    if (userAgent != null) result.userAgent = userAgent;
    if (remoteIp != null) result.remoteIp = remoteIp;
    if (referer != null) result.referer = referer;
    if (cacheHit != null) result.cacheHit = cacheHit;
    if (cacheValidatedWithOriginServer != null)
      result.cacheValidatedWithOriginServer = cacheValidatedWithOriginServer;
    if (cacheLookup != null) result.cacheLookup = cacheLookup;
    if (cacheFillBytes != null) result.cacheFillBytes = cacheFillBytes;
    if (serverIp != null) result.serverIp = serverIp;
    if (latency != null) result.latency = latency;
    if (protocol != null) result.protocol = protocol;
    return result;
  }

  HttpRequest._();

  factory HttpRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HttpRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HttpRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.type'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestMethod')
    ..aOS(2, _omitFieldNames ? '' : 'requestUrl')
    ..aInt64(3, _omitFieldNames ? '' : 'requestSize')
    ..aI(4, _omitFieldNames ? '' : 'status')
    ..aInt64(5, _omitFieldNames ? '' : 'responseSize')
    ..aOS(6, _omitFieldNames ? '' : 'userAgent')
    ..aOS(7, _omitFieldNames ? '' : 'remoteIp')
    ..aOS(8, _omitFieldNames ? '' : 'referer')
    ..aOB(9, _omitFieldNames ? '' : 'cacheHit')
    ..aOB(10, _omitFieldNames ? '' : 'cacheValidatedWithOriginServer')
    ..aOB(11, _omitFieldNames ? '' : 'cacheLookup')
    ..aInt64(12, _omitFieldNames ? '' : 'cacheFillBytes')
    ..aOS(13, _omitFieldNames ? '' : 'serverIp')
    ..aOM<$0.Duration>(14, _omitFieldNames ? '' : 'latency',
        subBuilder: $0.Duration.create)
    ..aOS(15, _omitFieldNames ? '' : 'protocol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HttpRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HttpRequest copyWith(void Function(HttpRequest) updates) =>
      super.copyWith((message) => updates(message as HttpRequest))
          as HttpRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HttpRequest create() => HttpRequest._();
  @$core.override
  HttpRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HttpRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HttpRequest>(create);
  static HttpRequest? _defaultInstance;

  /// The request method. Examples: `"GET"`, `"HEAD"`, `"PUT"`, `"POST"`.
  @$pb.TagNumber(1)
  $core.String get requestMethod => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestMethod($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestMethod() => $_clearField(1);

  /// The scheme (http, https), the host name, the path and the query
  /// portion of the URL that was requested.
  /// Example: `"http://example.com/some/info?color=red"`.
  @$pb.TagNumber(2)
  $core.String get requestUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequestUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestUrl() => $_clearField(2);

  /// The size of the HTTP request message in bytes, including the request
  /// headers and the request body.
  @$pb.TagNumber(3)
  $fixnum.Int64 get requestSize => $_getI64(2);
  @$pb.TagNumber(3)
  set requestSize($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestSize() => $_clearField(3);

  /// The response code indicating the status of response.
  /// Examples: 200, 404.
  @$pb.TagNumber(4)
  $core.int get status => $_getIZ(3);
  @$pb.TagNumber(4)
  set status($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  /// The size of the HTTP response message sent back to the client, in bytes,
  /// including the response headers and the response body.
  @$pb.TagNumber(5)
  $fixnum.Int64 get responseSize => $_getI64(4);
  @$pb.TagNumber(5)
  set responseSize($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasResponseSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponseSize() => $_clearField(5);

  /// The user agent sent by the client. Example:
  /// `"Mozilla/4.0 (compatible; MSIE 6.0; Windows 98; Q312461; .NET
  /// CLR 1.0.3705)"`.
  @$pb.TagNumber(6)
  $core.String get userAgent => $_getSZ(5);
  @$pb.TagNumber(6)
  set userAgent($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUserAgent() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserAgent() => $_clearField(6);

  /// The IP address (IPv4 or IPv6) of the client that issued the HTTP
  /// request. This field can include port information. Examples:
  /// `"192.168.1.1"`, `"10.0.0.1:80"`, `"FE80::0202:B3FF:FE1E:8329"`.
  @$pb.TagNumber(7)
  $core.String get remoteIp => $_getSZ(6);
  @$pb.TagNumber(7)
  set remoteIp($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRemoteIp() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemoteIp() => $_clearField(7);

  /// The referer URL of the request, as defined in
  /// [HTTP/1.1 Header Field
  /// Definitions](https://datatracker.ietf.org/doc/html/rfc2616#section-14.36).
  @$pb.TagNumber(8)
  $core.String get referer => $_getSZ(7);
  @$pb.TagNumber(8)
  set referer($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReferer() => $_has(7);
  @$pb.TagNumber(8)
  void clearReferer() => $_clearField(8);

  /// Whether or not an entity was served from cache
  /// (with or without validation).
  @$pb.TagNumber(9)
  $core.bool get cacheHit => $_getBF(8);
  @$pb.TagNumber(9)
  set cacheHit($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCacheHit() => $_has(8);
  @$pb.TagNumber(9)
  void clearCacheHit() => $_clearField(9);

  /// Whether or not the response was validated with the origin server before
  /// being served from cache. This field is only meaningful if `cache_hit` is
  /// True.
  @$pb.TagNumber(10)
  $core.bool get cacheValidatedWithOriginServer => $_getBF(9);
  @$pb.TagNumber(10)
  set cacheValidatedWithOriginServer($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCacheValidatedWithOriginServer() => $_has(9);
  @$pb.TagNumber(10)
  void clearCacheValidatedWithOriginServer() => $_clearField(10);

  /// Whether or not a cache lookup was attempted.
  @$pb.TagNumber(11)
  $core.bool get cacheLookup => $_getBF(10);
  @$pb.TagNumber(11)
  set cacheLookup($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCacheLookup() => $_has(10);
  @$pb.TagNumber(11)
  void clearCacheLookup() => $_clearField(11);

  /// The number of HTTP response bytes inserted into cache. Set only when a
  /// cache fill was attempted.
  @$pb.TagNumber(12)
  $fixnum.Int64 get cacheFillBytes => $_getI64(11);
  @$pb.TagNumber(12)
  set cacheFillBytes($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCacheFillBytes() => $_has(11);
  @$pb.TagNumber(12)
  void clearCacheFillBytes() => $_clearField(12);

  /// The IP address (IPv4 or IPv6) of the origin server that the request was
  /// sent to. This field can include port information. Examples:
  /// `"192.168.1.1"`, `"10.0.0.1:80"`, `"FE80::0202:B3FF:FE1E:8329"`.
  @$pb.TagNumber(13)
  $core.String get serverIp => $_getSZ(12);
  @$pb.TagNumber(13)
  set serverIp($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasServerIp() => $_has(12);
  @$pb.TagNumber(13)
  void clearServerIp() => $_clearField(13);

  /// The request processing latency on the server, from the time the request was
  /// received until the response was sent.
  @$pb.TagNumber(14)
  $0.Duration get latency => $_getN(13);
  @$pb.TagNumber(14)
  set latency($0.Duration value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasLatency() => $_has(13);
  @$pb.TagNumber(14)
  void clearLatency() => $_clearField(14);
  @$pb.TagNumber(14)
  $0.Duration ensureLatency() => $_ensure(13);

  /// Protocol used for the request. Examples: "HTTP/1.1", "HTTP/2", "websocket"
  @$pb.TagNumber(15)
  $core.String get protocol => $_getSZ(14);
  @$pb.TagNumber(15)
  set protocol($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProtocol() => $_has(14);
  @$pb.TagNumber(15)
  void clearProtocol() => $_clearField(15);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
