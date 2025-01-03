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

import 'dart:async';
import 'dart:html';

import 'src/generated/echo.pbgrpc.dart';

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
