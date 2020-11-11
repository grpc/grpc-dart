@TestOn('vm')
import 'dart:async';
import 'dart:io';
import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as api;
import 'package:grpc/src/client/channel.dart' hide ClientChannel;
import 'package:grpc/src/client/connection.dart';
import 'package:grpc/src/client/http2_connection.dart';
import 'package:test/test.dart';
import 'common.dart';

class TestClient extends Client {
  static final _$stream = ClientMethod<int, int>('/test.TestService/stream',
      (int value) => [value], (List<int> value) => value[0]);

  TestClient(api.ClientChannel channel) : super(channel);
  ResponseStream<int> stream(int request, {CallOptions options}) {
    return $createStreamingCall(_$stream, Stream.value(request),
        options: options);
  }
}

class TestService extends Service {
  String get $name => 'test.TestService';

  TestService() {
    $addMethod(ServiceMethod<int, int>('stream', stream, false, true,
        (List<int> value) => value[0], (int value) => [value]));
  }

  static const requestFiniteStream = 1;
  static const requestInfiniteStream = 2;

  Stream<int> stream(ServiceCall call, Future request) async* {
    final isInfinite = 2 == await request;
    for (var i = 1; i <= 3 || isInfinite; i++) {
      yield i;
      await Future.delayed(Duration(milliseconds: 100));
    }
  }
}

class TestServiceWithOnMetadataException extends TestService {
  void $onMetadata(ServiceCall context) {
    throw Exception('business exception');
  }
}

class FixedConnectionClientChannel extends ClientChannelBase {
  final Http2ClientConnection clientConnection;
  List<ConnectionState> states = <ConnectionState>[];
  FixedConnectionClientChannel(this.clientConnection) {
    clientConnection.onStateChanged = (c) => states.add(c.state);
  }
  @override
  ClientConnection createConnection() => clientConnection;
}

main() async {
  testTcpAndUds('round trip insecure connection', (address) async {
    // round trip test of insecure connection.
    final Server server = Server([TestService()]);
    await server.serve(address: address, port: 0);

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
      address,
      server.port,
      ChannelOptions(credentials: ChannelCredentials.insecure()),
    ));
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestFiniteStream).toList(),
        [1, 2, 3]);
    server.shutdown();
  });

  testTcpAndUds('round trip secure connection', (address) async {
    // round trip test of secure connection.
    final Server server = Server([TestService()]);
    await server.serve(
        address: address,
        port: 0,
        security: ServerTlsCredentials(
            certificate: File('test/data/localhost.crt').readAsBytesSync(),
            privateKey: File('test/data/localhost.key').readAsBytesSync()));

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
      address,
      server.port,
      ChannelOptions(
          credentials: ChannelCredentials.secure(
              certificates: File('test/data/localhost.crt').readAsBytesSync(),
              authority: 'localhost')),
    ));
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestFiniteStream).toList(),
        [1, 2, 3]);
    server.shutdown();
  });

  test('exception in onMetadataException', () async {
    final Server server = Server([TestServiceWithOnMetadataException()]);
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
      'localhost',
      server.port,
      ChannelOptions(credentials: ChannelCredentials.insecure()),
    ));
    final testClient = TestClient(channel);
    await expectLater(
        testClient.stream(TestService.requestFiniteStream).toList(),
        throwsA(isA<GrpcError>()));
    await server.shutdown();
  });

  test('cancellation of streaming subscription propagates properly', () async {
    final Server server = Server([TestService()]);
    await server.serve(address: 'localhost', port: 0);

    final channel = FixedConnectionClientChannel(Http2ClientConnection(
      'localhost',
      server.port,
      ChannelOptions(credentials: ChannelCredentials.insecure()),
    ));
    final testClient = TestClient(channel);
    expect(await testClient.stream(TestService.requestInfiniteStream).first, 1);
    await channel.shutdown();
    await server.shutdown();
  });
}
