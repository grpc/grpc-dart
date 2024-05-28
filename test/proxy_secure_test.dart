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

@TestOn('vm')
library;

import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  late Server server;
  late EchoServiceClient fakeClient;
  late ClientChannel fakeChannel;

  setUp(() async {
    server = Server.create(services: [FakeEchoService()]);
    await server.serve(
      address: 'localhost',
      port: 8888,
      security: ServerTlsCredentials(
        certificate: File('test/data/localhost.crt').readAsBytesSync(),
        privateKey: File('test/data/localhost.key').readAsBytesSync(),
      ),
    );
    final proxy = Proxy(host: 'localhost', port: 8080);
    final proxyCAName = '/CN=mitmproxy/O=mitmproxy';

    fakeChannel = ClientChannel(
      'localhost',
      port: server.port!,
      options: ChannelOptions(
        credentials: ChannelCredentials.secure(
          certificates: File('test/data/localhost.crt').readAsBytesSync(),
          authority: 'localhost',
          onBadCertificate: (certificate, host) {
            /// Workaround to avoid having to add the proxy to our list of
            /// trusted CAs.
            return certificate.issuer == proxyCAName;
          },
        ),
        proxy: proxy,
      ),
    );
    fakeClient = EchoServiceClient(fakeChannel);
  });

  tearDown(() async {
    await fakeChannel.shutdown();
    await server.shutdown();
  });

  test(
    'Sending and receiving over secure proxy works',
    () async {
      final echoRequest = EchoRequest(message: 'blablablubb');
      final echoResponse = await fakeClient.echo(echoRequest);
      expect(echoResponse.message, 'blibliblabb');
    },
    skip: 'Run this test iff you have a proxy running.',
  );
}

class FakeEchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    expect(request.message, 'blablablubb');
    return EchoResponse(message: 'blibliblabb');
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
          ServiceCall call, ServerStreamingEchoRequest request) =>
      throw UnimplementedError();
}
