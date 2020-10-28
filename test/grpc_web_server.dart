import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
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

hybridMain(StreamChannel channel) async {
  // Spawn a gRPC server.
  final server = Server([EchoService()]);
  await server.serve(port: 0);
  _info('grpc server listening on ${server.port}');

  // Spawn a proxy that would translate gRPC-web protocol into gRPC protocol
  // for us. We use grpcwebproxy by Improbable Engineering. See CONTRIBUTING.md
  // for setup.
  Process proxy;
  try {
    proxy =
        await Process.start('grpcwebproxy${Platform.isWindows ? '.exe' : ''}', [
      '--backend_addr',
      'localhost:${server.port}',
      '--run_tls_server=false',
      '--server_http_debug_port',
      '0',
      '--allow_all_origins',
    ]);
  } catch (e) {
    print('''
Failed to start grpcwebproxy: $e.

Make sure that grpcwebproxy is available in the PATH see CONTRIBUTING.md
if you are running tests locally.
''');
    channel.sink.add(0);
    return;
  }

  // Parse output of the proxy process looking for a port it selected.
  final portRe = RegExp(r'listening for http on: .*:(\d+)');

  proxy.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _info('grpcwebproxy|stderr] $line');
  });

  proxy.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
    _info('grpcwebproxy|stdout] $line');
    final m = portRe.firstMatch(line);
    if (m != null) {
      final port = int.parse(m[1]);
      channel.sink.add(port);
    }
  });

  proxy.exitCode.then((value) => _info('proxy quit with ${value}'));
}

void _info(String line) {
  if (verbose) {
    print(line);
  }
}
