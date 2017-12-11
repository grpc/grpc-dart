// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Server-side context for a gRPC call.
///
/// Gives the method handler access to custom metadata from the client, and
/// ability to set custom metadata on the header/trailer sent to the client.
abstract class ServiceCall {
  /// Custom metadata from the client.
  Map<String, String> get clientMetadata;

  /// Custom metadata to be sent to the client. Will be [null] once the headers
  /// have been sent, either when [sendHeaders] is called, or when the first
  /// response message is sent.
  Map<String, String> get headers;

  /// Custom metadata to be sent to the client after all response messages.
  Map<String, String> get trailers;

  /// Deadline for this call. If the call is still active after this time, then
  /// the client or server may cancel it.
  DateTime get deadline;

  /// Returns [true] if the [deadline] has been exceeded.
  bool get isTimedOut;

  /// Returns [true] if the client has canceled this call.
  bool get isCanceled;

  /// Send response headers. This is done automatically before sending the first
  /// response message, but can be done manually before the first response is
  /// ready, if necessary.
  void sendHeaders();

  /// Send response trailers. A trailer indicating success ([status] == 0) will
  /// be sent automatically when all responses are sent. This method can be used
  /// to send a different status code, if needed.
  ///
  /// The call will be closed after calling this method, and no further
  /// responses can be sent.
  void sendTrailers({int status, String message});
}
