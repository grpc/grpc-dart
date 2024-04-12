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

import 'channel.dart';
import 'connection.dart';
import 'transport/xhr_transport.dart';

/// A channel to a grpc-web endpoint.
class GrpcWebClientChannel extends ClientChannelBase {
  final Uri uri;

  /// The path to prefix to the URI when making requests. Omit '/' at start and end.
  final String prefixPath;

  GrpcWebClientChannel.xhr(this.uri,
      {this.prefixPath = '', super.channelShutdownHandler})
      : assert(
            prefixPath.isEmpty ||
                prefixPath.isNotEmpty && !prefixPath.endsWith('/'),
            'prefixPath must be empty or does not start and end with /');

  @override
  ClientConnection createConnection() {
    return XhrClientConnection(
      uri,
      prefixPath: prefixPath,
    );
  }
}
