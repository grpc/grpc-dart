@TestOn('vm')
import 'dart:async';
import 'package:grpc/grpc.dart' as grpc;
import 'package:grpc/service_api.dart';
import 'package:grpc/src/client/channel.dart';
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:http2/http2.dart';
import 'package:test/test.dart';

class TestClient extends grpc.Client {
  static final _$stream = grpc.ClientMethod<int, int>(
      '/test.TestService/stream',
      (int value) => [value],
      (List<int> value) => value[0]);

  TestClient(ClientChannel channel) : super(channel);
  grpc.ResponseStream<int> stream(int request, {grpc.CallOptions options}) {
    return $createStreamingCall(_$stream, Stream.value(request),
        options: options);
  }
}

class TestService extends grpc.Service {
  String get $name => 'test.TestService';

  TestService() {
    $addMethod(grpc.ServiceMethod<int, int>('stream', stream, false, true,
        (List<int> value) => value[0], (int value) => [value]));
  }

  Stream<int> stream(grpc.ServiceCall call, Future request) async* {
    yield 1;
    yield 2;
    yield 3;
  }
}

class FixedConnectionClientChannel extends ClientChannelBase {
  final Http2ClientConnection clientConnection;
  List<grpc.ConnectionState> states = <grpc.ConnectionState>[];
  FixedConnectionClientChannel(this.clientConnection) {
    clientConnection.onStateChanged = (c) => states.add(c.state);
  }
  @override
  ClientConnection createConnection() => clientConnection;
}

main() async {
  test('client reconnects after the connection gets old', () async {
    final grpc.Server server = grpc.Server([TestService()]);
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
      'localhost',
      server.port,
      grpc.ChannelOptions(
        idleTimeout: Duration(minutes: 1),
        // Short delay to test that it will time out.
        connectionTimeout: Duration(milliseconds: 100),
        credentials: grpc.ChannelCredentials.insecure(),
      ),
    ));
    final testClient = TestClient(channel);

    expect(await testClient.stream(1).toList(), [1, 2, 3]);
    await Future.delayed(Duration(milliseconds: 200));
    expect(await testClient.stream(1).toList(), [1, 2, 3]);
    expect(
        channel.states.where((x) => x == grpc.ConnectionState.ready).length, 2);
    server.shutdown();
  });

  test('client reconnects when stream limit is used', () async {
    final grpc.Server server = grpc.Server([TestService()]);
    await server.serve(
        address: 'localhost',
        port: 0,
        http2ServerSettings: ServerSettings(concurrentStreamLimit: 2));

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
        'localhost',
        server.port,
        grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure())));
    final states = <grpc.ConnectionState>[];
    channel.clientConnection.onStateChanged =
        (Http2ClientConnection connection) => states.add(connection.state);
    final testClient = TestClient(channel);

    await Future.wait(<Future>[
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
      expectLater(testClient.stream(1).toList(), completion([1, 2, 3])),
    ]);
    expect(states.where((x) => x == grpc.ConnectionState.ready).length, 2);
    server.shutdown();
  });
}
