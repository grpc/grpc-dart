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

import 'package:args/args.dart';

import 'package:interop/src/client.dart';

const _serverHostArgument = 'server_host';
const _serverHostOverrideArgument = 'server_host_override';
const _serverPortArgument = 'server_port';
const _testCaseArgument = 'test_case';
const _useTLSArgument = 'use_tls';
const _useTestCAArgument = 'use_test_ca';
const _defaultServiceAccountArgument = 'default_service_account';
const _oauthScopeArgument = 'oauth_scope';
const _serviceAccountKeyFileArgument = 'service_account_key_file';

/// Clients implement test cases that test certain functionally. Each client is
/// provided the test case it is expected to run as a command-line parameter.
/// Names should be lowercase and without spaces.
///
/// Clients should accept these arguments:
///
/// * --server_host=HOSTNAME
///     * The server host to connect to. For example, "localhost" or "127.0.0.1"
/// * --server_host_override=HOSTNAME
///     * The server host to claim to be connecting to, for use in TLS and
///       HTTP/2 :authority header. If unspecified, the value of --server_host
///       will be used
/// * --server_port=PORT
///     * The server port to connect to. For example, "8080"
/// * --test_case=TESTCASE
///     * The name of the test case to execute. For example, "empty_unary"
/// * --use_tls=BOOLEAN
///     * Whether to use a plaintext or encrypted connection
/// * --use_test_ca=BOOLEAN
///     * Whether to replace platform root CAs with ca.pem as the CA root
/// * --default_service_account=ACCOUNT_EMAIL
///     * Email of the GCE default service account.
/// * --oauth_scope=SCOPE
///     * OAuth scope. For example, "https://www.googleapis.com/auth/xapi.zoo"
/// * --service_account_key_file=PATH
///     * The path to the service account JSON key file generated from GCE
///       developer console.
///
/// Clients must support TLS with ALPN. Clients must not disable certificate
/// checking.
Future<int> main(List<String> args) async {
  final argumentParser = ArgParser();
  argumentParser.addOption(
    _serverHostArgument,
    help:
        'The server host to connect to. For example, "localhost" or '
        '"127.0.0.1".',
  );
  argumentParser.addOption(
    _serverHostOverrideArgument,
    help:
        'The server host to claim to be connecting to, for use in TLS and '
        'HTTP/2 :authority header. If unspecified, the value of '
        '--server_host will be used.',
  );
  argumentParser.addOption(
    _serverPortArgument,
    help: 'The server port to connect to. For example, "8080".',
  );
  argumentParser.addOption(
    _testCaseArgument,
    help: 'The name of the test case to execute. For example, "empty_unary".',
  );
  argumentParser.addOption(
    _useTLSArgument,
    defaultsTo: 'false',
    help: 'Whether to use a plaintext or encrypted connection.',
  );
  argumentParser.addOption(
    _useTestCAArgument,
    defaultsTo: 'false',
    help: 'Whether to replace platform root CAs with ca.pem as the CA root.',
  );
  argumentParser.addOption(
    _defaultServiceAccountArgument,
    help: 'Email of the GCE default service account.',
  );
  argumentParser.addOption(
    _oauthScopeArgument,
    help:
        'OAuth scope. For example, '
        '"https://www.googleapis.com/auth/xapi.zoo".',
  );
  argumentParser.addOption(
    _serviceAccountKeyFileArgument,
    help:
        'The path to the service account JSON key file generated from GCE '
        'developer console.',
  );
  final arguments = argumentParser.parse(args);

  late Tester testClient;
  try {
    testClient = Tester(
      serverHost:
          arguments[_serverHostArgument] ??
          (throw 'Must specify --$_serverHostArgument'),
      serverHostOverride: arguments[_serverHostOverrideArgument],
      serverPort:
          int.tryParse(
            arguments[_serverPortArgument] ??
                (throw 'Must specify --$_serverPortArgument'),
          ) ??
          (throw 'Invalid port "${arguments[_serverPortArgument]}"'),
      testCase:
          arguments[_testCaseArgument] ??
          (throw 'Must specify --$_testCaseArgument'),
      useTls: arguments[_useTLSArgument] == 'true',
      useTestCA: arguments[_useTestCAArgument] == 'true',
      defaultServiceAccount: arguments[_defaultServiceAccountArgument],
      oauthScope: arguments[_oauthScopeArgument],
      serviceAccountKeyFile: arguments[_serviceAccountKeyFileArgument],
    );
  } catch (e) {
    print(e);
    print(argumentParser.usage);
    return -1;
  }
  await testClient.runTest();
  print('Passed.');
  return 0;
}
