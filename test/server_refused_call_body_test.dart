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

@TestOn('vm')
library;

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

class _EchoService extends Service {
  @override
  String get $name => 'test.Echo';

  _EchoService() {
    $addMethod(
      ServiceMethod<List<int>, List<int>>(
        'Echo',
        (ServiceCall call, Future<List<int>> request) => request,
        false,
        false,
        (List<int> bytes) => bytes,
        (List<int> bytes) => bytes,
      ),
    );
  }
}

final _echo = ClientMethod<List<int>, List<int>>(
  '/test.Echo/Echo',
  (List<int> bytes) => bytes,
  (List<int> bytes) => bytes,
);

void main() {
  // A call refused before its handler runs - here by an interceptor - is
  // refused while the server has paused reading its request. Its body must
  // be read all the same: otherwise the connection's flow-control window
  // shrinks by it for good, and the channel stalls once it is used up.
  test(
    'the request bodies of calls refused before the handler runs are consumed',
    () async {
      var refuse = true;
      final server = Server.create(
        services: [_EchoService()],
        interceptors: [
          (ServiceCall call, ServiceMethod<dynamic, dynamic> method) =>
              refuse ? GrpcError.permissionDenied('refused') : null,
        ],
      );
      await server.serve(port: 0);
      final channel = ClientChannel(
        'localhost',
        port: server.port!,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      Future<List<int>> echo(List<int> body) => channel
          .createCall(_echo, Stream.value(body), CallOptions())
          .response
          .single
          .timeout(const Duration(seconds: 10));

      try {
        // well beyond what the connection's window holds
        final body = List<int>.filled(1024 * 1024, 7);
        for (var i = 0; i < 32; i++) {
          await expectLater(
            echo(body),
            throwsA(
              isA<GrpcError>().having(
                (e) => e.code,
                'code',
                StatusCode.permissionDenied,
              ),
            ),
          );
        }

        refuse = false;
        expect(await echo([1, 2, 3]), [1, 2, 3]);
      } finally {
        // a stalled connection never finishes gracefully
        await channel.terminate();
        await server.shutdown();
      }
    },
  );
}
