## 0.6.6

* Support `package:http` `>=0.11.3+17 <0.13.0`.
* Update `package:googleapis_auth` to `^0.2.5+3`.

## 0.6.5

* Interceptors are now async.

## 0.6.4

* Update dependencies to be compatible with Dart 2.

## 0.6.3

* Make fields of `StatusCode` const rather than final.

## 0.6.2

* Allow for non-ascii header values.

## 0.6.1

* More fixes to update to Dart 2 core library APIs.

## 0.6.0+1

* Updated implementation to use new Dart 2 APIs using
[dart2_fix](https://github.com/dart-lang/dart2_fix).

## 0.6.0

* Dart SDK upper constraint raised to declare compatability with Dart 2.0 stable.

## 0.5.0

* Breaking change: The package now exclusively supports Dart 2.
* Fixed tests to pass in Dart 2.
* Added support for Interceptors ([issue #79](https://github.com/grpc/grpc-dart/issues/79)); thanks to [@mogol](https://github.com/mogol) for contributing!

## 0.4.1

* Fixes for supporting Dart 2.

## 0.4.0

* Moved TLS credentials for server into a separate class.
* Added support for specifying the address for the server, and support for
  serving on an ephemeral port.

## 0.3.1

* Split out TLS credentials to a separate class.

## 0.3.0

* Added authentication metadata providers, optimized for use with Google Cloud.
* Added service URI to metadata provider API, needed for Json Web Token generation.
* Added authenticated cloud-to-prod interoperability tests.
* Refactored connection logic to throw initial connection errors early.

## 0.2.1

* Updated generated code in examples using latest protoc compiler plugin.
* Dart 2.0 fixes.
* Changed license to Apache 2.0.

## 0.2.0

* Implemented support for per-RPC metadata providers. This can be used for
  authentication providers which may need to obtain or refresh a token before
  the RPC is sent.

## 0.1.0

* Core gRPC functionality is implemented and passes
[gRPC compliance tests](https://github.com/grpc/grpc/blob/master/doc/interop-test-descriptions.md).

The API is shaping up, but may still change as more advanced features are implemented.

## 0.0.1

* Initial version.

This package is in a very early and experimental state. We do not recommend
using it for anything but experiments.
