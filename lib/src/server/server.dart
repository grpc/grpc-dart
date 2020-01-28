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
import 'package:meta/meta.dart';

import '../shared/security.dart';

import 'handler.dart';
import 'interceptor.dart';
import 'service.dart';

class ServerTlsCredentials {
  final List<int> certificate;
  final String certificatePassword;
  final List<int> privateKey;
  final String privateKeyPassword;

  /// TLS credentials for a [Server].
  ///
  /// If the [certificate] or [privateKey] is encrypted, the password must also
  /// be provided.
  ServerTlsCredentials(
      {this.certificate,
      this.certificatePassword,
      this.privateKey,
      this.privateKeyPassword});

  SecurityContext get securityContext {
    final context = createSecurityContext(true);
    if (privateKey != null) {
      context.usePrivateKeyBytes(privateKey, password: privateKeyPassword);
    }
    if (certificate != null) {
      context.useCertificateChainBytes(certificate,
          password: certificatePassword);
    }
    return context;
  }
}

/// A gRPC server.
///
/// Listens for incoming RPCs, dispatching them to the right [Service] handler.
class Server {
  final Map<String, Service> _services = {};
  final List<Interceptor> _interceptors;

  ServerSocket _insecureServer;
  SecureServerSocket _secureServer;
  final _connections = <ServerTransportConnection>[];

  /// Create a server for the given [services].
  Server(List<Service> services,
      [List<Interceptor> interceptors = const <Interceptor>[]])
      : _interceptors = interceptors {
    for (final service in services) {
      _services[service.$name] = service;
    }
  }

  /// The port that the server is listening on, or `null` if the server is not
  /// active.
  int get port {
    if (_secureServer != null) return _secureServer.port;
    if (_insecureServer != null) return _insecureServer.port;
    return null;
  }

  Service lookupService(String service) => _services[service];

  Future<void> serve(
      {dynamic address,
      int port,
      ServerTlsCredentials security,
      ServerSettings http2ServerSettings,
      int backlog: 0,
      bool v6Only: false,
      bool shared: false}) async {
    // TODO(dart-lang/grpc-dart#9): Handle HTTP/1.1 upgrade to h2c, if allowed.
    Stream<Socket> server;
    if (security != null) {
      _secureServer = await SecureServerSocket.bind(
          address ?? InternetAddress.anyIPv4,
          port ?? 443,
          security.securityContext,
          backlog: backlog,
          shared: shared,
          v6Only: v6Only);
      server = _secureServer;
    } else {
      _insecureServer = await ServerSocket.bind(
          address ?? InternetAddress.anyIPv4, port ?? 80, backlog: backlog, shared: shared , v6Only: v6Only);
      server = _insecureServer;
    }
    server.listen((socket) {
      socket.setOption(SocketOption.tcpNoDelay, true);
      final connection = ServerTransportConnection.viaSocket(socket,
          settings: http2ServerSettings);
      _connections.add(connection);
      ServerHandler_ handler;
      // TODO(jakobr): Set active state handlers, close connection after idle
      // timeout.
      connection.incomingStreams.listen((stream) {
        handler = serveStream_(stream);
      }, onError: (error) {
        print('Connection error: $error');
      }, onDone: () {
        // TODO(sigurdm): This is not correct behavior in the presence of
        // half-closed tcp streams.
        // Half-closed  streams seems to not be fully supported by package:http2.
        // https://github.com/dart-lang/http2/issues/42
        handler?.cancel();
        _connections.remove(connection);
      });
    }, onError: (error) {
      print('Socket error: $error');
    });
  }

  @visibleForTesting
  ServerHandler_ serveStream_(ServerTransportStream stream) {
    return ServerHandler_(lookupService, stream, _interceptors)..handle();
  }

  @Deprecated(
      'This is internal functionality, and will be removed in next major version.')
  void serveStream(ServerTransportStream stream) {
    serveStream_(stream);
  }

  Future<void> shutdown() async {
    final done = _connections.map((connection) => connection.finish()).toList();
    if (_insecureServer != null) {
      done.add(_insecureServer.close());
    }
    if (_secureServer != null) {
      done.add(_secureServer.close());
    }
    await Future.wait(done);
    _insecureServer = null;
    _secureServer = null;
  }
}
