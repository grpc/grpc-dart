#!/usr/bin/env bash
mkdir -p lib/src/generated
protoc --dart_out=grpc:lib/src/generated --proto_path lib/src/protos $(find lib/src/protos -iname "*.proto")
rm lib/src/generated/*.pbjson.dart
rm lib/src/generated/{empty,test}.pbenum.dart
dartfmt -w lib/src/generated
