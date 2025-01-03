// Copyright (c) 2019, the gRPC project authors. Please see the AUTHORS file
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

/// Exports the minimum api to define server and client stubs.
///
/// Mainly intended to be imported by generated code.
library;

export 'src/client/call.dart' show CallOptions, MetadataProvider;
export 'src/client/channel.dart' show ClientChannel;
export 'src/client/client.dart' show Client;
export 'src/client/common.dart' show ResponseFuture, ResponseStream;
export 'src/client/interceptor.dart'
    show ClientInterceptor, ClientUnaryInvoker, ClientStreamingInvoker;
export 'src/client/method.dart' show ClientMethod;
export 'src/server/call.dart' show ServiceCall;
export 'src/server/service.dart' show Service, ServiceMethod;
