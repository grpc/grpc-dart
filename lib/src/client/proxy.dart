/// Proxy data class with optional authentication.
class Proxy {
  final String host;
  final int port;
  final String? username;
  final String? password;

  const Proxy({
    required this.host,
    required this.port,
    this.username,
    this.password,
  });

  bool get isAuthenticated => username != null;
}
