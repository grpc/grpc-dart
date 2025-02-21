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
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:http2/transport.dart';
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
      - name: envoy.filters.network.http_connection_manager
        typed_config:
          "@type":  type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          codec_type: auto
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains: ["*"]
              routes:
              - match: { prefix: "/" }
                route:
                  cluster: echo_service
                  max_stream_duration:
                    grpc_timeout_header_max: 0s
              cors:
                allow_origin_string_match:
                - prefix: "*"
                allow_methods: GET, PUT, DELETE, POST, OPTIONS
                allow_headers: keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,custom-header-1,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout
                max_age: "1728000"
                expose_headers: custom-header-1,grpc-status,grpc-message
          http_filters:
          - name: envoy.filters.http.grpc_web
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.http.grpc_web.v3.GrpcWeb
          - name: envoy.filters.http.cors
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.http.cors.v3.Cors
          - name: envoy.filters.http.router
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
  clusters:
  - name: echo_service
    connect_timeout: 0.25s
    type: static
    http2_protocol_options: {}
    lb_policy: round_robin
    load_assignment:
      cluster_name: cluster_0
      endpoints:
        - lb_endpoints:
            - endpoint:
                address:
                  socket_address:
                    address: 127.0.0.1
                    port_value: %TARGET_PORT%
''';

// Envoy output will be collected and dumped to stdout if envoy exits
// with an error. Otherwise if verbose is specified it will be dumped
// to stdout unconditionally.
final output = <String>[];

void _info(String line) {
  if (!verbose) {
    output.add(line);
  } else {
    print(line);
  }
}

Future<void> hybridMain(StreamChannel channel) async {
  // Spawn a gRPC server.
  final server = Server.create(services: [EchoService()]);
  await server.serve(port: 0);
  _info('grpc server listening on ${server.port}');

  final httpServer = await startHttpServer();
  _info('HTTP server listening on ${httpServer.port}');

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
      channel.sink
          .add({'grpcPort': int.parse(m[1]!), 'httpPort': httpServer.port});
    }
  });

  proxy.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _info('envoy|stdout] $line');
  });

  proxy.exitCode.then((value) {
    _info('proxy quit with $value');
    if (value != 0) {
      if (!verbose) {
        stdout.writeAll(output, '\n');
      }
      channel.sink.addError('proxy exited with $value');
    }
  });

  // Wait for the harness to tell us to shutdown.
  await channel.stream.first;
  proxy.kill();
  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }
  channel.sink.add('EXITED');

  await server.shutdown();
  await httpServer.close();
}

final testCases = <String, void Function(HttpResponse)>{
  'test:cors': (rs) {
    rs.headers.removeAll('Access-Control-Allow-Origin');
    rs.headers.add(HttpHeaders.contentTypeHeader, 'text/html');
    rs.write('some body');
    rs.close();
  },
  'test:status-503': (rs) {
    rs.headers.add(HttpHeaders.contentTypeHeader, 'text/html');
    rs.statusCode = HttpStatus.serviceUnavailable;
    rs.write('some body');
    rs.close();
  },
  'test:bad-content-type': (rs) {
    rs.headers.add(HttpHeaders.contentTypeHeader, 'text/html');
    rs.statusCode = HttpStatus.ok;
    rs.write('some body');
    rs.close();
  },
};

void defaultHandler(HttpResponse rs) {
  rs.close();
}

Future<HttpServer> startHttpServer() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  server.defaultResponseHeaders.removeAll('x-frame-options');
  server.defaultResponseHeaders.removeAll('x-xss-protection');
  server.defaultResponseHeaders.removeAll('x-content-type-options');
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.listen((request) async {
    _info('${request.method} ${request.requestedUri} ${request.headers}');
    final message = await GrpcHttpDecoder()
        .bind(request.map((list) => DataStreamMessage(list)))
        .first as GrpcData;
    final echoRequest = EchoRequest.fromBuffer(message.data);
    (testCases[echoRequest.message] ?? defaultHandler)(request.response);
  });
  return server;
}

Future<void> main() async {
  final controller = StreamChannelController();
  await hybridMain(controller.local);
}
