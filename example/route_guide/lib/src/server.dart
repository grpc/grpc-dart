// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math' show atan2, cos, max, min, pi, sin, sqrt;

import 'package:collection/collection.dart' show IterableExtension;
import 'package:grpc/grpc.dart' as grpc;

import 'common.dart';
import 'generated/route_guide.pbgrpc.dart';

class RouteGuideService extends RouteGuideServiceBase {
  final routeNotes = <Point, List<RouteNote>>{};

  /// GetFeature handler. Returns a feature for the given location.
  /// The [context] object provides access to client metadata, cancellation, etc.
  @override
  Future<Feature> getFeature(grpc.ServiceCall call, Point request) async {
    return featuresDb.firstWhere(
      (f) => f.location == request,
      orElse: () => Feature()..location = request,
    );
  }

  Rectangle _normalize(Rectangle r) {
    final lo = Point()
      ..latitude = min(r.lo.latitude, r.hi.latitude)
      ..longitude = min(r.lo.longitude, r.hi.longitude);

    final hi = Point()
      ..latitude = max(r.lo.latitude, r.hi.latitude)
      ..longitude = max(r.lo.longitude, r.hi.longitude);

    return Rectangle()
      ..lo = lo
      ..hi = hi;
  }

  bool _contains(Rectangle r, Point p) {
    return p.longitude >= r.lo.longitude &&
        p.longitude <= r.hi.longitude &&
        p.latitude >= r.lo.latitude &&
        p.latitude <= r.hi.latitude;
  }

  /// ListFeatures handler. Returns a stream of features within the given
  /// rectangle.
  @override
  Stream<Feature> listFeatures(
    grpc.ServiceCall call,
    Rectangle request,
  ) async* {
    final normalizedRectangle = _normalize(request);
    // For each feature, check if it is in the given bounding box
    for (var feature in featuresDb) {
      if (feature.name.isEmpty) continue;
      final location = feature.location;
      if (_contains(normalizedRectangle, location)) {
        yield feature;
      }
    }
  }

  /// RecordRoute handler. Gets a stream of points, and responds with statistics
  /// about the "trip": number of points, number of known features visited,
  /// total distance traveled, and total time spent.
  @override
  Future<RouteSummary> recordRoute(
    grpc.ServiceCall call,
    Stream<Point> request,
  ) async {
    var pointCount = 0;
    var featureCount = 0;
    var distance = 0.0;
    Point? previous;
    final timer = Stopwatch();

    await for (var location in request) {
      if (!timer.isRunning) timer.start();
      pointCount++;
      final feature = featuresDb.firstWhereOrNull(
        (f) => f.location == location,
      );
      if (feature != null) {
        featureCount++;
      }
      // For each point after the first, add the incremental distance from the
      // previous point to the total distance value.
      if (previous != null) distance += _distance(previous, location);
      previous = location;
    }
    timer.stop();
    return RouteSummary()
      ..pointCount = pointCount
      ..featureCount = featureCount
      ..distance = distance.round()
      ..elapsedTime = timer.elapsed.inSeconds;
  }

  /// RouteChat handler. Receives a stream of message/location pairs, and
  /// responds with a stream of all previous messages at each of those
  /// locations.
  @override
  Stream<RouteNote> routeChat(
    grpc.ServiceCall call,
    Stream<RouteNote> request,
  ) async* {
    await for (var note in request) {
      final notes = routeNotes.putIfAbsent(note.location, () => <RouteNote>[]);
      for (var note in notes) {
        yield note;
      }
      notes.add(note);
    }
  }

  /// Calculate the distance between two points using the "haversine" formula.
  /// This code was taken from http://www.movable-type.co.uk/scripts/latlong.html.
  double _distance(Point start, Point end) {
    double toRadians(double num) {
      return num * pi / 180;
    }

    final lat1 = start.latitude / coordFactor;
    final lat2 = end.latitude / coordFactor;
    final lon1 = start.longitude / coordFactor;
    final lon2 = end.longitude / coordFactor;
    final R = 6371000; // metres
    final phi1 = toRadians(lat1);
    final phi2 = toRadians(lat2);
    final dLat = toRadians(lat2 - lat1);
    final dLon = toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(phi1) * cos(phi2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }
}

class Server {
  Future<void> main(List<String> args) async {
    final server = grpc.Server.create(services: [RouteGuideService()]);
    await server.serve(port: 8080);
    print('Server listening on port ${server.port}...');
  }
}
