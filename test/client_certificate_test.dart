// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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

// TODO(dartbug.com/26057) currently Mac OS X seems to have some issues with
// client certificates so we disable the test.
@TestOn('vm && !mac-os')
library;

import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

class EchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    final subject = call.clientCertificate?.subject;
    return (EchoResponse()..message = subject ?? 'NO CERT');
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
    ServiceCall call,
    ServerStreamingEchoRequest request,
  ) {
    // TODO: implement serverStreamingEcho
    throw UnimplementedError();
  }
}

const String address = 'localhost';

Future<void> main() async {
  test('Client certificate required', () async {
    // Server
    final server = await _setUpServer(true);

    // Client
    final channelContext =
        SecurityContextChannelCredentials.baseSecurityContext();
    channelContext.useCertificateChain('test/data/localhost.crt');
    channelContext.usePrivateKey('test/data/localhost.key');
    final channelCredentials = SecurityContextChannelCredentials(
      channelContext,
      onBadCertificate: (cert, s) {
        return true;
      },
    );
    final channel = ClientChannel(
      address,
      port: server.port ?? 443,
      options: ChannelOptions(credentials: channelCredentials),
    );
    final client = EchoServiceClient(channel);

    // Test
    expect((await client.echo(EchoRequest())).message, '/CN=localhost');

    // Clean up
    await channel.shutdown();
    await server.shutdown();
  });

  test('Client certificate not required', () async {
    // Server
    final server = await _setUpServer();

    // Client
    final channelContext =
        SecurityContextChannelCredentials.baseSecurityContext();
    channelContext.useCertificateChain('test/data/localhost.crt');
    channelContext.usePrivateKey('test/data/localhost.key');
    final channelCredentials = SecurityContextChannelCredentials(
      channelContext,
      onBadCertificate: (cert, s) {
        return true;
      },
    );
    final channel = ClientChannel(
      address,
      port: server.port ?? 443,
      options: ChannelOptions(credentials: channelCredentials),
    );
    final client = EchoServiceClient(channel);

    // Test
    expect((await client.echo(EchoRequest())).message, 'NO CERT');

    // Clean up
    await channel.shutdown();
    await server.shutdown();
  });
}

Future<Server> _setUpServer([bool requireClientCertificate = false]) async {
  final server = Server.create(services: [EchoService()]);
  final serverContext = SecurityContextServerCredentials.baseSecurityContext();
  serverContext.useCertificateChain('test/data/localhost.crt');
  serverContext.usePrivateKey('test/data/localhost.key');
  serverContext.setTrustedCertificates('test/data/localhost.crt');
  final ServerCredentials serverCredentials = SecurityContextServerCredentials(
    serverContext,
  );
  await server.serve(
    address: address,
    port: 0,
    security: serverCredentials,
    requireClientCertificate: requireClientCertificate,
  );
  return server;
}

class SecurityContextChannelCredentials extends ChannelCredentials {
  final SecurityContext _securityContext;

  SecurityContextChannelCredentials(
    SecurityContext securityContext, {
    super.authority,
    super.onBadCertificate,
  }) : _securityContext = securityContext,
       super.secure();

  @override
  SecurityContext get securityContext => _securityContext;

  static SecurityContext baseSecurityContext() {
    return createSecurityContext(false);
  }
}

class SecurityContextServerCredentials extends ServerTlsCredentials {
  final SecurityContext _securityContext;

  SecurityContextServerCredentials(SecurityContext securityContext)
    : _securityContext = securityContext,
      super();

  @override
  SecurityContext get securityContext => _securityContext;

  static SecurityContext baseSecurityContext() {
    return createSecurityContext(true);
  }
}
