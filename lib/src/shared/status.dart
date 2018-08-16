// Copyright (c) 2017, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class StatusCode {
  /// The operation completed successfully.
  static const ok = 0;

  /// The operation was cancelled (typically by the caller).
  static const cancelled = 1;

  /// Unknown error. An example of where this error may be returned is if a
  /// Status value received from another address space belongs to an error-space
  /// that is not known in this address space. Also errors raised by APIs that
  /// do not return enough error information may be converted to this error.
  static const unknown = 2;

  /// Client specified an invalid argument. Note that this differs from
  /// [failedPrecondition]. [invalidArgument] indicates arguments that are
  /// problematic regardless of the state of the system (e.g., a malformed file
  /// name).
  static const invalidArgument = 3;

  /// Deadline expired before operation could complete. For operations that
  /// change the state of the system, this error may be returned even if the
  /// operation has completed successfully. For example, a successful response
  /// from a server could have been delayed long enough for the deadline to
  /// expire.
  static const deadlineExceeded = 4;

  /// Some requested entity (e.g., file or directory) was not found.
  static const notFound = 5;

  /// Some entity that we attempted to create (e.g., file or directory) already
  /// exists.
  static const alreadyExists = 6;

  /// The caller does not have permission to execute the specified operation.
  /// [permissionDenied] must not be used for rejections caused by exhausting
  /// some resource (use [resourceExhausted] instead for those errors).
  /// [permissionDenied] must not be used if the caller cannot be identified
  /// (use [unauthenticated] instead for those errors).
  static const permissionDenied = 7;

  /// Some resource has been exhausted, perhaps a per-user quota, or perhaps the
  /// entire file system is out of space.
  static const resourceExhausted = 8;

  /// Operation was rejected because the system is not in a state required for
  /// the operation's execution. For example, directory to be deleted may be
  /// non-empty, an rmdir operation is applied to a non-directory, etc.
  ///
  /// A litmus test that may help a service implementor in deciding between
  /// [failedPrecondition], [aborted], and [unavailable]:
  /// (a) Use [unavailable] if the client can retry just the failing call.
  /// (b) Use [aborted] if the client should retry at a higher-level (e.g.,
  ///     restarting a read-modify-write sequence).
  /// (c) Use [failedPrecondition] if the client should not retry until the
  ///     system state has been explicitly fixed.  E.g., if an "rmdir" fails
  ///     because the directory is non-empty, [failedPrecondition] should be
  ///     returned since the client should not retry unless they have first
  ///     fixed up the directory by deleting files from it.
  static const failedPrecondition = 9;

  /// The operation was aborted, typically due to a concurrency issue like
  /// sequencer check failures, transaction aborts, etc.
  ///
  /// See litmus test above for deciding between [failedPrecondition],
  /// [aborted], and [unavailable].
  static const aborted = 10;

  /// Operation was attempted past the valid range. E.g., seeking or reading
  /// past end of file.
  ///
  /// Unlike invalidArgument, this error indicates a problem that may be fixed
  /// if the system state changes. For example, a 32-bit file system will
  /// generate invalidArgument if asked to read at an offset that is not in the
  /// range [0,2^32-1], but it will generate [outOfRange] if asked to read from
  /// an offset past the current file size.
  ///
  /// There is a fair bit of overlap between [failedPrecondition] and
  /// [outOfRange]. We recommend using [outOfRange] (the more specific error)
  /// when it applies so that callers who are iterating through a space can
  /// easily look for an [outOfRange] error to detect when they are done.
  static const outOfRange = 11;

  /// Operation is not implemented or not supported/enabled in this service.
  static const unimplemented = 12;

  /// Internal errors. Means some invariants expected by underlying system has
  /// been broken. If you see one of these errors, something is very broken.
  static const internal = 13;

  /// The service is currently unavailable.  This is a most likely a transient
  /// condition and may be corrected by retrying with a backoff.
  ///
  /// See litmus test above for deciding between [failedPrecondition],
  /// [aborted], and [unavailable].
  static const unavailable = 14;

  /// Unrecoverable data loss or corruption.
  static const dataLoss = 15;

  /// The request does not have valid authentication credentials for the
  /// operation.
  static const unauthenticated = 16;
}

class GrpcError {
  final int code;
  final String message;

  /// Custom error code.
  GrpcError.custom(this.code, [this.message]);

  /// The operation completed successfully.
  GrpcError.ok([this.message]) : code = StatusCode.ok;

  /// The operation was cancelled (typically by the caller).
  GrpcError.cancelled([this.message]) : code = StatusCode.cancelled;

  /// Unknown error. An example of where this error may be returned is if a
  /// Status value received from another address space belongs to an error-space
  /// that is not known in this address space. Also errors raised by APIs that
  /// do not return enough error information may be converted to this error.
  GrpcError.unknown([this.message]) : code = StatusCode.unknown;

