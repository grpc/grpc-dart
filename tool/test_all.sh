#!/usr/bin/env bash

dart test
dart run --enable-vm-service --timeline-streams=Dart test/timeline_test.dart