import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:grpc/src/client/proxy.dart';
import 'package:http2/http2.dart';

Future<void> main(List<String> args) async {
  final serverPort = 5678;
  final proxyPort = int.tryParse(args.first);

  final proxy =
      proxyPort != null ? Proxy(host: 'localhost', port: proxyPort) : null;

  final port = proxyPort ?? serverPort;

  final connector = SocketTransportConnector(
    'localhost',
    serverPort,
    ChannelOptions(proxy: proxy),
  );
  await connector.initSocket('localhost', port);
  final incoming =
      proxy == null ? connector.socket : await connector.connectToProxy(proxy);

  final uri = Uri.parse('http://localhost:8080');

  final transport =
      ClientTransportConnection.viaStreams(incoming, connector.socket);

  final request = transport.makeRequest(
    [
      Header.ascii(':method', 'GET'),
      Header.ascii(':path', uri.path),
      Header.ascii(':scheme', uri.scheme),
      Header.ascii(':authority', uri.host),
    ],
    endStream: true,
  );

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
