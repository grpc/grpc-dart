import 'package:flutter/material.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'src/generated/echo.pbgrpc.dart';

void main() async {
  final message = 'hello';
  final host = 'localhost';
  final grpcPort = 9090;
  final grpcWebPort = 8080;
  late Object result;
  var success = true;

  try {
    final channel = GrpcOrGrpcWebClientChannel(
      host: host,
      grpcPort: grpcPort,
      grpcWebPort: grpcWebPort,
      secure: false,
    );
    final connector = EchoServiceClient(channel);
    final response = await connector.echo(EchoRequest()..message = message);
    result = response.message;
  } catch (e) {
    result = e;
    success = false;
  }

  runApp(MaterialApp(
    title: 'GrpcOrGrpcWebClientChannel example',
    home: Text(
      (success ? 'response: ' : 'error: ') + result.toString(),
      style: TextStyle(
        color: success ? Colors.white : Colors.red,
        backgroundColor: Colors.black,
      ),
    ),
  ));
}
