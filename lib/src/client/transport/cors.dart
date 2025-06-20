// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
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

// Provides CORS support for HTTP based RPC requests.

/// The default URL parameter name to overwrite http headers with a URL param
/// to avoid CORS preflight.
///
/// This comes from the JS impl details at
/// https://github.com/whatwg/fetch/issues/210#issue-129531743.
const _httpHeadersParamName = r'$httpHeaders';

// TODO(mightyvoice): Add the const parameter name for HTTP method if not
// always use POST for gRPC-web.

/// Manipulates the path and headers of the http request such that it will
/// not trigger a CORS preflight request and returns the new path with extra
/// query parameters.
///
/// A proxy server that understands the '$httpHeaders' query parameter
/// is required for this to work correctly.
Uri moveHttpHeadersToQueryParam(Map<String, String> metadata, Uri requestUri) {
  // Nothing to do if there are no headers.
  if (metadata.isEmpty) {
    return requestUri;
  }

  final paramValue = _generateHttpHeadersOverwriteParam(metadata);
  metadata.clear();
  return requestUri.replace(
    queryParameters: Map.of(requestUri.queryParameters)
      ..[_httpHeadersParamName] = paramValue,
  );
}

/// Generates the URL parameter value with custom headers encoded as
/// HTTP/1.1 headers block.
String _generateHttpHeadersOverwriteParam(Map<String, String> headers) =>
    headers.entries.map((e) => '${e.key}:${e.value}\r\n').join();
