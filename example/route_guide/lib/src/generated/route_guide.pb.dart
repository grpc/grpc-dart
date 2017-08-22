///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library routeguide_route_guide;

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart';

class Point extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Point')
    ..a<int>(1, 'latitude', PbFieldType.O3)
    ..a<int>(2, 'longitude', PbFieldType.O3)
    ..hasRequiredFields = false;

  Point() : super();
  Point.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Point.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Point clone() => new Point()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Point create() => new Point();
  static PbList<Point> createRepeated() => new PbList<Point>();
  static Point getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPoint();
    return _defaultInstance;
  }

  static Point _defaultInstance;
  static void $checkItem(Point v) {
    if (v is! Point) checkItemFailed(v, 'Point');
  }

  int get latitude => $_get(0, 1, 0);
  set latitude(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasLatitude() => $_has(0, 1);
  void clearLatitude() => clearField(1);

  int get longitude => $_get(1, 2, 0);
  set longitude(int v) {
    $_setUnsignedInt32(1, 2, v);
  }

  bool hasLongitude() => $_has(1, 2);
  void clearLongitude() => clearField(2);
}

class _ReadonlyPoint extends Point with ReadonlyMessageMixin {}

class Rectangle extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Rectangle')
    ..a<Point>(1, 'lo', PbFieldType.OM, Point.getDefault, Point.create)
    ..a<Point>(2, 'hi', PbFieldType.OM, Point.getDefault, Point.create)
    ..hasRequiredFields = false;

  Rectangle() : super();
  Rectangle.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Rectangle.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Rectangle clone() => new Rectangle()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Rectangle create() => new Rectangle();
  static PbList<Rectangle> createRepeated() => new PbList<Rectangle>();
  static Rectangle getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRectangle();
    return _defaultInstance;
  }

  static Rectangle _defaultInstance;
  static void $checkItem(Rectangle v) {
    if (v is! Rectangle) checkItemFailed(v, 'Rectangle');
  }

  Point get lo => $_get(0, 1, null);
  set lo(Point v) {
    setField(1, v);
  }

  bool hasLo() => $_has(0, 1);
  void clearLo() => clearField(1);

  Point get hi => $_get(1, 2, null);
  set hi(Point v) {
    setField(2, v);
  }

  bool hasHi() => $_has(1, 2);
  void clearHi() => clearField(2);
}

class _ReadonlyRectangle extends Rectangle with ReadonlyMessageMixin {}

class Feature extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Feature')
    ..a<String>(1, 'name', PbFieldType.OS)
    ..a<Point>(2, 'location', PbFieldType.OM, Point.getDefault, Point.create)
    ..hasRequiredFields = false;

  Feature() : super();
  Feature.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Feature.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Feature clone() => new Feature()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Feature create() => new Feature();
  static PbList<Feature> createRepeated() => new PbList<Feature>();
  static Feature getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFeature();
    return _defaultInstance;
  }

  static Feature _defaultInstance;
  static void $checkItem(Feature v) {
    if (v is! Feature) checkItemFailed(v, 'Feature');
  }

  String get name => $_get(0, 1, '');
  set name(String v) {
    $_setString(0, 1, v);
  }

  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Point get location => $_get(1, 2, null);
  set location(Point v) {
    setField(2, v);
  }

  bool hasLocation() => $_has(1, 2);
  void clearLocation() => clearField(2);
}

class _ReadonlyFeature extends Feature with ReadonlyMessageMixin {}

class RouteNote extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RouteNote')
    ..a<Point>(1, 'location', PbFieldType.OM, Point.getDefault, Point.create)
    ..a<String>(2, 'message', PbFieldType.OS)
    ..hasRequiredFields = false;

  RouteNote() : super();
  RouteNote.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  RouteNote.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  RouteNote clone() => new RouteNote()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RouteNote create() => new RouteNote();
  static PbList<RouteNote> createRepeated() => new PbList<RouteNote>();
  static RouteNote getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRouteNote();
    return _defaultInstance;
  }

  static RouteNote _defaultInstance;
  static void $checkItem(RouteNote v) {
    if (v is! RouteNote) checkItemFailed(v, 'RouteNote');
  }

  Point get location => $_get(0, 1, null);
  set location(Point v) {
    setField(1, v);
  }

  bool hasLocation() => $_has(0, 1);
  void clearLocation() => clearField(1);

  String get message => $_get(1, 2, '');
  set message(String v) {
    $_setString(1, 2, v);
  }

  bool hasMessage() => $_has(1, 2);
  void clearMessage() => clearField(2);
}

class _ReadonlyRouteNote extends RouteNote with ReadonlyMessageMixin {}

class RouteSummary extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RouteSummary')
    ..a<int>(1, 'pointCount', PbFieldType.O3)
    ..a<int>(2, 'featureCount', PbFieldType.O3)
    ..a<int>(3, 'distance', PbFieldType.O3)
    ..a<int>(4, 'elapsedTime', PbFieldType.O3)
    ..hasRequiredFields = false;

  RouteSummary() : super();
  RouteSummary.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  RouteSummary.fromJson(String i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  RouteSummary clone() => new RouteSummary()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RouteSummary create() => new RouteSummary();
  static PbList<RouteSummary> createRepeated() => new PbList<RouteSummary>();
  static RouteSummary getDefault() {
    if (_defaultInstance == null)
      _defaultInstance = new _ReadonlyRouteSummary();
    return _defaultInstance;
  }

  static RouteSummary _defaultInstance;
  static void $checkItem(RouteSummary v) {
    if (v is! RouteSummary) checkItemFailed(v, 'RouteSummary');
  }

  int get pointCount => $_get(0, 1, 0);
  set pointCount(int v) {
    $_setUnsignedInt32(0, 1, v);
  }

  bool hasPointCount() => $_has(0, 1);
  void clearPointCount() => clearField(1);

  int get featureCount => $_get(1, 2, 0);
  set featureCount(int v) {
    $_setUnsignedInt32(1, 2, v);
  }

  bool hasFeatureCount() => $_has(1, 2);
  void clearFeatureCount() => clearField(2);

  int get distance => $_get(2, 3, 0);
  set distance(int v) {
    $_setUnsignedInt32(2, 3, v);
  }

  bool hasDistance() => $_has(2, 3);
  void clearDistance() => clearField(3);

  int get elapsedTime => $_get(3, 4, 0);
  set elapsedTime(int v) {
    $_setUnsignedInt32(3, 4, v);
  }

  bool hasElapsedTime() => $_has(3, 4);
  void clearElapsedTime() => clearField(4);
}

class _ReadonlyRouteSummary extends RouteSummary with ReadonlyMessageMixin {}
