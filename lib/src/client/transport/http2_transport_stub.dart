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

import 'dart:async';

import '../options.dart';

import 'transport.dart';

class Http2Transport extends Transport {
  Http2Transport(String host, int port, ChannelOptions options);

  @override
  Future<void> connect() {
    return Future.value();
  }

  @override
  Future<void> finish() {
    return Future.value();
  }

  @override
  GrpcTransportStream makeRequest(
      String path, Duration timeout, Map<String, String> metadata) {
    return null;
  }

  @override
  Future<void> terminate() {
    return Future.value();
  }
}
