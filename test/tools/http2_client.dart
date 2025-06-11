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

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/http2.dart';

Future<void> main(List<String> args) async {
  final serverPort = 0;
  final proxyPort = int.tryParse(args.first);

  final proxy = proxyPort != null
      ? Proxy(host: 'localhost', port: proxyPort)
      : null;

  final port = proxyPort ?? serverPort;

  final connector = SocketTransportConnector(
    'localhost',
    serverPort,
    ChannelOptions(proxy: proxy),
  );
  await connector.initSocket('localhost', port);
  final incoming = proxy == null
      ? connector.socket
      : await connector.connectToProxy(proxy);

  final uri = Uri.parse('http://localhost:0');

  final transport = ClientTransportConnection.viaStreams(
    incoming,
    connector.socket,
  );

  final request = transport.makeRequest([
    Header.ascii(':method', 'GET'),
    Header.ascii(':path', uri.path),
    Header.ascii(':scheme', uri.scheme),
    Header.ascii(':authority', uri.host),
  ], endStream: true);

  await for (var message in request.incomingMessages) {
    if (message is HeadersStreamMessage) {
      for (var header in message.headers) {
        final name = utf8.decode(header.name);
        final value = utf8.decode(header.value);
        print('Header: $name: $value');
      }
    } else if (message is DataStreamMessage) {
      print(message.bytes);
    }
  }
}
