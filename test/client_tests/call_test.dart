// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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

import 'package:grpc/src/client/call.dart';
import 'package:test/test.dart';

void main() {
  test('WebCallOptions mergeWith CallOptions returns WebCallOptions', () {
    final options =
        WebCallOptions(bypassCorsPreflight: true, withCredentials: true);
    final metadata = {'test': '42'};
    final mergedOptions =
        options.mergedWith(CallOptions(metadata: metadata)) as WebCallOptions;

    expect(mergedOptions.metadata, metadata);
    expect(mergedOptions.bypassCorsPreflight, true);
    expect(mergedOptions.withCredentials, true);
  });
}
