# Description
The googleapis client demonstrates how to use Dart gRPC libraries to communicate
with Google APIs.

# Set up Google Cloud Platform project
This example uses the Stackdriver Logging API. Please follow the documentation on
[Stackdriver Logging Documentation](https://cloud.google.com/logging/docs/) to create
a project and enable the logging API.

Then follow the documentation to
[create a service account](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount).
This example uses the Logging/Logs Writer role.

Create a new service key, download the JSON file for it, and save it as
`logging-service-account.json`.

# Run the sample code
To run the example, assuming you are in the root of the googleapis folder, i.e.,
.../example/googleapis/, first get the dependencies by running:

```sh
$ dart pub get
```

Then, to run the logging client sample:

```sh
$ dart run bin/logging.dart
```

# Regenerate the stubs
The Dart gRPC stubs and message classes are generated based on protobuf definition
files from [googleapis/googleapis](https://github.com/googleapis/googleapis).

To regenerate them, you will need to check out both
[googleapis/googleapis](https://github.com/googleapis/googleapis) and
[google/protobuf](https://github.com/google/protobuf).

You will also need to have protoc version 3.0.0 or higher and the Dart protoc
plugin version 0.7.9 or higher on your PATH.

To install protoc, see the instructions on
[the Protocol Buffers website](https://developers.google.com/protocol-buffers/).

The easiest way to get the Dart protoc plugin is by running

```sh
$ pub global activate protoc_plugin
```

and follow the directions to add `~/.pub-cache/bin` to your PATH, if you haven't
already done so.

You can now regenerate the Dart files. Set the `PROTOBUF` and `GOOGLEAPIS`
environment variables to point to your clone of
[google/protobuf](https://github.com/google/protobuf) and
[googleapis/googleapis](https://github.com/googleapis/googleapis), respectively,
and then run

```sh
$ tool/regenerate.sh
```
