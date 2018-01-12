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
import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;

import 'package:googleapis/src/generated/google/api/monitored_resource.pb.dart';
import 'package:googleapis/src/generated/google/logging/type/log_severity.pb.dart';
import 'package:googleapis/src/generated/google/logging/v2/log_entry.pb.dart';
import 'package:googleapis/src/generated/google/logging/v2/logging.pbgrpc.dart';

const _tokenExpirationThreshold = const Duration(seconds: 30);

class ServiceAccountAuthenticator {
  auth.ServiceAccountCredentials _serviceAccountCredentials;
  final List<String> _scopes;
  String _projectId;

  auth.AccessToken _accessToken;
  Future<CallOptions> _call;

  ServiceAccountAuthenticator(String serviceAccountJson, this._scopes) {
    final serviceAccount = JSON.decode(serviceAccountJson);
    _serviceAccountCredentials =
        new auth.ServiceAccountCredentials.fromJson(serviceAccount);
    _projectId = serviceAccount['project_id'];
  }

  String get projectId => _projectId;

  Future authenticate(Map<String, String> metadata) async {
    if (_accessToken == null || _accessToken.hasExpired) {
      await _obtainAccessCredentials();
    }

    metadata['authorization'] = 'Bearer ${_accessToken.data}';

    if (_tokenExpiresSoon) {
      // Token is about to expire. Extend it prematurely.
      _obtainAccessCredentials().catchError((_) {});
    }
  }

  bool get _tokenExpiresSoon => _accessToken.expiry
      .subtract(_tokenExpirationThreshold)
      .isBefore(new DateTime.now().toUtc());

  Future _obtainAccessCredentials() {
    if (_call == null) {
      final authClient = new http.Client();
      _call = auth
          .obtainAccessCredentialsViaServiceAccount(
              _serviceAccountCredentials, _scopes, authClient)
          .then((credentials) {
        _accessToken = credentials.accessToken;
        _call = null;
        authClient.close();
      });
    }
    return _call;
  }

  CallOptions get toCallOptions => new CallOptions(providers: [authenticate]);
}

Future<Null> main() async {
  final serviceAccountFile = new File('logging-service-account.json');
  if (!serviceAccountFile.existsSync()) {
    print('File logging-service-account.json not found. Please follow the '
        'steps in README.md to create it.');
    exit(-1);
  }

  final scopes = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/logging.write',
  ];

  final authenticator = new ServiceAccountAuthenticator(
      serviceAccountFile.readAsStringSync(), scopes);
  final projectId = authenticator.projectId;

  final channel = new ClientChannel('logging.googleapis.com',
      options: const ChannelOptions.secure());
  final logging =
      new LoggingServiceV2Client(channel, options: authenticator.toCallOptions);

  final request = new WriteLogEntriesRequest()
    ..entries.add(new LogEntry()
      ..logName = 'projects/$projectId/logs/example'
      ..severity = LogSeverity.INFO
      ..resource = (new MonitoredResource()..type = 'global')
      ..textPayload = 'This is a log entry!');
  await logging.writeLogEntries(request);

  await channel.shutdown();
}
