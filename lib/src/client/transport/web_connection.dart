// Copyright (c) 2026, the gRPC project authors. Please see the AUTHORS file
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

import 'package:meta/meta.dart';

import '../../client/call.dart';
import '../../version.dart';
import '../connection.dart';
import 'cors.dart' as cors;
import 'transport.dart';

const _contentTypeKey = 'Content-Type';

/// A gRPC-web connection: one HTTP request per call, with no connection
/// state of its own.
///
/// Adds the gRPC-web request headers, applies [WebCallOptions], and tracks
/// open streams so [terminate] can end them. Subclasses send the request.
abstract class WebClientConnection<S extends GrpcTransportStream>
    implements ClientConnection {
  final Uri uri;

  final _requests = <S>{};

  WebClientConnection(this.uri);

  @override
  String get authority => uri.authority;

  @override
  String get scheme => uri.scheme;

  /// Creates the stream for one call: a POST to [requestUri] with [headers].
  ///
  /// The stream must call [onDone] once when it closes.
  @protected
  S createStream(
    Uri requestUri,
    Map<String, String> headers,
    ErrorHandler onError, {
    required bool withCredentials,
    required void Function(S stream) onDone,
  });

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onError, {
    CallOptions? callOptions,
  }) {
    // gRPC-web headers.
    if (_getContentTypeHeader(metadata) == null) {
      metadata['Content-Type'] = 'application/grpc-web+proto';
      metadata['X-User-Agent'] = 'grpc-web-dart/$packageVersion';
      metadata['X-Grpc-Web'] = '1';
    }

    var requestUri = uri.resolve(path);
    if (callOptions is WebCallOptions &&
        callOptions.bypassCorsPreflight == true) {
      requestUri = cors.moveHttpHeadersToQueryParam(metadata, requestUri);
    }

    final transportStream = createStream(
      requestUri,
      metadata,
      onError,
      withCredentials:
          callOptions is WebCallOptions && callOptions.withCredentials == true,
      onDone: _requests.remove,
    );
    _requests.add(transportStream);
    return transportStream;
  }

  @override
  Future<void> terminate() async {
    for (var request in List.of(_requests)) {
      request.terminate();
    }
  }

  @override
  void dispatchCall(ClientCall call) {
    call.onConnectionReady(this);
  }

  @override
  Future<void> shutdown() async {}

  @override
  set onStateChanged(void Function(ConnectionState) cb) {
    // Do nothing.
  }
}

MapEntry<String, String>? _getContentTypeHeader(Map<String, String> metadata) {
  for (var entry in metadata.entries) {
    if (entry.key.toLowerCase() == _contentTypeKey.toLowerCase()) {
      return entry;
    }
  }
  return null;
}
