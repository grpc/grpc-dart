///
//  Generated code. Do not modify.
//  source: route_guide.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Point', package: const $pb.PackageName('routeguide'))
        ..a<$core.int>(1, 'latitude', $pb.PbFieldType.O3)
        ..a<$core.int>(2, 'longitude', $pb.PbFieldType.O3)
        ..hasRequiredFields = false;

  Point._() : super();
  factory Point() => create();
  factory Point.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Point clone() => Point()..mergeFromMessage(this);
  Point copyWith(void Function(Point) updates) =>
      super.copyWith((message) => updates(message as Point));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  static Point getDefault() => _defaultInstance ??= create()..freeze();
  static Point _defaultInstance;

  $core.int get latitude => $_get(0, 0);
  set latitude($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasLatitude() => $_has(0);
  void clearLatitude() => clearField(1);

  $core.int get longitude => $_get(1, 0);
  set longitude($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasLongitude() => $_has(1);
  void clearLongitude() => clearField(2);
}

class Rectangle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Rectangle', package: const $pb.PackageName('routeguide'))
        ..a<Point>(1, 'lo', $pb.PbFieldType.OM, Point.getDefault, Point.create)
        ..a<Point>(2, 'hi', $pb.PbFieldType.OM, Point.getDefault, Point.create)
        ..hasRequiredFields = false;

  Rectangle._() : super();
  factory Rectangle() => create();
  factory Rectangle.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Rectangle.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Rectangle clone() => Rectangle()..mergeFromMessage(this);
  Rectangle copyWith(void Function(Rectangle) updates) =>
      super.copyWith((message) => updates(message as Rectangle));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Rectangle create() => Rectangle._();
  Rectangle createEmptyInstance() => create();
  static $pb.PbList<Rectangle> createRepeated() => $pb.PbList<Rectangle>();
  static Rectangle getDefault() => _defaultInstance ??= create()..freeze();
  static Rectangle _defaultInstance;

  Point get lo => $_getN(0);
  set lo(Point v) {
    setField(1, v);
  }

  $core.bool hasLo() => $_has(0);
  void clearLo() => clearField(1);

  Point get hi => $_getN(1);
  set hi(Point v) {
    setField(2, v);
  }

  $core.bool hasHi() => $_has(1);
  void clearHi() => clearField(2);
}

class Feature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('Feature', package: const $pb.PackageName('routeguide'))
        ..aOS(1, 'name')
        ..a<Point>(
            2, 'location', $pb.PbFieldType.OM, Point.getDefault, Point.create)
        ..hasRequiredFields = false;

  Feature._() : super();
  factory Feature() => create();
  factory Feature.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Feature clone() => Feature()..mergeFromMessage(this);
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  static Feature getDefault() => _defaultInstance ??= create()..freeze();
  static Feature _defaultInstance;

  $core.String get name => $_getS(0, '');
  set name($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasName() => $_has(0);
  void clearName() => clearField(1);

  Point get location => $_getN(1);
  set location(Point v) {
    setField(2, v);
  }

  $core.bool hasLocation() => $_has(1);
  void clearLocation() => clearField(2);
}

class RouteNote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i =
      $pb.BuilderInfo('RouteNote', package: const $pb.PackageName('routeguide'))
        ..a<Point>(
            1, 'location', $pb.PbFieldType.OM, Point.getDefault, Point.create)
        ..aOS(2, 'message')
        ..hasRequiredFields = false;

  RouteNote._() : super();
  factory RouteNote() => create();
  factory RouteNote.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteNote.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RouteNote clone() => RouteNote()..mergeFromMessage(this);
  RouteNote copyWith(void Function(RouteNote) updates) =>
      super.copyWith((message) => updates(message as RouteNote));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteNote create() => RouteNote._();
  RouteNote createEmptyInstance() => create();
  static $pb.PbList<RouteNote> createRepeated() => $pb.PbList<RouteNote>();
  static RouteNote getDefault() => _defaultInstance ??= create()..freeze();
  static RouteNote _defaultInstance;

  Point get location => $_getN(0);
  set location(Point v) {
    setField(1, v);
  }

  $core.bool hasLocation() => $_has(0);
  void clearLocation() => clearField(1);

  $core.String get message => $_getS(1, '');
  set message($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasMessage() => $_has(1);
  void clearMessage() => clearField(2);
}

class RouteSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RouteSummary',
      package: const $pb.PackageName('routeguide'))
    ..a<$core.int>(1, 'pointCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'featureCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'distance', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'elapsedTime', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  RouteSummary._() : super();
  factory RouteSummary() => create();
  factory RouteSummary.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RouteSummary.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RouteSummary clone() => RouteSummary()..mergeFromMessage(this);
  RouteSummary copyWith(void Function(RouteSummary) updates) =>
      super.copyWith((message) => updates(message as RouteSummary));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteSummary create() => RouteSummary._();
  RouteSummary createEmptyInstance() => create();
  static $pb.PbList<RouteSummary> createRepeated() =>
      $pb.PbList<RouteSummary>();
  static RouteSummary getDefault() => _defaultInstance ??= create()..freeze();
  static RouteSummary _defaultInstance;

  $core.int get pointCount => $_get(0, 0);
  set pointCount($core.int v) {
    $_setSignedInt32(0, v);
  }

  $core.bool hasPointCount() => $_has(0);
  void clearPointCount() => clearField(1);

  $core.int get featureCount => $_get(1, 0);
  set featureCount($core.int v) {
    $_setSignedInt32(1, v);
  }

  $core.bool hasFeatureCount() => $_has(1);
  void clearFeatureCount() => clearField(2);

  $core.int get distance => $_get(2, 0);
  set distance($core.int v) {
    $_setSignedInt32(2, v);
  }

  $core.bool hasDistance() => $_has(2);
  void clearDistance() => clearField(3);

  $core.int get elapsedTime => $_get(3, 0);
  set elapsedTime($core.int v) {
    $_setSignedInt32(3, v);
  }

  $core.bool hasElapsedTime() => $_has(3);
  void clearElapsedTime() => clearField(4);
}
