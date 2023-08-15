//
//  Generated code. Do not modify.
//  source: route_guide.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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
    if (latitude != null) {
      result.latitude = latitude;
    }
    if (longitude != null) {
      result.longitude = longitude;
    }
    return result;
  }
  Point._() : super();
  factory Point.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Point',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Point clone() => Point()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Point copyWith(void Function(Point) updates) =>
      super.copyWith((message) => updates(message as Point)) as Point;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  @$core.pragma('dart2js:noInline')
  static Point getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Point>(create);
  static Point? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get latitude => $_getIZ(0);
  @$pb.TagNumber(1)
  set latitude($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get longitude => $_getIZ(1);
  @$pb.TagNumber(2)
  set longitude($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

/// A latitude-longitude rectangle, represented as two diagonally opposite
/// points "lo" and "hi".
class Rectangle extends $pb.GeneratedMessage {
  factory Rectangle({
    Point? lo,
    Point? hi,
  }) {
    final result = create();
    if (lo != null) {
      result.lo = lo;
    }
    if (hi != null) {
      result.hi = hi;
    }
    return result;
  }
  Rectangle._() : super();
  factory Rectangle.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rectangle.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rectangle',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(1, _omitFieldNames ? '' : 'lo', subBuilder: Point.create)
    ..aOM<Point>(2, _omitFieldNames ? '' : 'hi', subBuilder: Point.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Rectangle clone() => Rectangle()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Rectangle copyWith(void Function(Rectangle) updates) =>
      super.copyWith((message) => updates(message as Rectangle)) as Rectangle;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rectangle create() => Rectangle._();
  Rectangle createEmptyInstance() => create();
  static $pb.PbList<Rectangle> createRepeated() => $pb.PbList<Rectangle>();
  @$core.pragma('dart2js:noInline')
  static Rectangle getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rectangle>(create);
  static Rectangle? _defaultInstance;

  /// One corner of the rectangle.
  @$pb.TagNumber(1)
  Point get lo => $_getN(0);
  @$pb.TagNumber(1)
  set lo(Point v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLo() => $_has(0);
  @$pb.TagNumber(1)
  void clearLo() => clearField(1);
  @$pb.TagNumber(1)
  Point ensureLo() => $_ensure(0);

  /// The other corner of the rectangle.
  @$pb.TagNumber(2)
  Point get hi => $_getN(1);
  @$pb.TagNumber(2)
  set hi(Point v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasHi() => $_has(1);
  @$pb.TagNumber(2)
  void clearHi() => clearField(2);
  @$pb.TagNumber(2)
  Point ensureHi() => $_ensure(1);
}

///  A feature names something at a given point.
///
///  If a feature could not be named, the name is empty.
class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? name,
    Point? location,
  }) {
    final result = create();
    if (name != null) {
      result.name = name;
    }
    if (location != null) {
      result.location = location;
    }
    return result;
  }
  Feature._() : super();
  factory Feature.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Feature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Point>(2, _omitFieldNames ? '' : 'location', subBuilder: Point.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Feature clone() => Feature()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature)) as Feature;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  /// The name of the feature.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// The point where the feature is detected.
  @$pb.TagNumber(2)
  Point get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(Point v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);
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
    if (location != null) {
      result.location = location;
    }
    if (message != null) {
      result.message = message;
    }
    return result;
  }
  RouteNote._() : super();
  factory RouteNote.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteNote.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteNote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(1, _omitFieldNames ? '' : 'location', subBuilder: Point.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RouteNote clone() => RouteNote()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RouteNote copyWith(void Function(RouteNote) updates) =>
      super.copyWith((message) => updates(message as RouteNote)) as RouteNote;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteNote create() => RouteNote._();
  RouteNote createEmptyInstance() => create();
  static $pb.PbList<RouteNote> createRepeated() => $pb.PbList<RouteNote>();
  @$core.pragma('dart2js:noInline')
  static RouteNote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteNote>(create);
  static RouteNote? _defaultInstance;

  /// The location from which the message is sent.
  @$pb.TagNumber(1)
  Point get location => $_getN(0);
  @$pb.TagNumber(1)
  set location(Point v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);
  @$pb.TagNumber(1)
  Point ensureLocation() => $_ensure(0);

  /// The message to be sent.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

///  A RouteSummary is received in response to a RecordRoute rpc.
///
///  It contains the number of individual points received, the number of
///  detected features, and the total distance covered as the cumulative sum of
///  the distance between each point.
class RouteSummary extends $pb.GeneratedMessage {
  factory RouteSummary({
    $core.int? pointCount,
    $core.int? featureCount,
    $core.int? distance,
    $core.int? elapsedTime,
  }) {
    final result = create();
    if (pointCount != null) {
      result.pointCount = pointCount;
    }
    if (featureCount != null) {
      result.featureCount = featureCount;
    }
    if (distance != null) {
      result.distance = distance;
    }
    if (elapsedTime != null) {
      result.elapsedTime = elapsedTime;
    }
    return result;
  }
  RouteSummary._() : super();
  factory RouteSummary.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteSummary.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'routeguide'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'pointCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'featureCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'distance', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'elapsedTime', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RouteSummary clone() => RouteSummary()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RouteSummary copyWith(void Function(RouteSummary) updates) =>
      super.copyWith((message) => updates(message as RouteSummary))
          as RouteSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteSummary create() => RouteSummary._();
  RouteSummary createEmptyInstance() => create();
  static $pb.PbList<RouteSummary> createRepeated() =>
      $pb.PbList<RouteSummary>();
  @$core.pragma('dart2js:noInline')
  static RouteSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RouteSummary>(create);
  static RouteSummary? _defaultInstance;

  /// The number of points received.
  @$pb.TagNumber(1)
  $core.int get pointCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set pointCount($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPointCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearPointCount() => clearField(1);

  /// The number of known features passed while traversing the route.
  @$pb.TagNumber(2)
  $core.int get featureCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set featureCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFeatureCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeatureCount() => clearField(2);

  /// The distance covered in metres.
  @$pb.TagNumber(3)
  $core.int get distance => $_getIZ(2);
  @$pb.TagNumber(3)
  set distance($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDistance() => $_has(2);
  @$pb.TagNumber(3)
  void clearDistance() => clearField(3);

  /// The duration of the traversal in seconds.
  @$pb.TagNumber(4)
  $core.int get elapsedTime => $_getIZ(3);
  @$pb.TagNumber(4)
  set elapsedTime($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasElapsedTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearElapsedTime() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
