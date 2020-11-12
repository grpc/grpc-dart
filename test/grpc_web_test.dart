@TestOn('browser')

import 'dart:async';
import 'dart:math' as math;

import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';

import 'package:grpc/grpc_web.dart';

import 'src/generated/echo.pbgrpc.dart';

void main() {
  GrpcWebServer server;

  setUpAll(() async {
    server = await GrpcWebServer.start();
  });

  tearDownAll(() async {
    await server.shutdown();
  });

  // Test verifies that gRPC-web echo example works by talking to a gRPC
  // server (written in Dart) via gRPC-web protocol through a third party
  // gRPC-web proxy.
  test('gRPC-web echo test', () async {
    final channel = GrpcWebClientChannel.xhr(server.uri);
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

  // Verify that terminate does not cause an exception when terminating
  // channel with multiple active requests.
  test("terminate works", () async {
    final channel = GrpcWebClientChannel.xhr(server.uri);
    final service = EchoServiceClient(channel);

    const testMessage = 'hello from gRPC-web';

    // First test a simple echo request.
    final response = await service.echo(EchoRequest()..message = testMessage);
    expect(response.message, equals(testMessage));

    var terminated = false;

    service
        .serverStreamingEcho(ServerStreamingEchoRequest()
          ..message = testMessage
          ..messageCount = 20
          ..messageInterval = 100)
        .listen((response) {
      expect(response.message, equals(testMessage));
    }, onError: (e) {
      expect(terminated, isTrue);
    });

    service
        .serverStreamingEcho(ServerStreamingEchoRequest()
          ..message = testMessage
          ..messageCount = 20
          ..messageInterval = 100)
        .listen((response) {
      expect(response.message, equals(testMessage));
    }, onError: (e) {
      expect(terminated, isTrue);
    });

    await Future.delayed(Duration(milliseconds: 500));
    terminated = true;
    await channel.terminate();
  });
}

class GrpcWebServer {
  final StreamChannel channel;
  final Future<void> whenExited;
  final Uri uri;

  GrpcWebServer(this.channel, this.whenExited, this.uri);

  Future<void> shutdown() async {
    channel.sink.add('shutdown');
    await whenExited;
  }

  /// Starts gRPC server and a gRPC-web proxy (see grpc_web_server.dart for
  /// implementation.
  ///
  /// Returns uri which can be used to talk to using gRPC-web channel.
  ///
  /// Note: you need to explicitly call shutdown on the returned object
  /// otherwise envoy proxy process leaks.
  static Future<GrpcWebServer> start() async {
    // Spawn the server code on the server side, it will send us back port
    // number we should be talking to.
    final serverChannel =
        spawnHybridUri('grpc_web_server.dart', stayAlive: true);
    final portCompleter = Completer<int>();
    final exitCompleter = Completer<void>();
    serverChannel.stream.listen((event) {
      if (!portCompleter.isCompleted) {
        portCompleter.complete(event);
      } else if (event == 'EXITED') {
        exitCompleter.complete();
      }
    }, onError: (e) {
      if (!portCompleter.isCompleted) {
        portCompleter.completeError(e);
      } else if (!exitCompleter.isCompleted) {
        exitCompleter.completeError(e);
      }
    });

    final port = await portCompleter.future;

    // Note: we would like to test https as well, but we can't easily do it
    // because browsers like chrome don't trust self-signed certificates by
    // default.
    return GrpcWebServer(serverChannel, exitCompleter.future,
        Uri.parse('http://localhost:$port'));
  }
}
