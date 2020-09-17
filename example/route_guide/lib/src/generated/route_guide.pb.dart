///
//  Generated code. Do not modify.
//  source: route_guide.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Point', package: const $pb.PackageName('routeguide'), createEmptyInstance: create)
    ..a<$core.int>(1, 'latitude', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'longitude', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Point._() : super();
  factory Point() => create();
  factory Point.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Point.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Point clone() => Point()..mergeFromMessage(this);
  Point copyWith(void Function(Point) updates) => super.copyWith((message) => updates(message as Point));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Point create() => Point._();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  @$core.pragma('dart2js:noInline')
  static Point getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Point>(create);
  static Point _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get latitude => $_getIZ(0);
  @$pb.TagNumber(1)
  set latitude($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get longitude => $_getIZ(1);
  @$pb.TagNumber(2)
  set longitude($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class Rectangle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Rectangle', package: const $pb.PackageName('routeguide'), createEmptyInstance: create)
    ..aOM<Point>(1, 'lo', subBuilder: Point.create)
    ..aOM<Point>(2, 'hi', subBuilder: Point.create)
    ..hasRequiredFields = false
  ;

  Rectangle._() : super();
  factory Rectangle() => create();
  factory Rectangle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Rectangle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Rectangle clone() => Rectangle()..mergeFromMessage(this);
  Rectangle copyWith(void Function(Rectangle) updates) => super.copyWith((message) => updates(message as Rectangle));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Rectangle create() => Rectangle._();
  Rectangle createEmptyInstance() => create();
  static $pb.PbList<Rectangle> createRepeated() => $pb.PbList<Rectangle>();
  @$core.pragma('dart2js:noInline')
  static Rectangle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rectangle>(create);
  static Rectangle _defaultInstance;

  @$pb.TagNumber(1)
  Point get lo => $_getN(0);
  @$pb.TagNumber(1)
  set lo(Point v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLo() => $_has(0);
  @$pb.TagNumber(1)
  void clearLo() => clearField(1);
  @$pb.TagNumber(1)
  Point ensureLo() => $_ensure(0);

  @$pb.TagNumber(2)
  Point get hi => $_getN(1);
  @$pb.TagNumber(2)
  set hi(Point v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasHi() => $_has(1);
  @$pb.TagNumber(2)
  void clearHi() => clearField(2);
  @$pb.TagNumber(2)
  Point ensureHi() => $_ensure(1);
}

class Feature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Feature', package: const $pb.PackageName('routeguide'), createEmptyInstance: create)
    ..aOS(1, 'name')
    ..aOM<Point>(2, 'location', subBuilder: Point.create)
    ..hasRequiredFields = false
  ;

  Feature._() : super();
  factory Feature() => create();
  factory Feature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Feature clone() => Feature()..mergeFromMessage(this);
  Feature copyWith(void Function(Feature) updates) => super.copyWith((message) => updates(message as Feature));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  Point get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(Point v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);
  @$pb.TagNumber(2)
  Point ensureLocation() => $_ensure(1);
}

class RouteNote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RouteNote', package: const $pb.PackageName('routeguide'), createEmptyInstance: create)
    ..aOM<Point>(1, 'location', subBuilder: Point.create)
    ..aOS(2, 'message')
    ..hasRequiredFields = false
  ;

  RouteNote._() : super();
  factory RouteNote() => create();
  factory RouteNote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteNote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RouteNote clone() => RouteNote()..mergeFromMessage(this);
  RouteNote copyWith(void Function(RouteNote) updates) => super.copyWith((message) => updates(message as RouteNote));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteNote create() => RouteNote._();
  RouteNote createEmptyInstance() => create();
  static $pb.PbList<RouteNote> createRepeated() => $pb.PbList<RouteNote>();
  @$core.pragma('dart2js:noInline')
  static RouteNote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteNote>(create);
  static RouteNote _defaultInstance;

  @$pb.TagNumber(1)
  Point get location => $_getN(0);
  @$pb.TagNumber(1)
  set location(Point v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);
  @$pb.TagNumber(1)
  Point ensureLocation() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class RouteSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RouteSummary', package: const $pb.PackageName('routeguide'), createEmptyInstance: create)
    ..a<$core.int>(1, 'pointCount', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'featureCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, 'distance', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'elapsedTime', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  RouteSummary._() : super();
  factory RouteSummary() => create();
  factory RouteSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RouteSummary clone() => RouteSummary()..mergeFromMessage(this);
  RouteSummary copyWith(void Function(RouteSummary) updates) => super.copyWith((message) => updates(message as RouteSummary));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RouteSummary create() => RouteSummary._();
  RouteSummary createEmptyInstance() => create();
  static $pb.PbList<RouteSummary> createRepeated() => $pb.PbList<RouteSummary>();
  @$core.pragma('dart2js:noInline')
  static RouteSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteSummary>(create);
  static RouteSummary _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get pointCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set pointCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPointCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearPointCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get featureCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set featureCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeatureCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeatureCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get distance => $_getIZ(2);
  @$pb.TagNumber(3)
  set distance($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDistance() => $_has(2);
  @$pb.TagNumber(3)
  void clearDistance() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get elapsedTime => $_getIZ(3);
  @$pb.TagNumber(4)
  set elapsedTime($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasElapsedTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearElapsedTime() => clearField(4);
}

