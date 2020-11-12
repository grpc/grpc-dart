// @dart = 2.3
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:path/path.dart' as p;
import 'package:stream_channel/stream_channel.dart';

import 'src/generated/echo.pbgrpc.dart';

/// Controls verbosity of output during the test. Flip to [true] for easier
/// debugging.
const verbose = false;

class EchoService extends EchoServiceBase {
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    return EchoResponse()..message = request.message;
  }

  @override
  Stream<ServerStreamingEchoResponse> serverStreamingEcho(
      ServiceCall call, ServerStreamingEchoRequest request) async* {
    for (var i = 0; i < request.messageCount; i++) {
      yield ServerStreamingEchoResponse()..message = request.message;
      if (i < request.messageCount - 1) {
        await Future.delayed(Duration(milliseconds: request.messageInterval));
      }
    }
  }
}

final envoyPort = 9999;

final envoyConfig = '''
static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address: { address: 0.0.0.0, port_value: 0 }
    filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        config:
          codec_type: auto
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match: { prefix: "/" }
                route: { cluster: echo_service }
              cors:
                allow_origin_string_match:
                - prefix: "*"
                allow_methods: GET, PUT, DELETE, POST, OPTIONS
                allow_headers: keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,custom-header-1,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout
                max_age: "1728000"
                expose_headers: custom-header-1,grpc-status,grpc-message
          http_filters:
          - name: envoy.filters.http.grpc_web
          - name: envoy.filters.http.cors
          - name: envoy.filters.http.router
  clusters:
  - name: echo_service
    connect_timeout: 0.25s
    type: static
    http2_protocol_options: {}
    lb_policy: round_robin
    hosts:
    - socket_address: { address: 127.0.0.1, port_value: %TARGET_PORT% }
''';

hybridMain(StreamChannel channel) async {
  // Spawn a gRPC server.
  final server = Server([EchoService()]);
  await server.serve(port: 0);
  _info('grpc server listening on ${server.port}');

  // Create Envoy configuration.
  final tempDir = await Directory.systemTemp.createTemp();
  final config = p.join(tempDir.path, 'config.yaml');
  await File(config).writeAsString(
      envoyConfig.replaceAll('%TARGET_PORT%', server.port.toString()));

  // Spawn a proxy that would translate gRPC-web protocol into gRPC protocol
  // for us. We use envoy proxy. See CONTRIBUTING.md for setup.
  Process proxy;
  try {
    proxy = await Process.start('envoy', ['-c', config, '-l', 'debug']);
  } catch (e) {
    print('''
Failed to start envoy: $e.

Make sure that envoy is available in the PATH see CONTRIBUTING.md
if you are running tests locally.
''');
    channel.sink.add(0);
    return;
  }

  // Parse output of the proxy process looking for a port it selected.
  final portRe = RegExp(
      r'Set listener listener_0 socket factory local address to 0.0.0.0:(\d+)');

  proxy.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _info('envoy|stderr] $line');
    final m = portRe.firstMatch(line);
    if (m != null) {
      channel.sink.add(int.parse(m[1]));
    }
  });

  proxy.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _info('envoy|stdout] $line');
  });

  proxy.exitCode.then((value) {
    _info('proxy quit with ${value}');
    if (value != 0) {
      channel.sink.addError('proxy exited with ${value}');
    }
  });

  // Wait for the harness to tell us to shutdown.
  await channel.stream.first;
  proxy.kill();
  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
  channel.sink.add('EXITED');
}

void _info(String line) {
  if (verbose) {
    print(line);
  }
}
