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
import 'dart:html';

import 'package:grpc/grpc.dart';
import 'package:grpc_web/src/generated/echo.pb.dart';
import 'package:grpc_web/src/generated/echo.pbgrpc.dart';

void main() {
  final channel = new ClientChannel('http://localhost',
    port: 8080,
    options: const ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      transportType: TransportType.Xhr
    ));
  final service = EchoServiceClient(channel);

  final button = querySelector("#send") as ButtonElement;
  button.onClick.listen((e) async {
    final msg = querySelector("#msg") as TextInputElement;
    final value = msg.value.trim();
    msg.value = '';

    if (value.isEmpty) 
      return false;

    if (value.indexOf(' ') > 0) {
      final countStr = value.substring(0, value.indexOf(' '));
      final count = int.tryParse(countStr);

      if (count != null) {
        repeatEcho(service, value.substring(value.indexOf(' ') + 1), count);
      } else {
        echo(service, value);
      }
    } else {
      echo(service, value);
    }
  });
}

Future<void> repeatEcho(EchoServiceClient service, String message, int count) async {
  int responseCount = 0;
  final request = ServerStreamingEchoRequest()
    ..message = message
    ..messageCount = count
    ..messageInterval = 500;
  service.serverStreamingEcho(request)
    .listen((response) {
      print("Response from GRPC-Web Streaming: ${response.message} - ${responseCount}");
      responseCount++;
    }, onDone: () => print('Closed connection to server.'));
}

Future<void> echo(EchoServiceClient service, String message) async {
  final response = await service.echo(new EchoRequest()..message = message);
  print('Response from GRPC-Web: ${response.message}');
}