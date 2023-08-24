// Copyright (c) 2023, the gRPC project authors. Please see the AUTHORS file
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

import '../shared/status.dart';
import 'call.dart';
import 'service.dart';

/// A gRPC Interceptor.
///
/// An interceptor is called before the corresponding [ServiceMethod] invocation.
/// If the interceptor returns a [GrpcError], the error will be returned as a response and [ServiceMethod] wouldn't be called.
/// If the interceptor throws [Exception], [GrpcError.internal] with exception.toString() will be returned.
/// If the interceptor returns null, the corresponding [ServiceMethod] of [Service] will be called.
typedef Interceptor = FutureOr<GrpcError?> Function(
    ServiceCall call, ServiceMethod method);
