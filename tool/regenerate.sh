#!/usr/bin/env bash

set -ex

mkdir -p lib/src/generated
protoc --dart_out=grpc:lib/src/generated --proto_path lib/src/protos $(find lib/src/protos -iname "*.proto")
rm -f lib/src/generated/*.pbjson.dart
rm -f lib/src/generated/{empty,test}.pbenum.dart
dart format lib/src/generated

protoc --dart_out=grpc:test/src/generated --proto_path test/src/protos test/src/protos/echo.proto
dart format test/src/generated

for dir in interop example/*/; do
  pushd $dir
  echo [Regenerating in $dir]
  if [[ -x "tool/regenerate.sh" ]]; then
    tool/regenerate.sh
  elif [[ -d "protos" ]]; then
    protoc --dart_out=grpc:lib/src/generated --proto_path protos $(find protos -iname "*.proto")
    dart format lib/src/generated
  fi
  popd
done
