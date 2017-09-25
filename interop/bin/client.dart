// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';

import 'package:interop/src/client.dart';

/// Clients implement test cases that test certain functionally. Each client is
/// provided the test case it is expected to run as a command-line parameter.
/// Names should be lowercase and without spaces.
///
/// Clients should accept these arguments:
///
/// --server_host=HOSTNAME
///   The server host to connect to. For example, "localhost" or "127.0.0.1"
/// --server_host_override=HOSTNAME
///   The server host to claim to be connecting to, for use in TLS and HTTP/2
///   :authority header. If unspecified, the value of --server_host will be used
/// --server_port=PORT
///   The server port to connect to. For example, "8080"
/// --test_case=TESTCASE
///   The name of the test case to execute. For example, "empty_unary"
/// --use_tls=BOOLEAN
///   Whether to use a plaintext or encrypted connection
/// --use_test_ca=BOOLEAN
///   Whether to replace platform root CAs with ca.pem as the CA root
/// --default_service_account=ACCOUNT_EMAIL
///   Email of the GCE default service account.
/// --oauth_scope=SCOPE
///   OAuth scope. For example, "https://www.googleapis.com/auth/xapi.zoo"
/// --service_account_key_file=PATH
///   The path to the service account JSON key file generated from GCE developer
///   console.
///
/// Clients must support TLS with ALPN. Clients must not disable certificate
/// checking.
Future<int> main(List<String> args) async {
  final argumentParser = new ArgParser();
  argumentParser.addOption('server_host',
      help: 'The server host to connect to. For example, "localhost" or '
          '"127.0.0.1".');
  argumentParser.addOption('server_host_override',
      help: 'The server host to claim to be connecting to, for use in TLS and '
          'HTTP/2 :authority header. If unspecified, the value of --server_host'
          ' will be used.');
  argumentParser.addOption('server_port',
      help: 'The server port to connect to. For example, "8080".');
  argumentParser.addOption('test_case',
      help:
          'The name of the test case to execute. For example, "empty_unary".');
  argumentParser.addOption('use_tls',
      defaultsTo: 'false',
      help: 'Whether to use a plaintext or encrypted connection.');
  argumentParser.addOption('use_test_ca',
      help: 'Whether to replace platform root CAs with ca.pem as the CA root.');
  argumentParser.addOption('default_service_account',
      help: 'Email of the GCE default service account.');
  argumentParser.addOption('oauth_scope',
      help: 'OAuth scope. For example, '
          '"https://www.googleapis.com/auth/xapi.zoo".');
  argumentParser.addOption('service_account_key_file',
      help: 'The path to the service account JSON key file generated from GCE '
          'developer console.');
  final arguments = argumentParser.parse(args);

  final testClient = new Tester();

  testClient.serverHost = arguments['server_host'];
  testClient.serverHostOverride = arguments['server_host_override'];
  testClient.serverPort = arguments['server_port'];
  testClient.testCase = arguments['test_case'];
  testClient.useTls = arguments['use_tls'];
  testClient.useTestCA = arguments['use_test_ca'];
  testClient.defaultServiceAccount = arguments['default_service_account'];
  testClient.oauthScope = arguments['oauth_scope'];
  testClient.serviceAccountKeyFile = arguments['service_account_key_file'];

  if (!testClient.validate()) {
    print(argumentParser.usage);
    return -1;
  }
  await testClient.runTest();
  print('Passed.');
  return 0;
}
