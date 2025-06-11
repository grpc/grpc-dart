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

import 'dart:async';
import 'dart:io';

import 'package:googleapis/src/generated/google/api/monitored_resource.pb.dart';
import 'package:googleapis/src/generated/google/logging/type/log_severity.pb.dart';
import 'package:googleapis/src/generated/google/logging/v2/log_entry.pb.dart';
import 'package:googleapis/src/generated/google/logging/v2/logging.pbgrpc.dart';
import 'package:grpc/grpc.dart';

Future<void> main() async {
  final serviceAccountFile = File('logging-service-account.json');
  if (!serviceAccountFile.existsSync()) {
    print(
      'File logging-service-account.json not found. Please follow the '
      'steps in README.md to create it.',
    );
    exit(-1);
  }

  final scopes = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/logging.write',
  ];

  final authenticator = ServiceAccountAuthenticator(
    serviceAccountFile.readAsStringSync(),
    scopes,
  );
  final projectId = authenticator.projectId;

  final channel = ClientChannel('logging.googleapis.com');
  final logging = LoggingServiceV2Client(
    channel,
    options: authenticator.toCallOptions,
  );

  final request = WriteLogEntriesRequest()
    ..entries.add(
      LogEntry()
        ..logName = 'projects/$projectId/logs/example'
        ..severity = LogSeverity.INFO
        ..resource = (MonitoredResource()..type = 'global')
        ..textPayload = 'This is a log entry!',
    );
  await logging.writeLogEntries(request);

  await channel.shutdown();
}
