class Proxy {
  final String host;
  final int port;
  final String? username;
  final String? password;
  final bool isDirect;

  const Proxy({
    required this.host,
    required this.port,
    this.username,
    this.password,
  }) : isDirect = false;

  const Proxy.direct()
      : host = '',
        port = -1,
        username = null,
        password = null,
        isDirect = true;

  bool get isAuthenticated => username != null;
}
