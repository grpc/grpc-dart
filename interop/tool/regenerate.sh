#!/usr/bin/env bash
mkdir -p lib/src/generated
protoc --dart_out=grpc:lib/src/generated -Iprotos/ protos/*.proto
rm lib/src/generated/*.pbjson.dart
rm lib/src/generated/{empty,test}.pbenum.dart
dart format -o write lib/src/generated
