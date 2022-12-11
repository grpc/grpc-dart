///
//  Generated code. Do not modify.
//  source: route_guide.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Point',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'routeguide'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'latitude',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'longitude',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  Point._() : super();
  factory Point({
    $core.int? latitude,
    $core.int? longitude,
  }) {
    final _result = create();
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    return _result;
  }
  factory Point.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Point clone() => Point()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Point copyWith(void Function(Point) updates) =>
      super.copyWith((message) => updates(message as Point))
          as Point; // ignore: deprecated_member_use
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

class Rectangle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Rectangle',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'lo',
        subBuilder: Point.create)
    ..aOM<Point>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'hi',
        subBuilder: Point.create)
    ..hasRequiredFields = false;

  Rectangle._() : super();
  factory Rectangle({
    Point? lo,
    Point? hi,
  }) {
    final _result = create();
    if (lo != null) {
      _result.lo = lo;
    }
    if (hi != null) {
      _result.hi = hi;
    }
    return _result;
  }
  factory Rectangle.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rectangle.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Rectangle clone() => Rectangle()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Rectangle copyWith(void Function(Rectangle) updates) =>
      super.copyWith((message) => updates(message as Rectangle))
          as Rectangle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Rectangle create() => Rectangle._();
  Rectangle createEmptyInstance() => create();
  static $pb.PbList<Rectangle> createRepeated() => $pb.PbList<Rectangle>();
  @$core.pragma('dart2js:noInline')
  static Rectangle getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rectangle>(create);
  static Rectangle? _defaultInstance;

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

class Feature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Feature',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'routeguide'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOM<Point>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'location',
        subBuilder: Point.create)
    ..hasRequiredFields = false;

  Feature._() : super();
  factory Feature({
    $core.String? name,
    Point? location,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (location != null) {
      _result.location = location;
    }
    return _result;
  }
  factory Feature.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Feature clone() => Feature()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature))
          as Feature; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

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

class RouteNote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RouteNote',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'routeguide'),
      createEmptyInstance: create)
    ..aOM<Point>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'location',
        subBuilder: Point.create)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'message')
    ..hasRequiredFields = false;

  RouteNote._() : super();
  factory RouteNote({
    Point? location,
    $core.String? message,
  }) {
    final _result = create();
    if (location != null) {
      _result.location = location;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RouteNote.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteNote.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RouteNote clone() => RouteNote()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RouteNote copyWith(void Function(RouteNote) updates) =>
      super.copyWith((message) => updates(message as RouteNote))
          as RouteNote; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteNote create() => RouteNote._();
  RouteNote createEmptyInstance() => create();
  static $pb.PbList<RouteNote> createRepeated() => $pb.PbList<RouteNote>();
  @$core.pragma('dart2js:noInline')
  static RouteNote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteNote>(create);
  static RouteNote? _defaultInstance;

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

class RouteSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'RouteSummary',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'routeguide'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pointCount',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'featureCount',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'distance',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'elapsedTime',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  RouteSummary._() : super();
  factory RouteSummary({
    $core.int? pointCount,
    $core.int? featureCount,
    $core.int? distance,
    $core.int? elapsedTime,
  }) {
    final _result = create();
    if (pointCount != null) {
      _result.pointCount = pointCount;
    }
    if (featureCount != null) {
      _result.featureCount = featureCount;
    }
    if (distance != null) {
      _result.distance = distance;
    }
    if (elapsedTime != null) {
      _result.elapsedTime = elapsedTime;
    }
    return _result;
  }
  factory RouteSummary.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteSummary.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RouteSummary clone() => RouteSummary()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RouteSummary copyWith(void Function(RouteSummary) updates) =>
      super.copyWith((message) => updates(message as RouteSummary))
          as RouteSummary; // ignore: deprecated_member_use
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
