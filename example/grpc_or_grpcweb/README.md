# GrpcOrGrpcWebClientChannel example
This example shows how to use `GrpcOrGrpcWebClientChannel` class to build a flutter client app that automatically switches between gRPC and gRPC-web depending on the platform it runs on: it uses gRPC everywhere except the web platform. As gRPC and gRPC-web are 2 different protocols, the server must be able to speak both of them, each on a separate port.

This is meant to be used with the [echo example provided by the grpc-web repository](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo). The definition of the service is copied to [protos/echo.proto](protos/echo.proto) for readability convenience.

# Prerequisites

You will need a clone of the [grpc-web](https://github.com/grpc/grpc-web) repository and [docker tools](https://docs.docker.com/get-docker/) to run the server and [Flutter SDK](https://flutter.dev/docs/get-started/install) to run this client app: follow Flutter's installation instructions to enable each platform you need.

# Build and run the server
Follow the instructions for building/running the following components: [pre-requisites](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo#build-pre-requisites), [gRPC Backend server](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo#run-the-grpc-backend-server) and [Envoy proxy](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/echo#run-the-envoy-proxy) (for the purpose of this example, js web-app is not required).

# Build and run the Flutter client

Generate Flutter platform specific code and configurations: replace `linux` with your host platform if needed (either `windows` or `macos`) and run the following command in this folder:

```sh
flutter create --org io.grpc --project-name grpc_or_grpcweb --template=app --platforms ios,android,web,linux .
```

Run the app on a desired device by replacing `$DEVICE` in the following command:

```sh
flutter run -d $DEVICE
```
Available devices can be listed by running the following command:

```sh
flutter devices
```
For mobile devices (Android, iOS) you need to accordingly replace `localhost` in [lib/main.dart file](lib/main.dart) as the client and the server do not run on the same (virtual) machine in such case. The exact value depends on your specific setup:
* For android emulators use `10.0.2.2`.
* For physical devices you can use the IP of your machine within the local WiFi network, which both your machine and the mobile device are connected to (make sure that firewall rules on your machine allow connections to port `9090`).

# Regenerate the stubs

If you have made changes to the message or service definition in
`protos/echo.proto` and need to regenerate the corresponding Dart files,
you will need to have protoc version 3.0.0 or higher and the Dart protoc plugin
version 16.0.0 or higher on your PATH.

To install protoc, see the instructions on
[the Protocol Buffers website](https://developers.google.com/protocol-buffers/).

The easiest way to get the Dart protoc plugin is by running

```sh
$ pub global activate protoc_plugin
```

and follow the directions to add `~/.pub-cache/bin` to your PATH, if you haven't
already done so.

You can now regenerate the Dart files by running

```sh
$ protoc --dart_out=grpc:lib/src/generated -Iprotos protos/echo.proto
```
