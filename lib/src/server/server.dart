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

import '../shared/codec_registry.dart';
import '../shared/io_bits/io_bits.dart' as io_bits;
import '../shared/security.dart';
import 'handler.dart';
import 'interceptor.dart';
import 'server_keepalive.dart';
import 'service.dart';

/// Wrapper around grpc_server_credentials, a way to authenticate a server.
abstract class ServerCredentials {
  /// Validates incoming connection. Returns [true] if connection is
  /// allowed to proceed.
  bool validateClient(Socket socket) => true;

  /// Creates [SecurityContext] from these credentials if possible.
  /// Otherwise returns [null].
  SecurityContext? get securityContext;
}

/// Set of credentials that only allows local TCP connections.
class ServerLocalCredentials extends ServerCredentials {
  @override
  bool validateClient(Socket socket) => socket.remoteAddress.isLoopback;

  @override
  SecurityContext? get securityContext => null;
}

class ServerTlsCredentials extends ServerCredentials {
  final List<int>? certificate;
  final String? certificatePassword;
  final List<int>? privateKey;
  final String? privateKeyPassword;

  /// TLS credentials for a [Server].
  ///
  /// If the [certificate] or [privateKey] is encrypted, the password must also
  /// be provided.
  ServerTlsCredentials({
    this.certificate,
    this.certificatePassword,
    this.privateKey,
    this.privateKeyPassword,
  });

  @override
  SecurityContext get securityContext {
    final context = createSecurityContext(true);
    if (privateKey != null) {
      context.usePrivateKeyBytes(privateKey!, password: privateKeyPassword);
    }
    if (certificate != null) {
      context.useCertificateChainBytes(
        certificate!,
        password: certificatePassword,
      );
    }
    return context;
  }

  @override
  bool validateClient(Socket socket) => true;
}

/// A gRPC server that serves via provided [ServerTransportConnection]s.
///
/// Unlike [Server], the caller has the responsibility of configuring and
/// managing the connection from a client.
class ConnectionServer {
  final Map<String, Service> _services = {};
  final List<Interceptor> _interceptors;
  final List<ServerInterceptor> _serverInterceptors;
  final CodecRegistry? _codecRegistry;
  final GrpcErrorHandler? _errorHandler;
  final ServerKeepAliveOptions _keepAliveOptions;

  @visibleForTesting
  final Map<ServerTransportConnection, List<ServerHandler>> handlers = {};

  final _connections = <ServerTransportConnection>[];

  /// Create a server for the given [services].
  ConnectionServer(
    List<Service> services, [
    List<Interceptor> interceptors = const <Interceptor>[],
    List<ServerInterceptor> serverInterceptors = const <ServerInterceptor>[],
    CodecRegistry? codecRegistry,
    GrpcErrorHandler? errorHandler,
    this._keepAliveOptions = const ServerKeepAliveOptions(),
  ]) : _codecRegistry = codecRegistry,
       _interceptors = interceptors,
       _serverInterceptors = serverInterceptors,
       _errorHandler = errorHandler {
    for (final service in services) {
      _services[service.$name] = service;
    }
  }

  Service? lookupService(String service) => _services[service];

  Future<void> serveConnection({
    required ServerTransportConnection connection,
    X509Certificate? clientCertificate,
    InternetAddress? remoteAddress,
  }) async {
    _connections.add(connection);
    handlers[connection] = [];
    // TODO(jakobr): Set active state handlers, close connection after idle
    // timeout.
    final onDataReceivedController = StreamController<void>();
    ServerKeepAlive(
      options: _keepAliveOptions,
      tooManyBadPings: () async =>
          await connection.terminate(ErrorCode.ENHANCE_YOUR_CALM),
      pingNotifier: connection.onPingReceived,
      dataNotifier: onDataReceivedController.stream,
    ).handle();
    connection.incomingStreams.listen(
      (stream) {
        final handler = serveStream_(
          stream: stream,
          clientCertificate: clientCertificate,
          remoteAddress: remoteAddress,
          onDataReceived: onDataReceivedController.sink,
        );
        handler.onCanceled.then((_) => handlers[connection]?.remove(handler));
        handlers[connection]!.add(handler);
      },
      onError: (error, stackTrace) {
        if (error is Error) {
          Zone.current.handleUncaughtError(error, stackTrace);
        }
      },
      onDone: () async {
        // TODO(sigurdm): This is not correct behavior in the presence of
        // half-closed tcp streams.
        // Half-closed  streams seems to not be fully supported by package:http2.
        // https://github.com/dart-lang/http2/issues/42
        for (var handler in handlers[connection]!) {
          handler.cancel();
        }
        _connections.remove(connection);
        handlers.remove(connection);
        await onDataReceivedController.close();
      },
    );
  }

  @visibleForTesting
  ServerHandler serveStream_({
    required ServerTransportStream stream,
    X509Certificate? clientCertificate,
    InternetAddress? remoteAddress,
    Sink<void>? onDataReceived,
  }) {
    return ServerHandler(
      stream: stream,
      serviceLookup: lookupService,
      interceptors: _interceptors,
      serverInterceptors: _serverInterceptors,
      codecRegistry: _codecRegistry,
      // ignore: unnecessary_cast
      clientCertificate: clientCertificate as io_bits.X509Certificate?,
      // ignore: unnecessary_cast
      remoteAddress: remoteAddress as io_bits.InternetAddress?,
      errorHandler: _errorHandler,
      onDataReceived: onDataReceived,
    )..handle();
  }
}

