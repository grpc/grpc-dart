// Copyright 2018 Google Inc. All Rights Reserved.
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

import '../query_parameter.dart';

/// The default URL parameter name to overwrite http headers with a URL param
/// to avoid CORS preflight.
///
/// This comes from the JS impl details at
/// https://github.com/whatwg/fetch/issues/210#issue-129531743.
const _httpHeadersParamName = '\$httpHeaders';

// TODO(mightyvoice): Add the const parameter name for HTTP method if not
// always use POST for gRPC-web.

/// Manipulates the path and headers of the http request such that it will
/// not trigger a CORS preflight request and returns the new path with extra
/// query parameters.
///
/// For more info on exactly what may trigger CORS preflight, see
/// https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS.
/// Basically, there are three restrictions:
///
/// 1. There are only a few request headers that won't trigger preflight. This
/// implementation just always appends all of them as a specially formatted
/// URL param.
///
/// 2. 'Content-Type' specifically is restricted to
/// 'application/x-www-url-form-encoded', 'multipart/form-data', and
/// 'text/plain'.
String bypassCorsPreflight(Map<String, String> metadata, String path) {
  final params = <QueryParameter>[];

  // Writes all request headers into the URL.
  if (metadata.isNotEmpty) {
    final headerParam = _generateHttpHeadersOverwriteParam(metadata);
    params.add(QueryParameter(_httpHeadersParamName, headerParam));
    metadata.clear();
  }

  final query = QueryParameter.buildQuery(params);

  // Appends the query to current path.
  if (path.contains('?') && path.contains('=')) {
    path = '$path&$query';
  } else {
    path = '$path?$query';
  }
  return path;
}

/// Generates the URL parameter value with custom headers encoded as
/// HTTP/1.1 headers block.
String _generateHttpHeadersOverwriteParam(Map<String, String> headers) {
  final result = StringBuffer();
  headers.forEach((key, value) {
    result.write(key);
    result.write(':');
    result.write(value);
    result.write('\r\n');
  });
  return result.toString();
}
