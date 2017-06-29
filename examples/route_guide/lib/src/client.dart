// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show Random;

import 'package:grpc/grpc.dart';

import 'common.dart';
import 'generated/route_guide.pb.dart';
import 'generated/route_guide.pbgrpc.dart';

class Client {
  ClientChannel channel;
  RouteGuideClient stub;

  Client() {
    channel = new ClientChannel('127.0.0.1', port: 8080);
    stub = new RouteGuideClient(channel);
  }

  Future<Null> main(List<String> args) async {
    // Run all of the demos in order.
    await runGetFeature();
    await runListFeatures();
    await runRecordRoute();
    await runRouteChat();
    await channel.close();
  }

  void printFeature(Feature feature) {
    final latitude = feature.location.latitude;
    final longitude = feature.location.longitude;
    final name = feature.name.isEmpty
        ? 'no feature'
        : 'feature called "${feature.name}"';
    print(
        'Found $name at ${latitude / coordFactor}, ${longitude / coordFactor}');
  }

  /// Run the getFeature demo. Calls getFeature with a point known to have a
  /// feature and a point known not to have a feature.
  Future<Null> runGetFeature() async {
    final point1 = new Point()
      ..latitude = 409146138
      ..longitude = -746188906;
    final point2 = new Point()
      ..latitude = 0
      ..longitude = 0;

    printFeature(await stub.getFeature(point1));
    printFeature(await stub.getFeature(point2));
  }

  /// Run the listFeatures demo. Calls listFeatures with a rectangle containing
  /// all of the features in the pre-generated database. Prints each response as
  /// it comes in.
  Future<Null> runListFeatures() async {
    final lo = new Point()
      ..latitude = 400000000
      ..longitude = -750000000;
    final hi = new Point()
      ..latitude = 420000000
      ..longitude = -730000000;
    final rect = new Rectangle()
      ..lo = lo
      ..hi = hi;

    print('Looking for features between 40, -75 and 42, -73');
    await for (var feature in stub.listFeatures(rect)) {
      printFeature(feature);
    }
  }

  /// Run the recordRoute demo. Sends several randomly chosen points from the
  /// pre-generated feature database with a variable delay in between. Prints
  /// the statistics when they are sent from the server.
  Future<Null> runRecordRoute() async {
    Stream<Point> generateRoute(int count) async* {
      final random = new Random();

      for (int i = 0; i < count; i++) {
        final point = featuresDb[random.nextInt(featuresDb.length)].location;
        print(
            'Visiting point ${point.latitude / coordFactor}, ${point.longitude /
                coordFactor}');
        yield point;
        await new Future.delayed(
            new Duration(milliseconds: 500 + random.nextInt(100)));
      }
    }

    final summary = await stub.recordRoute(generateRoute(10));
    print('Finished trip with ${summary.pointCount} points');
    print('Passed ${summary.featureCount} features');
    print('Travelled ${summary.distance} meters');
    print('It took ${summary.elapsedTime} seconds');
  }

  /// Run the routeChat demo. Send some chat messages, and print any chat
  /// messages that are sent from the server.
  Future<Null> runRouteChat() async {
    RouteNote createNote(String message, int latitude, int longitude) {
      final location = new Point()
        ..latitude = latitude
        ..longitude = longitude;
      return new RouteNote()
        ..message = message
        ..location = location;
    }

    final notes = <RouteNote>[
      createNote('First message', 0, 0),
      createNote('Second message', 0, 1),
      createNote('Third message', 1, 0),
      createNote('Fourth message', 0, 0),
    ];

    Stream<RouteNote> outgoingNotes() async* {
      for (final note in notes) {
        // Short delay to simulate some other interaction.
        await new Future.delayed(new Duration(milliseconds: 10));
        print('Sending message ${note.message} at ${note.location.latitude}, '
            '${note.location.longitude}');
        yield note;
      }
    }

    final call = stub.routeChat(outgoingNotes());
    await call.forEach((note) {
      print('Got message ${note.message} at ${note.location.latitude}, ${note
          .location.longitude}');
    });
  }
}
