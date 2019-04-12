import 'dart:async';

import 'package:grpc/grpc.dart' as grpc;
import 'package:test/test.dart';

class TestClient extends grpc.Client {
  TestClient(grpc.ClientChannel channel) : super(channel);
  grpc.ResponseStream<int> foo(int request, {grpc.CallOptions options}) {
    final call = $createCall(
        new grpc.ClientMethod<int, int>('/test.TestService/foo',
            (int value) => [value], (List<int> value) => value[0]),
        Stream.fromIterable([request]),
        options: options);
    return grpc.ResponseStream(call);
  }
}

class TestService extends grpc.Service {
  String get $name => 'test.TestService';
  final finallyCompleter;

  TestService({this.finallyCompleter}) {
    $addMethod(new grpc.ServiceMethod<int, int>('foo', foo, false, true,
        (List<int> value) => value[0], (int value) => [value]));
  }

  Stream<int> foo(grpc.ServiceCall call, Future request) async* {
    try {
      int i = 0;
      while (true) {
        await Future(() {});
        yield i++ % 128;
      }
    } finally {
      finallyCompleter.complete();
    }
  }
}

void client({int port}) async {
  final channel = grpc.ClientChannel(
    'localhost',
    port: port,
    options: const grpc.ChannelOptions(
      idleTimeout: Duration(milliseconds: 5),
      credentials: grpc.ChannelCredentials.insecure(),
    ),
  );

  final done = expectAsync0(() {}, max: -1);
  (await channel.getConnection()).onStateChanged = (connection) {
    if (connection.state == grpc.ConnectionState.idle) {
      done();
    }
  };

  final responseStream = TestClient(channel).foo(1);
  StreamSubscription sub;
  sub = responseStream.listen((v) {
    sub.cancel();
  });
}

main() async {
  test(
      'when the client cancels the response stream, the connection will idle again',
      () async {
    grpc.Server server;
    final done = Completer();
    server = new grpc.Server([new TestService(finallyCompleter: done)]);
    await server.serve(port: 0);
    client(port: server.port);
    await done.future;
  });
}
