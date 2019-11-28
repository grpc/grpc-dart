// Copyright (c) 2019, the gRPC project authors. Please see the AUTHORS file
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

/// Dart implementation of the gRPC helloworld.Greeter server.
import 'dart:async';
import "dart:io";
import "dart:isolate";

import 'package:grpc/grpc.dart';

import 'package:isolate_service/src/generated/helloworld.pb.dart';
import 'package:isolate_service/src/generated/helloworld.pbgrpc.dart';

import "package:isolate/isolate_runner.dart";
import "package:isolate/ports.dart";
import "package:isolate/runner.dart";
import 'package:logging/logging.dart' show Logger, Level, LogRecord;

class GreeterService extends GreeterServiceBase {
  static final Logger _log = new Logger('GreeterService');
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    _log.info("sayHello name='${request.name}'");
    return HelloReply()..message = 'Hello, ${request.name}!';
  }
}

void initLog([String isolateMarker]) {
  if (isolateMarker == null) {
    isolateMarker = "I${Isolate.current.hashCode}";
  }
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    if (rec.error != null) {
      print(
          '[$isolateMarker] ${rec.level.name}:${rec.loggerName} ${rec.time}: ${rec.message} ${rec.error}');
    } else {
      print(
          '[$isolateMarker] ${rec.level.name}:${rec.loggerName} ${rec.time}: ${rec.message}');
    }
  });
}

final Logger _log = new Logger('main');

Future<void> main(List<String> args) async {
  const int isolateCount = 5;
  final dynamic address = InternetAddress.anyIPv4;
  int port = 50051;

  initLog("main");

  if (args.isNotEmpty) {
    port = int.parse(args[0]);
  }

  _log.info(
      "Run isolateCount = $isolateCount, address = $address, port = $port");

  // Used to ensure the requested port is available or to find an available
  // port if `0` is provided.
  final ServerSocket socket =
      await ServerSocket.bind(address, port, shared: true);

  port = socket.port;
  final isolates = await Future.wait(
      Iterable.generate(isolateCount, (_) => IsolateRunner.spawn()),
      cleanUp: (isolate) {
    isolate.close();
  });

  final List<Future<Object> Function()> stoppers =
      await Future.wait(isolates.map((IsolateRunner isolate) {
    return runService(isolate, address, socket.port);
  }), cleanUp: (shutdownServer) {
    shutdownServer();
  });

  await socket.close();

  await ProcessSignal.sigint.watch().first;
  for (var stopper in stoppers) {
    await stopper();
  }
  _log.info("Finished");
}

int _isolateId = 0;
Future<Future<Object> Function()> runService(
    Runner runner, dynamic address, int port) async {
  final SendPort stopPort =
      await runner.run(_startIsolateServer, [address, port, ++_isolateId]);
  return () => _sendStop(stopPort);
}

Future _sendStop(SendPort stopPort) => singleResponseFuture(stopPort.send);

Future<SendPort> _startIsolateServer(List args) async {
  final dynamic address = args[0];
  final int port = args[1];
  initLog(args.length > 2 ? "I${args[2]}" : null);

  final server = Server([GreeterService()]);
  await server.serve(address: address, port: port, shared: true);
  _log.info('Service listening on port ${server.port}...');

  return singleCallbackPort((SendPort resultPort) {
    _log.info('Service shutdowning...');
    sendFutureResult(Future.sync(server.shutdown), resultPort);
  });
}
