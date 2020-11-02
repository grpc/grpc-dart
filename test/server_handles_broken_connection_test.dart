@TestOn('vm')
import 'dart:async';
import 'dart:isolate';
import 'package:grpc/grpc.dart' as grpc;
import 'package:test/test.dart';

class TestClient extends grpc.Client {
  static final _$infiniteStream = grpc.ClientMethod<int, int>(
      '/test.TestService/infiniteStream',
      (int value) => [value],
      (List<int> value) => value[0]);

  TestClient(grpc.ClientChannel channel) : super(channel);
  grpc.ResponseStream<int> infiniteStream(int request,
      {grpc.CallOptions options}) {
    return $createStreamingCall(_$infiniteStream, Stream.value(request),
        options: options);
  }
}

class TestService extends grpc.Service {
  String get $name => 'test.TestService';
  final void Function() finallyCallback;

  TestService({this.finallyCallback}) {
    $addMethod(grpc.ServiceMethod<int, int>('infiniteStream', infiniteStream,
        false, true, (List<int> value) => value[0], (int value) => [value]));
  }

  Stream<int> infiniteStream(grpc.ServiceCall call, Future request) async* {
    int count = await request;
    try {
      while (true) {
        count++;
        yield count % 128;
        // TODO(sigurdm): Ideally we should not need this to get the
        //  cancel-event.
        //  See: https://github.com/dart-lang/sdk/issues/34775
        await Future.delayed(Duration(milliseconds: 1));
      }
    } finally {
      finallyCallback();
    }
  }
}

class ClientData {
  final int port;
  final SendPort sendPort;
  ClientData({this.port, this.sendPort});
}

void client(clientData) async {
  final channel = grpc.ClientChannel(
    'localhost',
    port: clientData.port,
    options: const grpc.ChannelOptions(
      credentials: grpc.ChannelCredentials.insecure(),
    ),
  );
  TestClient(channel).infiniteStream(1).listen((count) async {
    await channel.terminate();
  }, onError: (e) {
    clientData.sendPort.send(e);
  });
}

main() async {
  test("the client interrupting the connection does not crash the server",
      () async {
    grpc.Server server;
    server = grpc.Server([
      TestService(
          finallyCallback: expectAsync0(() {
        server.shutdown();
      }, reason: 'the producer should get cancelled'))
    ]);
    await server.serve(address: 'localhost', port: 0);
    final receivePort = ReceivePort();
    Isolate.spawn(
        client, ClientData(port: server.port, sendPort: receivePort.sendPort));
    receivePort.listen(expectAsync1((e) {
      expect(e, isA<grpc.GrpcError>());
    }, reason: 'the client should send an error from the destroyed channel'));
  });
}
