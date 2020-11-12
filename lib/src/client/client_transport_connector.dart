import 'dart:async';

import 'package:http2/transport.dart';

/// A transport-specific configuration used by gRPC clients to connect.
abstract class ClientTransportConnector {
  /// Creates a HTTP/2 client connection.
  Future<ClientTransportConnection> connect();

  /// A future that completes when the client closes or when an error occurs.
  Future get done;

  /// Shuts down the connection, which should at least close the client.
  void shutdown();

  /// Header populated from any credentials or hostname information.
  String get authority;
}
