@TestOn('vm')
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:grpc/grpc.dart' as grpc;
import 'package:test/test.dart';
import 'common.dart';

class TestClient extends grpc.Client {
  static final _$infiniteStream = grpc.ClientMethod<int, int>(
      '/test.TestService/infiniteStream',
      (int value) => [value],
      (List<int> value) => value[0]);

  TestClient(grpc.ClientChannel super.channel);
  grpc.ResponseStream<int> infiniteStream(int request,
      {grpc.CallOptions? options}) {
    return $createStreamingCall(_$infiniteStream, Stream.value(request),
        options: options);
  }
}

class TestService extends grpc.Service {
  @override
  String get $name => 'test.TestService';
  final void Function() finallyCallback;

  TestService({required this.finallyCallback}) {
    $addMethod(grpc.ServiceMethod<int, int>('infiniteStream', infiniteStream,
        false, true, (List<int> value) => value[0], (int value) => [value]));
  }

  Stream<int> infiniteStream(
      grpc.ServiceCall call, Future<int> request) async* {
    var count = await request;
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
  final InternetAddress address;
  final int port;
  final SendPort sendPort;
  ClientData(
      {required this.address, required this.port, required this.sendPort});
}

void client(clientData) async {
  final channel = grpc.ClientChannel(
    clientData.address,
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

Future<void> main() async {
  testTcpAndUds(
      'the client interrupting the connection does not crash the server',
      (address) async {
    // interrrupt the connect of client, the server does not crash.
    late grpc.Server server;
    server = grpc.Server([
      TestService(
          finallyCallback: expectAsync0(() {
        expect(server.shutdown(), completes);
      }, reason: 'the producer should get cancelled'))
    ]);
    await server.serve(address: address, port: 0);
    final receivePort = ReceivePort();
    Isolate.spawn(
        client,
        ClientData(
            address: address,
            port: server.port!,
            sendPort: receivePort.sendPort));
    receivePort.listen(expectAsync1((e) {
      expect(e, isA<grpc.GrpcError>());
      receivePort.close();
    }, reason: 'the client should send an error from the destroyed channel'));
  });
}
