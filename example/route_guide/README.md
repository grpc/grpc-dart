# Description
The route guide server and client demonstrate how to use Dart gRPC libraries to
perform unary, client streaming, server streaming and full duplex RPCs.

See the definition of the route guide service in `protos/route_guide.proto`.

# Run the sample code
To compile and run the example, assuming you are in the root of the route_guide
folder, i.e., .../example/route_guide/, first get the dependencies by running:

```sh
$ pub get
```

Then, to run the server:

```sh
$ dart bin/server.dart
```

Likewise, to run the client:

```sh
$ dart bin/client.dart
```

# Regenerate the stubs

If you have made changes to the message or service definition in
`protos/route_guide.proto` and need to regenerate the corresponding Dart files,
you will need to have protoc version 3.0.0 or higher and the Dart protoc plugin
version 0.7.9 or higher on your PATH.

To install protoc with Dart support, take these steps:

1. Install the `protoc` matching your development operating system from
[the Protocol Buffers releases page](https://github.com/google/protobuf/releases)
(e.g. `protoc-3.5.1-osx-x86_64.zip` for macOS).

1. Get the Dart protoc plugin by running

    ```sh
    $ pub global activate protoc_plugin
    ```

1. Add `~/.pub-cache/bin` to your PATH, if you haven't
already done so.

You can now regenerate the Dart files by running

```sh
$ protoc --dart_out=grpc:lib/src/generated -Iprotos protos/route_guide.proto
```
