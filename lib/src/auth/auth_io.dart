// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'auth.dart';

class ComputeEngineAuthenticator extends HttpBasedAuthenticator {
  @override
  Future<auth.AccessCredentials> obtainCredentialsWithClient(
    http.Client client,
    String uri,
  ) => auth.obtainAccessCredentialsViaMetadataServer(client);
}

class ServiceAccountAuthenticator extends HttpBasedAuthenticator {
  late auth.ServiceAccountCredentials _serviceAccountCredentials;
  final List<String> _scopes;
  String? _projectId;

  ServiceAccountAuthenticator.fromJson(
    Map<String, dynamic> serviceAccountJson,
    this._scopes,
  ) : _serviceAccountCredentials = auth.ServiceAccountCredentials.fromJson(
        serviceAccountJson,
      ),
      _projectId = serviceAccountJson['project_id'];

  factory ServiceAccountAuthenticator(
    String serviceAccountJsonString,
    List<String> scopes,
  ) => ServiceAccountAuthenticator.fromJson(
    jsonDecode(serviceAccountJsonString),
    scopes,
  );

  String? get projectId => _projectId;

  @override
  Future<auth.AccessCredentials> obtainCredentialsWithClient(
    http.Client client,
    String uri,
  ) => auth.obtainAccessCredentialsViaServiceAccount(
    _serviceAccountCredentials,
    _scopes,
    client,
  );
}

class _CredentialsRefreshingAuthenticator extends HttpBasedAuthenticator {
  final auth.ClientId _clientId;
  auth.AccessCredentials _accessCredentials;
  final String? _quotaProject;

  _CredentialsRefreshingAuthenticator(
    this._clientId,
    this._accessCredentials,
    this._quotaProject,
  );

  @override
  Future<void> authenticate(Map<String, String> metadata, String uri) async {
    await super.authenticate(metadata, uri);
    if (_quotaProject != null) {
      // https://cloud.google.com/apis/docs/system-parameters#definitions
      metadata['X-Goog-User-Project'] = _quotaProject;
    }
  }

  @override
  Future<auth.AccessCredentials> obtainCredentialsWithClient(
    http.Client client,
    String uri,
  ) async {
    _accessCredentials = await auth.refreshCredentials(
      _clientId,
      _accessCredentials,
      client,
    );
    return _accessCredentials;
  }
}

/// Create an [HttpBasedAuthenticator] using [Application Default Credentials][ADC].
///
/// Looks for credentials in the following order of preference:
///  1. A JSON file whose path is specified by `GOOGLE_APPLICATION_CREDENTIALS`,
///     this file typically contains [exported service account keys][svc-keys].
///  2. A JSON file created by [`gcloud auth application-default login`][gcloud-login]
///     in a well-known location (`%APPDATA%/gcloud/application_default_credentials.json`
///     on Windows and `$HOME/.config/gcloud/application_default_credentials.json` on Linux/Mac).
///  3. On Google Compute Engine and App Engine Flex we fetch credentials from
///     [GCE metadata service][metadata].
///
/// [metadata]: https://cloud.google.com/compute/docs/storing-retrieving-metadata
/// [svc-keys]: https://cloud.google.com/docs/authentication/getting-started
/// [gcloud-login]: https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login
/// [ADC]: https://cloud.google.com/docs/authentication/production
Future<HttpBasedAuthenticator> applicationDefaultCredentialsAuthenticator(
  List<String> scopes,
) async {
  File? credFile;
  String? fileSource;
  // If env var specifies a file to load credentials from we'll do that.
  final credsEnv = Platform.environment['GOOGLE_APPLICATION_CREDENTIALS'];
  if (credsEnv != null && credsEnv.isNotEmpty) {
    // If env var is specified and not empty, we always try to load, even if
    // the file doesn't exist.
    credFile = File(credsEnv);
    fileSource = 'GOOGLE_APPLICATION_CREDENTIALS';
  }

  // Attempt to use file created by `gcloud auth application-default login`
  File gcloudAdcFile;
  if (Platform.isWindows) {
    gcloudAdcFile = File.fromUri(
      Uri.directory(
        Platform.environment['APPDATA']!,
      ).resolve('gcloud/application_default_credentials.json'),
    );
  } else {
    gcloudAdcFile = File.fromUri(
      Uri.directory(
        Platform.environment['HOME']!,
      ).resolve('.config/gcloud/application_default_credentials.json'),
    );
  }
  // Only try to load from gcloudAdcFile if it exists.
  if (credFile == null && await gcloudAdcFile.exists()) {
    credFile = gcloudAdcFile;
    fileSource = '`gcloud auth application-default login`';
  }

  // Attempt to load form credFile, if detected
  if (credFile != null) {
    Object? credentials;
    try {
      credentials = json.decode(await credFile.readAsString());
    } on IOException {
      throw Exception('Failed to read credentials file from $fileSource');
    } on FormatException {
      throw Exception(
        'Failed to parse JSON from credentials file from $fileSource',
      );
    }

    if (credentials is Map && credentials['type'] == 'authorized_user') {
      final clientId = auth.ClientId(
        credentials['client_id'],
        credentials['client_secret'],
      );

      final client = http.Client();
      try {
        final accessCreds = await auth.refreshCredentials(
          clientId,
          auth.AccessCredentials(
            // Hack: Create empty credentials that have expired.
            auth.AccessToken('Bearer', '', DateTime(0).toUtc()),
            credentials['refresh_token'],
            scopes,
          ),
          client,
        );
        return _CredentialsRefreshingAuthenticator(
          clientId,
          accessCreds,
          credentials['quota_project_id'],
        );
      } finally {
        client.close();
      }
    }

    return ServiceAccountAuthenticator(json.encode(credentials), scopes);
  }

  return ComputeEngineAuthenticator();
}