  /// Client specified an invalid argument. Note that this differs from
  /// [failedPrecondition]. [invalidArgument] indicates arguments that are
  /// problematic regardless of the state of the system (e.g., a malformed file
  /// name).
  GrpcError.invalidArgument([this.message]) : code = StatusCode.invalidArgument;

  /// Deadline expired before operation could complete. For operations that
  /// change the state of the system, this error may be returned even if the
  /// operation has completed successfully. For example, a successful response
  /// from a server could have been delayed long enough for the deadline to
  /// expire.
  GrpcError.deadlineExceeded([this.message])
      : code = StatusCode.deadlineExceeded;

  /// Some requested entity (e.g., file or directory) was not found.
  GrpcError.notFound([this.message]) : code = StatusCode.notFound;

  /// Some entity that we attempted to create (e.g., file or directory) already
  /// exists.
  GrpcError.alreadyExists([this.message]) : code = StatusCode.alreadyExists;

  /// The caller does not have permission to execute the specified operation.
  /// [permissionDenied] must not be used for rejections caused by exhausting
  /// some resource (use [resourceExhausted] instead for those errors).
  /// [permissionDenied] must not be used if the caller cannot be identified
  /// (use [unauthenticated] instead for those errors).
  GrpcError.permissionDenied([this.message])
      : code = StatusCode.permissionDenied;

  /// Some resource has been exhausted, perhaps a per-user quota, or perhaps the
  /// entire file system is out of space.
  GrpcError.resourceExhausted([this.message])
      : code = StatusCode.resourceExhausted;

  /// Operation was rejected because the system is not in a state required for
  /// the operation's execution. For example, directory to be deleted may be
  /// non-empty, an rmdir operation is applied to a non-directory, etc.
  ///
  /// A litmus test that may help a service implementor in deciding between
  /// [failedPrecondition], [aborted], and [unavailable]:
  /// (a) Use [unavailable] if the client can retry just the failing call.
  /// (b) Use [aborted] if the client should retry at a higher-level (e.g.,
  ///     restarting a read-modify-write sequence).
  /// (c) Use [failedPrecondition] if the client should not retry until the
  ///     system state has been explicitly fixed.  E.g., if an "rmdir" fails
  ///     because the directory is non-empty, [failedPrecondition] should be
  ///     returned since the client should not retry unless they have first
  ///     fixed up the directory by deleting files from it.
  GrpcError.failedPrecondition([this.message])
      : code = StatusCode.failedPrecondition;

  /// The operation was aborted, typically due to a concurrency issue like
  /// sequencer check failures, transaction aborts, etc.
  ///
  /// See litmus test above for deciding between [failedPrecondition],
  /// [aborted], and [unavailable].
  GrpcError.aborted([this.message]) : code = StatusCode.aborted;

  /// Operation was attempted past the valid range. E.g., seeking or reading
  /// past end of file.
  ///
  /// Unlike invalidArgument, this error indicates a problem that may be fixed
  /// if the system state changes. For example, a 32-bit file system will
  /// generate invalidArgument if asked to read at an offset that is not in the
  /// range [0,2^32-1], but it will generate [outOfRange] if asked to read from
  /// an offset past the current file size.
  ///
  /// There is a fair bit of overlap between [failedPrecondition] and
  /// [outOfRange]. We recommend using [outOfRange] (the more specific error)
  /// when it applies so that callers who are iterating through a space can
  /// easily look for an [outOfRange] error to detect when they are done.
  GrpcError.outOfRange([this.message]) : code = StatusCode.outOfRange;

  /// Operation is not implemented or not supported/enabled in this service.
  GrpcError.unimplemented([this.message]) : code = StatusCode.unimplemented;

  /// Internal errors. Means some invariants expected by underlying system has
  /// been broken. If you see one of these errors, something is very broken.
  GrpcError.internal([this.message]) : code = StatusCode.internal;

  /// The service is currently unavailable.  This is a most likely a transient
  /// condition and may be corrected by retrying with a backoff.
  ///
  /// See litmus test above for deciding between [failedPrecondition],
  /// [aborted], and [unavailable].
  GrpcError.unavailable([this.message]) : code = StatusCode.unavailable;

  /// Unrecoverable data loss or corruption.
  GrpcError.dataLoss([this.message]) : code = StatusCode.dataLoss;

  /// The request does not have valid authentication credentials for the
  /// operation.
  GrpcError.unauthenticated([this.message]) : code = StatusCode.unauthenticated;

  @override
  bool operator ==(other) {
    if (other is! GrpcError) return false;
    return code == other.code && message == other.message;
  }

  @override
  int get hashCode => code.hashCode ^ (message?.hashCode ?? 17);

  @override
  String toString() => 'gRPC Error ($code, $message)';
}
