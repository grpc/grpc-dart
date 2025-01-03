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
