@TestOn('browser')

import 'dart:math' as math;

import 'package:test/test.dart';

import 'package:grpc/grpc_web.dart';

import 'src/generated/echo.pbgrpc.dart';

/// Starts gRPC server and a gRPC-web proxy (see grpc_web_server.dart for
/// implementation.
///
/// Returns uri which can be used to talk to using gRPC-web channel.
///
/// Note: server will be shut down when the test which spawned it finishes
/// running.
Future<Uri> startServer() async {
  // Spawn the server code on the server side, it will send us back port
  // number we should be talking to.
  final serverChannel = spawnHybridUri('grpc_web_server.dart');
  final port = await serverChannel.stream.first;

  // Note: we would like to test https as well, but we can't easily do it
  // because browsers like chrome don't trust self-signed certificates by
  // default.
  return Uri.parse('http://localhost:$port');
}

void main() {
  // Test verifies that gRPC-web echo example works by talking to a gRPC
  // server (written in Dart) via gRPC-web protocol through a third party
  // gRPC-web proxy.
  test('gRPC-web echo test', () async {
    final serverUri = await startServer();
    final channel = GrpcWebClientChannel.xhr(serverUri);
    final service = EchoServiceClient(channel);

    const testMessage = 'hello from gRPC-web';

    // First test a simple echo request.
    final response = await service.echo(EchoRequest()..message = testMessage);
    expect(response.message, equals(testMessage));

    // Now test that streaming requests also works by asking echo server
    // to send us a number of messages every 100 ms. Check that we receive
    // them fast enough (if streaming is broken we will receive all of them
    // in one go).
    final sw = Stopwatch()..start();
    final timings = await service
        .serverStreamingEcho(ServerStreamingEchoRequest()
          ..message = testMessage
          ..messageCount = 20
          ..messageInterval = 100)
        .map((response) {
      expect(response.message, equals(testMessage));
      final timing = sw.elapsedMilliseconds;
      sw.reset();
      return timing;
    }).toList();
    final maxDelay = timings.reduce(math.max);
    expect(maxDelay, lessThan(500));
  });
}
