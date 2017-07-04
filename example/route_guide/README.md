# Description
The route guide server and client demonstrate how to use Dart gRPC libraries to
perform unary, client streaming, server streaming and full duplex RPCs.

Please refer to [gRPC Basics: Dart]() for more information.

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
