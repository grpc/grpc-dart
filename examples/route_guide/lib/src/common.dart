// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'generated/route_guide.pb.dart';

const coordFactor = 1e7;

List<Feature> _featuresDb;
List<Feature> get featuresDb => _featuresDb ??= _readDatabase();

List<Feature> _readDatabase() {
  final dbData = new File('data/route_guide_db.json').readAsStringSync();
  List<Map<String, dynamic>> db = JSON.decode(dbData);
  return db.map((entry) {
    final location = new Point()
      ..latitude = entry['location']['latitude']
      ..longitude = entry['location']['longitude'];
    return new Feature()
      ..name = entry['name']
      ..location = location;
  }).toList();
}
