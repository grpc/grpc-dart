// Copyright (c) 2026, the gRPC project authors. Please see the AUTHORS file
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

import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:grpc/src/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

final class _SpyClient extends http.BaseClient {
  var closed = false;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnsupportedError('Unexpected HTTP request: ${request.url}');
  }

  @override
  void close() {
    closed = true;
    super.close();
  }
}

final class _TestHttpAuthenticator extends HttpBasedAuthenticator {
  final Future<auth.AccessCredentials> Function(http.Client client, String uri)
  _handler;
  var callCount = 0;

  _TestHttpAuthenticator(this._handler);

  @override
  Future<auth.AccessCredentials> obtainCredentialsWithClient(
    http.Client client,
    String uri,
  ) {
    callCount++;
    return _handler(client, uri);
  }
}

auth.AccessCredentials _credentials(String token, Duration ttl) =>
    auth.AccessCredentials(
      auth.AccessToken('Bearer', token, DateTime.now().toUtc().add(ttl)),
      null,
      const [],
    );

Future<void> _withSpyClients(
  Future<void> Function(List<_SpyClient> clients) body,
) {
  final clients = <_SpyClient>[];
  return http.runWithClient(() => body(clients), () {
    final client = _SpyClient();
    clients.add(client);
    return client;
  });
}

void main() {
  group('HttpBasedAuthenticator', () {
    test(
      'deduplicates concurrent credential fetches and closes client',
      () async {
        final completer = Completer<auth.AccessCredentials>();
        final authenticator = _TestHttpAuthenticator(
          (client, uri) => completer.future,
        );

        await _withSpyClients((clients) async {
          final metadata1 = <String, String>{};
          final metadata2 = <String, String>{};

          final f1 = authenticator.authenticate(
            metadata1,
            'https://example.com',
          );
          final f2 = authenticator.authenticate(
            metadata2,
            'https://example.com',
          );

          expect(authenticator.callCount, 1);
          expect(clients, hasLength(1));
          expect(clients.single.closed, isFalse);

          completer.complete(_credentials('tok-1', const Duration(hours: 1)));
          await Future.wait([f1, f2]);

          expect(metadata1['authorization'], 'Bearer tok-1');
          expect(metadata2['authorization'], 'Bearer tok-1');
          expect(clients.single.closed, isTrue);
        });
      },
    );

    test(
      'recovers and closes client after an asynchronous fetch failure',
      () async {
        var attempt = 0;
        final authenticator = _TestHttpAuthenticator((client, uri) async {
          attempt++;
          if (attempt == 1) {
            throw Exception('Metadata Server not available. (503)');
          }
          return _credentials('tok-recovered', const Duration(hours: 1));
        });

        await _withSpyClients((clients) async {
          final metadata1 = <String, String>{};
          await expectLater(
            authenticator.authenticate(metadata1, 'https://example.com'),
            throwsA(isA<Exception>()),
          );
          expect(clients, hasLength(1));
          expect(clients[0].closed, isTrue);

          final metadata2 = <String, String>{};
          await authenticator.authenticate(metadata2, 'https://example.com');

          expect(authenticator.callCount, 2);
          expect(metadata2['authorization'], 'Bearer tok-recovered');
          expect(clients, hasLength(2));
          expect(clients[1].closed, isTrue);
        });
      },
    );

    test(
      'recovers and closes client after a synchronous fetch failure',
      () async {
        var attempt = 0;
        final authenticator = _TestHttpAuthenticator((client, uri) {
          attempt++;
          if (attempt == 1) {
            throw StateError('sync failure');
          }
          return Future.value(
            _credentials('tok-after-sync', const Duration(hours: 1)),
          );
        });

        await _withSpyClients((clients) async {
          final metadata1 = <String, String>{};
          await expectLater(
            authenticator.authenticate(metadata1, 'https://example.com'),
            throwsA(isA<StateError>()),
          );
          expect(clients, hasLength(1));
          expect(clients[0].closed, isTrue);

          final metadata2 = <String, String>{};
          await authenticator.authenticate(metadata2, 'https://example.com');

          expect(authenticator.callCount, 2);
          expect(metadata2['authorization'], 'Bearer tok-after-sync');
          expect(clients, hasLength(2));
          expect(clients[1].closed, isTrue);
        });
      },
    );

    test(
      'propagates failure to concurrent callers and allows immediate retry',
      () async {
        var attempt = 0;
        final firstCall = Completer<auth.AccessCredentials>();
        final authenticator = _TestHttpAuthenticator((client, uri) {
          attempt++;
          if (attempt == 1) {
            return firstCall.future;
          }
          return Future.value(
            _credentials('tok-retry', const Duration(hours: 1)),
          );
        });

        await _withSpyClients((clients) async {
          final metadata1 = <String, String>{};
          final metadata2 = <String, String>{};

          final f1 = authenticator.authenticate(
            metadata1,
            'https://example.com',
          );
          final f2 = authenticator.authenticate(
            metadata2,
            'https://example.com',
          );
          expect(authenticator.callCount, 1);
          expect(clients, hasLength(1));

          // Attach error expectations before failing so neither future is
          // briefly unhandled.
          final check1 = expectLater(f1, throwsA(isA<Exception>()));
          final check2 = expectLater(f2, throwsA(isA<Exception>()));
          firstCall.completeError(
            Exception('Metadata Server not available. (503)'),
          );
          await Future.wait([check1, check2]);
          expect(clients.single.closed, isTrue);

          final metadata3 = <String, String>{};
          await authenticator.authenticate(metadata3, 'https://example.com');
          expect(authenticator.callCount, 2);
          expect(metadata3['authorization'], 'Bearer tok-retry');
          expect(clients, hasLength(2));
          expect(clients[1].closed, isTrue);
        });
      },
    );

    test(
      'recovers after a failed premature refresh before token expiry',
      () async {
        var attempt = 0;
        late auth.AccessCredentials expiringCredentials;
        final failedRefresh = Completer<auth.AccessCredentials>();
        final authenticator = _TestHttpAuthenticator((client, uri) {
          attempt++;
          if (attempt == 1) {
            // Expires within the 30s premature refresh threshold, so the
            // initial authenticate() triggers a background refresh immediately.
            expiringCredentials = _credentials(
              'tok-expiring',
              const Duration(milliseconds: 20),
            );
            return Future.value(expiringCredentials);
          }
          if (attempt == 2) {
            return failedRefresh.future;
          }
          return Future.value(
            _credentials('tok-refreshed', const Duration(hours: 1)),
          );
        });

        await _withSpyClients((clients) async {
          final metadata1 = <String, String>{};
          await authenticator.authenticate(metadata1, 'https://example.com');
          expect(metadata1['authorization'], 'Bearer tok-expiring');
          // Attempt 1 obtained the expiring token; attempt 2 is the premature
          // background refresh already in flight.
          expect(authenticator.callCount, 2);

          failedRefresh.completeError(
            Exception('Metadata Server not available. (503)'),
          );
          while (!expiringCredentials.accessToken.hasExpired) {
            await Future<void>.delayed(const Duration(milliseconds: 10));
          }
          expect(clients[1].closed, isTrue);

          final metadata2 = <String, String>{};
          await authenticator.authenticate(metadata2, 'https://example.com');
          expect(authenticator.callCount, 3);
          expect(metadata2['authorization'], 'Bearer tok-refreshed');
          expect(clients[2].closed, isTrue);
        });
      },
    );
  });
}
