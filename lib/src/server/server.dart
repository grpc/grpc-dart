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
import 'dart:io';

import 'package:http2/transport.dart';

import '../shared/security.dart';

import 'handler.dart';
import 'service.dart';

/// A gRPC server.
///
/// Listens for incoming RPCs, dispatching them to the right [Service] handler.
class Server {
  final Map<String, Service> _services = {};
  final int port;
  final SecurityContext _securityContext;

  ServerSocket _insecureServer;
  SecureServerSocket _secureServer;
  final _connections = <ServerTransportConnection>[];

  Server._(List<Service> services, this.port, this._securityContext) {
    for (final service in services) {
      _services[service.$name] = service;
    }
  }

  /// Create a server for the given [services] with no transport security,
  /// listening on [port].
  factory Server.insecure(List<Service> services, {int port}) {
    return new Server._(services, port ?? 80, null);
  }

  /// Create a secure server for the given [services], listening on [port].
  ///
  /// If the [certificate] or [privateKey] is encrypted, the password must also
  /// be provided.
  factory Server.secure(List<Service> services,
      {List<int> certificate,
      String certificatePassword,
      List<int> privateKey,
      String privateKeyPassword,
      int port}) {
    final context = createSecurityContext(true);
    if (privateKey != null) {
      context.usePrivateKeyBytes(privateKey, password: privateKeyPassword);
    }
    if (certificate != null) {
      context.useCertificateChainBytes(certificate,
          password: certificatePassword);
    }
    return new Server._(services, port ?? 443, context);
  }

  Service lookupService(String service) => _services[service];

  Future<Null> serve() async {
    // TODO(dart-lang/grpc-dart#9): Handle HTTP/1.1 upgrade to h2c, if allowed.
    Stream<Socket> server;
    if (_securityContext != null) {
      _secureServer =
          await SecureServerSocket.bind('0.0.0.0', port, _securityContext);
      server = _secureServer;
    } else {
      _insecureServer = await ServerSocket.bind('0.0.0.0', port);
      server = _insecureServer;
    }
    server.listen((socket) {
      final connection = new ServerTransportConnection.viaSocket(socket);
      _connections.add(connection);
      // TODO(jakobr): Set active state handlers, close connection after idle
      // timeout.
      connection.incomingStreams.listen(serveStream, onError: (error) {
        print('Connection error: $error');
      }, onDone: () {
        _connections.remove(connection);
      });
    }, onError: (error) {
      print('Socket error: $error');
    });
  }

  void serveStream(ServerTransportStream stream) {
    new ServerHandler(lookupService, stream).handle();
  }

  Future<Null> shutdown() {
    final done = _connections.map((connection) => connection.finish()).toList();
    if (_insecureServer != null) {
      done.add(_insecureServer.close());
    }
    if (_secureServer != null) {
      done.add(_secureServer.close());
    }
    return Future.wait(done);
  }
}
