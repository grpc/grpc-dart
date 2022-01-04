import 'dart:async';
import 'dart:html';

import 'package:grpc_web/src/generated/echo.pbgrpc.dart';

class EchoApp {
  final EchoServiceClient _service;

  EchoApp(this._service);

  Future<void> echo(String message) async {
    _addLeftMessage(message);

    try {
      final response = await _service.echo(EchoRequest()..message = message);
      _addRightMessage(response.message);
    } catch (error) {
      _addRightMessage(error.toString());
    }
  }

  void repeatEcho(String message, int count) {
    _addLeftMessage(message);
    final request = ServerStreamingEchoRequest()
      ..message = message
      ..messageCount = count
      ..messageInterval = 500;
    _service.serverStreamingEcho(request).listen((response) {
      _addRightMessage(response.message);
    }, onError: (error) {
      _addRightMessage(error.toString());
    }, onDone: () => print('Closed connection to server.'));
  }

  void _addLeftMessage(String message) {
    _addMessage(message, 'label-primary pull-left');
  }

  void _addRightMessage(String message) {
    _addMessage(message, 'label-default pull-right');
  }

  void _addMessage(String message, String cssClass) {
    final classes = cssClass.split(' ');
    querySelector('#first')!.after(DivElement()
      ..classes.add('row')
      ..append(Element.tag('h2')
        ..append(SpanElement()
          ..classes.add('label')
          ..classes.addAll(classes)
          ..text = message)));
  }
}
