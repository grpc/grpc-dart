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

/// Enclosing class for query parameters that can accommodate a [List] of
/// [String] values.
///
/// Note: though query param values can be [String], [int], or [Int64], this
/// simple class always expects a [String]. This is to avoid [dynamic] typing,
/// plus the whole thing will be converted to [String] later anyway.
class QueryParameter implements Comparable<QueryParameter> {
  /// The parameter key.
  final String key;

  /// The list of parameter values.
  final List<String> values;

  /// Convenience method for single-value params.
  String get value => values.first;

  /// Creates an instance by wrapping the single value in a [List].
  QueryParameter(this.key, String value) : values = [value] {
    ArgumentError.checkNotNull(key);
    if (key.trim().isEmpty) {
      throw ArgumentError(key);
    }
  }

  /// Creates an instance from a [List] of values.
  ///
  /// This is not the default constructor since the single-value case is the
  /// most common.
  QueryParameter.multi(this.key, List<String> values)
    : values = values..sort() {
    ArgumentError.checkNotNull(key);
    if (key.trim().isEmpty) {
      throw ArgumentError(key);
    }
  }

  /// Returns the escaped value of the param as will appear in a URL.
  @override
  String toString() => values.map(_encode).join('&');

  /// Returns the encoded version of a single key-value pair.
  String _encode(String value) {
    final safeKey = Uri.encodeQueryComponent(key);
    final safeVal = Uri.encodeQueryComponent(value);
    return '$safeKey=$safeVal';
  }

  /// Compares this to another [QueryParameter] based on its string value.
  @override
  int compareTo(QueryParameter other) => toString().compareTo(other.toString());

  static String buildQuery(List<QueryParameter> queryParams) {
    if (queryParams.isEmpty) {
      return '';
    }
    final buf = StringBuffer();
    // Sorts the query params to ensure a canonical path.
    final sortedParamValues = queryParams
      ..sort()
      ..map((param) => param.toString());
    buf.writeAll(sortedParamValues, '&');
    return buf.toString();
  }
}
