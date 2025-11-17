// This is a generated file - do not edit.
//
// Generated from route_guide.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Points are represented as latitude-longitude pairs in the E7 representation
/// (degrees multiplied by 10**7 and rounded to the nearest integer).
/// Latitudes should be in the range +/- 90 degrees and longitude should be in
/// the range +/- 180 degrees (inclusive).
class Point extends $pb.GeneratedMessage {
  factory Point({
    $core.int? latitude,
    $core.int? longitude,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    return result;
  }

  Point._();

  factory Point.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Point.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Point',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'latitude')
    ..aI(2, _omitFieldNames ? '' : 'longitude')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Point clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Point copyWith(void Function(Point) updates) =>
      super.copyWith((message) => updates(message as Point)) as Point;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  @$core.override
  Point createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Point getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Point>(create);
  static Point? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get latitude => $_getIZ(0);
  @$pb.TagNumber(1)
  set latitude($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get longitude => $_getIZ(1);
  @$pb.TagNumber(2)
  set longitude($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);
}

/// A latitude-longitude rectangle, represented as two diagonally opposite
/// points "lo" and "hi".
class Rectangle extends $pb.GeneratedMessage {
  factory Rectangle({
    Point? lo,
    Point? hi,
  }) {
    final result = create();
    if (lo != null) result.lo = lo;
    if (hi != null) result.hi = hi;
    return result;
  }

  Rectangle._();

  factory Rectangle.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Rectangle.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rectangle',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(1, _omitFieldNames ? '' : 'lo', subBuilder: Point.create)
    ..aOM<Point>(2, _omitFieldNames ? '' : 'hi', subBuilder: Point.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rectangle clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rectangle copyWith(void Function(Rectangle) updates) =>
      super.copyWith((message) => updates(message as Rectangle)) as Rectangle;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rectangle create() => Rectangle._();
  @$core.override
  Rectangle createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Rectangle getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rectangle>(create);
  static Rectangle? _defaultInstance;

  /// One corner of the rectangle.
  @$pb.TagNumber(1)
  Point get lo => $_getN(0);
  @$pb.TagNumber(1)
  set lo(Point value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLo() => $_has(0);
  @$pb.TagNumber(1)
  void clearLo() => $_clearField(1);
  @$pb.TagNumber(1)
  Point ensureLo() => $_ensure(0);

  /// The other corner of the rectangle.
  @$pb.TagNumber(2)
  Point get hi => $_getN(1);
  @$pb.TagNumber(2)
  set hi(Point value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHi() => $_has(1);
  @$pb.TagNumber(2)
  void clearHi() => $_clearField(2);
  @$pb.TagNumber(2)
  Point ensureHi() => $_ensure(1);
}

/// A feature names something at a given point.
///
/// If a feature could not be named, the name is empty.
class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? name,
    Point? location,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (location != null) result.location = location;
    return result;
  }

  Feature._();

  factory Feature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Feature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Feature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Point>(2, _omitFieldNames ? '' : 'location', subBuilder: Point.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature)) as Feature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  @$core.override
  Feature createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  /// The name of the feature.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// The point where the feature is detected.
  @$pb.TagNumber(2)
  Point get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(Point value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => $_clearField(2);
  @$pb.TagNumber(2)
  Point ensureLocation() => $_ensure(1);
}

/// A RouteNote is a message sent while at a given point.
class RouteNote extends $pb.GeneratedMessage {
  factory RouteNote({
    Point? location,
    $core.String? message,
  }) {
    final result = create();
    if (location != null) result.location = location;
    if (message != null) result.message = message;
    return result;
  }

  RouteNote._();

  factory RouteNote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RouteNote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteNote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(1, _omitFieldNames ? '' : 'location', subBuilder: Point.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteNote clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteNote copyWith(void Function(RouteNote) updates) =>
      super.copyWith((message) => updates(message as RouteNote)) as RouteNote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteNote create() => RouteNote._();
  @$core.override
  RouteNote createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RouteNote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteNote>(create);
  static RouteNote? _defaultInstance;

  /// The location from which the message is sent.
  @$pb.TagNumber(1)
  Point get location => $_getN(0);
  @$pb.TagNumber(1)
  set location(Point value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => $_clearField(1);
  @$pb.TagNumber(1)
  Point ensureLocation() => $_ensure(0);

  /// The message to be sent.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// A RouteSummary is received in response to a RecordRoute rpc.
///
/// It contains the number of individual points received, the number of
/// detected features, and the total distance covered as the cumulative sum of
/// the distance between each point.
class RouteSummary extends $pb.GeneratedMessage {
  factory RouteSummary({
    $core.int? pointCount,
    $core.int? featureCount,
    $core.int? distance,
    $core.int? elapsedTime,
  }) {
    final result = create();
    if (pointCount != null) result.pointCount = pointCount;
    if (featureCount != null) result.featureCount = featureCount;
    if (distance != null) result.distance = distance;
    if (elapsedTime != null) result.elapsedTime = elapsedTime;
    return result;
  }

  RouteSummary._();

  factory RouteSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RouteSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'pointCount')
    ..aI(2, _omitFieldNames ? '' : 'featureCount')
    ..aI(3, _omitFieldNames ? '' : 'distance')
    ..aI(4, _omitFieldNames ? '' : 'elapsedTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteSummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteSummary copyWith(void Function(RouteSummary) updates) =>
      super.copyWith((message) => updates(message as RouteSummary))
          as RouteSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteSummary create() => RouteSummary._();
  @$core.override
  RouteSummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RouteSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RouteSummary>(create);
  static RouteSummary? _defaultInstance;

  /// The number of points received.
  @$pb.TagNumber(1)
  $core.int get pointCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set pointCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPointCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearPointCount() => $_clearField(1);

  /// The number of known features passed while traversing the route.
  @$pb.TagNumber(2)
  $core.int get featureCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set featureCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFeatureCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeatureCount() => $_clearField(2);

  /// The distance covered in metres.
  @$pb.TagNumber(3)
  $core.int get distance => $_getIZ(2);
  @$pb.TagNumber(3)
  set distance($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDistance() => $_has(2);
  @$pb.TagNumber(3)
  void clearDistance() => $_clearField(3);

  /// The duration of the traversal in seconds.
  @$pb.TagNumber(4)
  $core.int get elapsedTime => $_getIZ(3);
  @$pb.TagNumber(4)
  set elapsedTime($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasElapsedTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearElapsedTime() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
