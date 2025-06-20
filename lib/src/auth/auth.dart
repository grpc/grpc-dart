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

import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;

import '../client/call.dart';
import 'rsa.dart';

const _tokenExpirationThreshold = Duration(seconds: 30);

abstract class BaseAuthenticator {
  auth.AccessToken? _accessToken;
  late String _lastUri;
  var _lastUriSet = false;

  Future<void> authenticate(Map<String, String> metadata, String uri) async {
    if (_accessToken == null ||
        _accessToken!.hasExpired ||
        !_lastUriSet ||
        uri != _lastUri) {
      await obtainAccessCredentials(uri);
      _lastUri = uri;
      _lastUriSet = true;
    }

    final auth = '${_accessToken!.type} ${_accessToken!.data}';
    metadata['authorization'] = auth;

    if (_tokenExpiresSoon) {
      // Token is about to expire. Extend it prematurely.
      obtainAccessCredentials(_lastUri).catchError((_) {});
    }
  }

  bool get _tokenExpiresSoon => _accessToken!.expiry
      .subtract(_tokenExpirationThreshold)
      .isBefore(DateTime.now().toUtc());

  CallOptions get toCallOptions => CallOptions(providers: [authenticate]);

  Future<void> obtainAccessCredentials(String uri);
}

abstract class HttpBasedAuthenticator extends BaseAuthenticator {
  Future<void>? _call;

  @override
  Future<void> obtainAccessCredentials(String uri) {
    if (_call == null) {
      final authClient = http.Client();
      _call = obtainCredentialsWithClient(authClient, uri).then((credentials) {
        _accessToken = credentials.accessToken;
        _call = null;
        authClient.close();
      });
    }
    return _call!;
  }

  Future<auth.AccessCredentials> obtainCredentialsWithClient(
    http.Client client,
    String uri,
  );
}

class JwtServiceAccountAuthenticator extends BaseAuthenticator {
  auth.ServiceAccountCredentials _serviceAccountCredentials;
  String? _projectId;
  String? _keyId;

  JwtServiceAccountAuthenticator.fromJson(
    Map<String, dynamic> serviceAccountJson,
  ) : _serviceAccountCredentials = auth.ServiceAccountCredentials.fromJson(
        serviceAccountJson,
      ),
      _projectId = serviceAccountJson['project_id'],
      _keyId = serviceAccountJson['private_key_id'];

  factory JwtServiceAccountAuthenticator(String serviceAccountJsonString) =>
      JwtServiceAccountAuthenticator.fromJson(
        jsonDecode(serviceAccountJsonString),
      );

  String? get projectId => _projectId;

  @override
  Future<void> obtainAccessCredentials(String uri) async {
    _accessToken = _jwtTokenFor(_serviceAccountCredentials, _keyId, uri);
  }
}

// TODO(jakobr): Expose in googleapis_auth.
auth.AccessToken _jwtTokenFor(
  auth.ServiceAccountCredentials credentials,
  String? keyId,
  String uri, {
  String? user,
  List<String>? scopes,
}) {
  // Subtracting 20 seconds from current timestamp to allow for clock skew among
  // servers.
  final timestamp =
      (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000) - 20;
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
    'sub': user ?? credentials.email,
  };
  if (scopes != null) {
    claims['scope'] = scopes.join(' ');
  }

  final headerBase64 = _base64url(ascii.encode(jsonEncode(header)));
  final claimsBase64 = _base64url(utf8.encode(jsonEncode(claims)));

  final data = '$headerBase64.$claimsBase64';

  final key = credentials.privateRSAKey;
  // We convert to our internal version of RSAPrivateKey. See rsa.dart for more
  // explanation.
  final signer = RS256Signer(
    RSAPrivateKey(
      key.n,
      key.e,
      key.d,
      key.p,
      key.q,
      key.dmp1,
      key.dmq1,
      key.coeff,
    ),
  );
  final signature = signer.sign(ascii.encode(data));

  final jwt = '$data.${_base64url(signature)}';

  return auth.AccessToken(
    'Bearer',
    jwt,
    DateTime.fromMillisecondsSinceEpoch(expiry * 1000, isUtc: true),
  );
}

String _base64url(List<int> bytes) {
  return base64Url.encode(bytes).replaceAll('=', '');
}
