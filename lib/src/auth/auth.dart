// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
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

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/src/crypto/rsa_sign.dart';
import 'package:grpc/src/shared/status.dart';
import 'package:http/http.dart' as http;

import '../client/options.dart';

const _tokenExpirationThreshold = const Duration(seconds: 30);

abstract class BaseAuthenticator {
  auth.AccessToken _accessToken;
  String _lastUri;

  Future<Null> authenticate(Map<String, String> metadata, String uri) async {
    if (uri == null) {
      throw new GrpcError.unauthenticated(
          'Credentials require secure transport.');
    }
    if (_accessToken == null || _accessToken.hasExpired || uri != _lastUri) {
      await obtainAccessCredentials(uri);
      _lastUri = uri;
    }

    final auth = '${_accessToken.type} ${_accessToken.data}';
    metadata['authorization'] = auth;

    if (_tokenExpiresSoon) {
      // Token is about to expire. Extend it prematurely.
      obtainAccessCredentials(_lastUri).catchError((_) {});
    }
  }

  bool get _tokenExpiresSoon => _accessToken.expiry
      .subtract(_tokenExpirationThreshold)
      .isBefore(new DateTime.now().toUtc());

  CallOptions get toCallOptions => new CallOptions(providers: [authenticate]);

  Future<Null> obtainAccessCredentials(String uri);
}

abstract class HttpBasedAuthenticator extends BaseAuthenticator {
  Future<Null> _call;

  Future<Null> obtainAccessCredentials(String uri) {
    if (_call == null) {
      final authClient = new http.Client();
      _call = obtainCredentialsWithClient(authClient, uri).then((credentials) {
        _accessToken = credentials.accessToken;
        _call = null;
        authClient.close();
      });
    }
    return _call;
  }

  Future<auth.AccessCredentials> obtainCredentialsWithClient(
      http.Client client, String uri);
}

class ComputeEngineAuthenticator extends HttpBasedAuthenticator {
  Future<auth.AccessCredentials> obtainCredentialsWithClient(
          http.Client client, String uri) =>
      auth.obtainAccessCredentialsViaMetadataServer(client);
}

class ServiceAccountAuthenticator extends HttpBasedAuthenticator {
  auth.ServiceAccountCredentials _serviceAccountCredentials;
  final List<String> _scopes;
  String _projectId;

  ServiceAccountAuthenticator(String serviceAccountJson, this._scopes) {
    final serviceAccount = jsonDecode(serviceAccountJson);
    _serviceAccountCredentials =
        new auth.ServiceAccountCredentials.fromJson(serviceAccount);
    _projectId = serviceAccount['project_id'];
  }

  String get projectId => _projectId;

  Future<auth.AccessCredentials> obtainCredentialsWithClient(
          http.Client client, String uri) =>
      auth.obtainAccessCredentialsViaServiceAccount(
          _serviceAccountCredentials, _scopes, client);
}

class JwtServiceAccountAuthenticator extends BaseAuthenticator {
  auth.ServiceAccountCredentials _serviceAccountCredentials;
  String _projectId;
  String _keyId;

  JwtServiceAccountAuthenticator(String serviceAccountJson) {
    final serviceAccount = jsonDecode(serviceAccountJson);
    _serviceAccountCredentials =
        new auth.ServiceAccountCredentials.fromJson(serviceAccount);
    _projectId = serviceAccount['project_id'];
    _keyId = serviceAccount['private_key_id'];
  }

  String get projectId => _projectId;

  Future<Null> obtainAccessCredentials(String uri) async {
    _accessToken = _jwtTokenFor(_serviceAccountCredentials, _keyId, uri);
  }
}

// TODO(jakobr): Expose in googleapis_auth.
auth.AccessToken _jwtTokenFor(
    auth.ServiceAccountCredentials credentials, String keyId, String uri,
    {String user, List<String> scopes}) {
  // Subtracting 20 seconds from current timestamp to allow for clock skew among
  // servers.
  final timestamp =
      (new DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000) - 20;
  final expiry = timestamp + 3600;

  final header = <String, String>{'alg': 'RS256', 'typ': 'JWT'};
  if (keyId != null) {
    header['kid'] = keyId;
  }

  final claims = <String, dynamic>{
    'iss': credentials.email,
    'aud': uri,
    'exp': expiry,
    'iat': timestamp,
    'sub': user ?? credentials.email
  };
  if (scopes != null) {
    claims['scope'] = scopes.join(' ');
  }

  final headerBase64 = _base64url(ascii.encode(jsonEncode(header)));
  final claimsBase64 = _base64url(utf8.encode(jsonEncode(claims)));

  final data = '$headerBase64.$claimsBase64';

  final signer = new RS256Signer(credentials.privateRSAKey);
  final signature = signer.sign(ascii.encode(data));

  final jwt = '$data.${_base64url(signature)}';

  return new auth.AccessToken('Bearer', jwt,
      new DateTime.fromMillisecondsSinceEpoch(expiry * 1000, isUtc: true));
}

String _base64url(List<int> bytes) {
  return base64Url.encode(bytes).replaceAll('=', '');
}
