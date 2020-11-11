# Description
The hello world server and client demonstrate how to use Dart gRPC libraries to
perform unary RPCs.

See the definition of the hello world service in `protos/helloworld.proto`.

# Run the sample code
To compile and run the example, assuming you are in the root of the helloworld
folder, i.e., .../example/helloworld/, first get the dependencies by running:

```sh
$ pub get
```
## Run TCP sample code

Start the server:

```sh
$ dart bin/server.dart
```

Likewise, to run the client:

```sh
$ dart bin/client.dart
```
## Run UDS sample code

Start the server:

```sh
$ dart bin/unix_server.dart
```

Likewise, to run the client:

```sh
$ dart bin/unix_client.dart
```

>**Note** the `UDS` only support *nix plantform.

# Regenerate the stubs

If you have made changes to the message or service definition in
`protos/helloworld.proto` and need to regenerate the corresponding Dart files,
you will need to have protoc version 3.0.0 or higher and the Dart protoc plugin
version 0.7.9 or higher on your PATH.

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
$ protoc --dart_out=grpc:lib/src/generated -Iprotos protos/helloworld.proto
```
