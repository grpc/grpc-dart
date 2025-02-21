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
import 'package:grpc/grpc_web.dart';
import 'package:grpc_web/app.dart';
import 'package:grpc_web/src/generated/echo.pbgrpc.dart';
import 'package:web/web.dart';

void main() {
  final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080'));
  final service = EchoServiceClient(channel);
  final app = EchoApp(service);

  final button = document.querySelector('#send') as HTMLButtonElement;
  button.onClick.listen((e) async {
    final msg = document.querySelector('#msg') as HTMLInputElement;
    final value = msg.value.trim();
    msg.value = '';

    if (value.isEmpty) return;

    if (value.indexOf(' ') > 0) {
      final countStr = value.substring(0, value.indexOf(' '));
      final count = int.tryParse(countStr);

      if (count != null) {
        app.repeatEcho(value.substring(value.indexOf(' ') + 1), count);
      } else {
        app.echo(value);
      }
    } else {
      app.echo(value);
    }
  });
}
