import 'dart:async';
import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'auth.dart';

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
        auth.ServiceAccountCredentials.fromJson(serviceAccount);
    _projectId = serviceAccount['project_id'];
  }

  String get projectId => _projectId;

  Future<auth.AccessCredentials> obtainCredentialsWithClient(
          http.Client client, String uri) =>
      auth.obtainAccessCredentialsViaServiceAccount(
          _serviceAccountCredentials, _scopes, client);
}
