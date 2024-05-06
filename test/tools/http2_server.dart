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

import 'dart:convert';
import 'dart:io';

import 'package:http2/transport.dart';

void main() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 5678);

  server.listen((client) => handleConnection(client));
}

void handleConnection(Socket client) {
  final connection = ServerTransportConnection.viaSocket(client);
  connection.incomingStreams.listen((stream) {
    stream.incomingMessages.listen((event) {
      if (event is HeadersStreamMessage) {
        print(event.headers);
        final headersStreamMessage = HeadersStreamMessage([
          Header(utf8.encode('SomeName'), utf8.encode('SomeValue')),
        ]);
        print('send $headersStreamMessage');
        stream.outgoingMessages.add(headersStreamMessage);
      }
    });
  });
}
