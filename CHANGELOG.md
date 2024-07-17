## 4.0.2

* Internal optimization to client code.

## 4.0.1

* Fix header and trailing not completing if the call is terminated. Fixes [#727](https://github.com/grpc/grpc-dart/issues/727)

## 4.0.0

* Set compressed flag correctly for grpc-encoding = identity. Fixes [#669](https://github.com/grpc/grpc-dart/issues/669) (https://github.com/grpc/grpc-dart/pull/693)
* Remove generated status codes.
* Remove dependency on `package:archive`.
* Move `codec.dart`.
* Work around hang during Flutter hot restart by adding default case handler in _GrpcWebConversionSink.add.

## 3.2.4

* Forward internal `GrpcError` on when throwing while sending a request.
* Add support for proxies, see [#33](https://github.com/grpc/grpc-dart/issues/33).
* Remove canceled `ServerHandler`s from tracking list.
* Fix regression on fetching the remote address of a closed socket.

## 3.2.3

* Add const constructor to `GrpcError` fixing #606.
* Make `GrpcError` non-final to allow implementations.
* Only send keepalive pings on open connections.
* Fix interop tests.

## 3.2.2

* Remove `base` qualifier on `ResponseStream`.
* Add support for clients to send KEEPALIVE pings.

## 3.2.1

* `package:http` now supports more versions: `>=0.13.0 <2.0.0`.
* `package:protobuf` new supports more versions: `>=2.0.0 <4.0.0`.

## 3.2.0

* `ChannelOptions` now exposes `connectTimeout`, which is used on the
  socket connect. This is used to specify the maximum allowed time to wait
  for a connection to be established. If `connectTime` is longer than the system
  level timeout duration, a timeout may occur sooner than specified in
  `connectTimeout`. On timeout, a `SocketException` is thrown.
* Require Dart 2.17 or greater.
* Fix issue [#51](https://github.com/grpc/grpc-dart/issues/51), add support for custom error handling.
* Expose client IP address to server
* Add a `channelShutdownHandler` argument to `ClientChannel` and the subclasses.
  This callback can be used to react to channel shutdown or termination.
* Export the `Code` protobuf enum from the `grpc.dart` library.
* Require Dart 3.0.0 or greater.

## 3.1.0

* Expose a stream for connection state changes on ClientChannel to address
  [#428](https://github.com/grpc/grpc-dart/issues/428).
  This allows users to react to state changes in the connection.
* Fix [#576](https://github.com/grpc/grpc-dart/issues/576): set default
  `:authority` value for UDS connections to `localhost` instead of using
  UDS path. Using path triggers checks in HTTP2 servers which
  attempt to validate `:authority` value.

## 3.0.2

* Fix compilation on the Web with DDC.

## 3.0.1

* Require `package:googleapis_auth` `^1.1.0`
* Fix issues [#421](https://github.com/grpc/grpc-dart/issues/421) and
  [#458](https://github.com/grpc/grpc-dart/issues/458). Validate
  responses according to gRPC/gRPC-Web protocol specifications: require
  200 HTTP status and a supported `Content-Type` header to be present, as well
  as `grpc-status: 0` header. When handling malformed responses make effort
  to translate HTTP statuses into gRPC statuses.
* Add GrpcOrGrpcWebClientChannel which uses gRPC on all platforms except web,
  on which it uses gRPC-web.
* `GrpcError` now exposes response trailers via `GrpcError.trailers`.

## 3.0.0

* Migrate library and tests to null safety.
* Require Dart 2.12 or greater.

## 2.9.0

* Added support for compression/decompression, which can be configured through
  `ChannelOptions` constructor's `codecRegistry` parameter or adding the
  `grpc-accept-encoding` to `metadata` parameter of `CallOptions` on the client
  side and `codecRegistry` parameter to `Server` on the server side.
  Outgoing rpc can be compressed using the `compression` parameter on the
  `CallOptions`.
* Fix issue [#206](https://github.com/grpc/grpc-dart/issues/206). Prevent an
  exception to be thrown when a web connection stream is closed.
* Add XHR raw response to the GrpcError for a better debugging
  ([PR #423](https://github.com/grpc/grpc-dart/pulls/423)).

Note: this is the last release supporting SDK < 2.12. Next release will
be nullsafe and thus require SDK >= 2.12.

## 2.8.0

* Added support for client interceptors, which can be configured through
  `Client` constructor's `interceptors` parameter. Interceptors will be
  executed by `Client.$createStreamingCall` and `Client.$createUnaryCall`.
  Using interceptors requires regenerating client stubs using version 19.2.0 or
  newer of protobuf compiler plugin.
* `Client.$createCall` is deprecated because it does not invoke client
  interceptors.
* Fix issue [#380](https://github.com/grpc/grpc-dart/issues/380) causing
  incorrect duplicated headers in gRPC-Web requests.
* Change minimum required Dart SDK to 2.8 to enable access to Unix domain sockets.
* Add support for Unix domain sockets in `Socket.serve` and `ClientChannel`.
* Fix issue [#331](https://github.com/grpc/grpc-dart/issues/331) causing
  an exception in `GrpcWebClientChannel.terminate()`.

## 2.7.0

* Added decoding/parsing of `grpc-status-details-bin` to pass all response
  exception details to the `GrpcError` thrown in Dart, via
  [#349](https://github.com/grpc/grpc-dart/pull/349).
* Dart SDK constraint is bumped to `>=2.3.0 <3.0.0` due to language version
  in the generated protobuf code.

## 2.6.0

* Create gRPC servers and clients with [Server|Client]TransportConnection.
  This allows callers to provide their own transport configuration, such
  as their own implementation of streams and sinks instead of sockets.

## 2.5.0

* Expose a `validateClient` method for server credentials so gRPC server
  users may know when clients are loopback addresses.

## 2.4.1

* Plumb stacktraces through request / response stream error handlers.
* Catch and forward any errors decoding the response.

## 2.4.0

* Add the ability to bypass CORS preflight requests.

## 2.3.0

* Revert [PR #287](https://github.com/grpc/grpc-dart/pull/287), which allowed
using gRPC-web in native environments but also broke streaming.

## 2.2.0+1

* Relax `crypto` version dependency constraint from `^2.1.5` to `^2.1.4`.

## 2.2.0

* Added `applicationDefaultCredentialsAuthenticator` function for creating an
  authenticator using [Application Default Credentials](https://cloud.google.com/docs/authentication/production).
* Less latency by using the `tcpNoDelay` option for sockets.
* Support grpc-web in a non-web setting.

## 2.1.3

* Fix bug in grpc-web when receiving an empty trailer.
* Fix a state bug in the server.

## 2.1.2

* Fix bug introduced in 2.1.1 where the port would be added to the default authority when making a
  secure connection.

## 2.1.1

* Fix bug introduced in 2.1.0 where an explicit `authority` would not be used when making a secure
  connection.

## 2.1.0

* Do a health check of the http2-connection before making request.
* Introduce `ChannelOptions.connectionLimit` the longest time a single connection is used for new
  requests.
* Use Tcp.nodelay to improve client call speed.
* Use SecureSocket supportedProtocols to save a round trip when establishing a secure connection.
* Allow passing http2 `ServerSettings` to `Server.serve`.

## 2.0.3

* GrpcError now implements Exception to indicate it can be reasonably handled.

## 2.0.2

* Fix computation of the audience given to metadata providers to include the scheme.

## 2.0.1

* Fix computation of authority. This should fix authorization.

## 2.0.0+1

* Fix imports to ensure `grpc_web.dart` has no accidental transitive dependencies on dart:io.

## 2.0.0

* Add initial support for grpc-web.
  See `example/grpc-web` for an example of this working.
* **Breaking**: `grpc.dart` no longer exposes `ClientConnection`. It was supposed to be an internal
  abstraction.
* **Breaking**: `grpc.dart` no longer exposes the deprecated `ServerHandler`.
  It was supposed to be an internal abstraction.
* `service_api.dart` no longer exports Server - it has never been used by the generated code.

## 1.0.3

* Allow custom user agent with a `userAgent` argument for `ChannelOptions()`.
* Allow specifying `authority` for `ChannelCredentials.insecure()`.
* Add `userAgent` as an optional named argument for `clientConnection.createCallHeaders()`.

## 1.0.2

* Fix bug where the server would crash if the client would break the connection.

## 1.0.1

* Add `service_api.dart` that only contains the minimal imports needed by the code generated by
  protoc_plugin.

## 1.0.0+1

* Support package:http2  1.0.0.

## 1.0.0

* Graduate package to 1.0.

## 0.6.8+1

* Removes stray files that where published by accident in version 0.6.8.

## 0.6.8

* Calling `terminate()` or `shutdown()` on a channel doesn't throw error if the
channel is not yet open.

## 0.6.7

* Support package:test 1.5.

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

* Dart SDK upper constraint raised to declare compatibility with Dart 2.0 stable.

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
