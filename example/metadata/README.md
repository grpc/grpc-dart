# Description
The metadata server and client demonstrate how to handle custom metadata,
cancellation, and timeouts in Dart gRPC.

See the definition of the metadata service in `protos/metadata.proto`.

# Run the sample code
To compile and run the example, assuming you are in the root of the metadata
folder, i.e., .../example/metadata/, first get the dependencies by running:

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