/// A gRPC server.
///
/// Listens for incoming RPCs, dispatching them to the right [Service] handler.
class Server extends ConnectionServer {
  ServerSocket? _insecureServer;
  SecureServerSocket? _secureServer;

  /// Create a server for the given [services].
  @Deprecated('use Server.create() instead')
  Server(
    super.services, [
    super.interceptors,
    super.codecRegistry,
    super.errorHandler,
    super.keepAlive,
  ]);

  /// Create a server for the given [services].
  Server.create({
    required List<Service> services,
    ServerKeepAliveOptions keepAliveOptions = const ServerKeepAliveOptions(),
    List<Interceptor> interceptors = const <Interceptor>[],
    List<ServerInterceptor> serverInterceptors = const <ServerInterceptor>[],
    CodecRegistry? codecRegistry,
    GrpcErrorHandler? errorHandler,
  }) : super(
         services,
         interceptors,
         serverInterceptors,
         codecRegistry,
         errorHandler,
         keepAliveOptions,
       );

  /// The port that the server is listening on, or `null` if the server is not
  /// active.
  int? get port {
    if (_secureServer != null) return _secureServer!.port;
    if (_insecureServer != null) return _insecureServer!.port;
    return null;
  }

  @override
  Service? lookupService(String service) => _services[service];

  /// Starts the [Server] with the given options.
  /// [address] can be either a [String] or an [InternetAddress], in the latter
  /// case it can be a Unix Domain Socket address.
  ///
  /// If [port] is [null] then it defaults to `80` for non-secure and `443` for
  /// secure variants.  Pass `0` for [port] to let OS select a port for the
  /// server.
  Future<void> serve({
    dynamic address,
    int? port,
    ServerCredentials? security,
    ServerSettings? http2ServerSettings,
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
    bool requestClientCertificate = false,
    bool requireClientCertificate = false,
  }) async {
    // TODO(dart-lang/grpc-dart#9): Handle HTTP/1.1 upgrade to h2c, if allowed.
    Stream<Socket> server;
    final securityContext = security?.securityContext;
    if (securityContext != null) {
      final _server = await SecureServerSocket.bind(
        address ?? InternetAddress.anyIPv4,
        port ?? 443,
        securityContext,
        backlog: backlog,
        shared: shared,
        v6Only: v6Only,
        requestClientCertificate: requestClientCertificate,
        requireClientCertificate: requireClientCertificate,
      );
      _secureServer = _server;
      server = _server;
    } else {
      final _server = await ServerSocket.bind(
        address ?? InternetAddress.anyIPv4,
        port ?? 80,
        backlog: backlog,
        shared: shared,
        v6Only: v6Only,
      );
      _insecureServer = _server;
      server = _server;
    }
    server.listen(
      (socket) {
        // Don't wait for io buffers to fill up before sending requests.
        if (socket.address.type != InternetAddressType.unix) {
          socket.setOption(SocketOption.tcpNoDelay, true);
        }

        X509Certificate? clientCertificate;

        if (socket is SecureSocket) {
          clientCertificate = socket.peerCertificate;
        }

        final connection = ServerTransportConnection.viaSocket(
          socket,
          settings: http2ServerSettings,
        );

        serveConnection(
          connection: connection,
          clientCertificate: clientCertificate,
          remoteAddress: socket.remoteAddressOrNull,
        );
      },
      onError: (error, stackTrace) {
        if (error is Error) {
          Zone.current.handleUncaughtError(error, stackTrace);
        }
      },
    );
  }

  @override
  @visibleForTesting
  ServerHandler serveStream_({
    required ServerTransportStream stream,
    X509Certificate? clientCertificate,
    InternetAddress? remoteAddress,
    Sink<void>? onDataReceived,
  }) {
    return ServerHandler(
      stream: stream,
      serviceLookup: lookupService,
      interceptors: _interceptors,
      serverInterceptors: _serverInterceptors,
      codecRegistry: _codecRegistry,
      // ignore: unnecessary_cast
      clientCertificate: clientCertificate as io_bits.X509Certificate?,
      // ignore: unnecessary_cast
      remoteAddress: remoteAddress as io_bits.InternetAddress?,
      errorHandler: _errorHandler,
      onDataReceived: onDataReceived,
    )..handle();
  }

  @Deprecated(
    'This is internal functionality, and will be removed in next major version.',
  )
  void serveStream(ServerTransportStream stream) {
    serveStream_(stream: stream);
  }

  Future<void> shutdown() async {
    await Future.wait([
      for (var connection in _connections) connection.finish(),
      if (_insecureServer != null) _insecureServer!.close(),
      if (_secureServer != null) _secureServer!.close(),
    ]);
    _insecureServer = null;
    _secureServer = null;
  }
}

extension on Socket {
  InternetAddress? get remoteAddressOrNull {
    try {
      // Using a try-catch control flow as dart:io Sockets don't expose their
      // connectivity state.
      return remoteAddress;
    } on Exception catch (_) {
      return null;
    }
  }
}
