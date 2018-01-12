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

import 'dart:async';

import 'call.dart';
import 'channel.dart';
import 'method.dart';
import 'options.dart';

/// Base class for client stubs.
class Client {
  final ClientChannel _channel;
  final CallOptions _options;

  Client(this._channel, {CallOptions options})
      : _options = options ?? new CallOptions();

  ClientCall<Q, R> $createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests,
      {CallOptions options}) {
    return _channel.createCall(method, requests, _options.mergedWith(options));
  }
}
