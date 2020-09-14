#!/usr/bin/env bash
mkdir -p generated
protoc --dart_out=grpc:generated -Iprotos/ $(find protos -iname "*.proto")
rm generated/*.pbjson.dart
rm generated/{empty,test}.pbenum.dart
dartfmt -w generated
