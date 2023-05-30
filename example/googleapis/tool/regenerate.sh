#!/usr/bin/env bash

if [ ! -d "$PROTOBUF" ]; then
  echo "Please set the PROTOBUF environment variable to your clone of protocolbuffers/protobuf."
  exit -1
fi

if [ ! -d "$GOOGLEAPIS" ]; then
  echo "Please set the GOOGLEAPIS environment variable to your clone of googleapis/googleapis."
  exit -1
fi

PROTOC="protoc --dart_out=grpc:lib/src/generated -I$PROTOBUF/src -I$GOOGLEAPIS"

$PROTOC $GOOGLEAPIS/google/logging/v2/logging.proto
$PROTOC $GOOGLEAPIS/google/logging/v2/log_entry.proto
$PROTOC $GOOGLEAPIS/google/logging/type/log_severity.proto
$PROTOC $GOOGLEAPIS/google/logging/type/http_request.proto

$PROTOC $GOOGLEAPIS/google/ai/generativelanguage/v1beta2/citation.proto
$PROTOC $GOOGLEAPIS/google/ai/generativelanguage/v1beta2/discuss_service.proto
$PROTOC $GOOGLEAPIS/google/ai/generativelanguage/v1beta2/model.proto
$PROTOC $GOOGLEAPIS/google/ai/generativelanguage/v1beta2/model_service.proto
$PROTOC $GOOGLEAPIS/google/ai/generativelanguage/v1beta2/safety.proto

$PROTOC $GOOGLEAPIS/google/api/monitored_resource.proto
$PROTOC $GOOGLEAPIS/google/api/label.proto
$PROTOC $GOOGLEAPIS/google/api/launch_stage.proto

$PROTOC $GOOGLEAPIS/google/rpc/status.proto

$PROTOC $PROTOBUF/src/google/protobuf/any.proto
$PROTOC $PROTOBUF/src/google/protobuf/duration.proto
$PROTOC $PROTOBUF/src/google/protobuf/empty.proto
$PROTOC $PROTOBUF/src/google/protobuf/struct.proto
$PROTOC $PROTOBUF/src/google/protobuf/timestamp.proto

dart format lib/src/generated
