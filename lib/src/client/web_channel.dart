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
import 'options.dart';
import 'transport/browser_fetch.dart';
import 'transport/fetch_transport.dart';
import 'transport/xhr_transport.dart';

/// A channel to a grpc-web endpoint.
class GrpcWebClientChannel extends ClientChannelBase {
  final Uri uri;

  /// The browser API calls are sent with.
  final GrpcWebTransport transport;

  /// Creates a channel to [uri] whose calls are sent with [transport].
  GrpcWebClientChannel(
    this.uri, {
    this.transport = GrpcWebTransport.xhr,
    super.channelShutdownHandler,
  });

  /// Creates a channel to [uri] whose calls are sent with `XMLHttpRequest`.
  GrpcWebClientChannel.xhr(this.uri, {super.channelShutdownHandler})
    : transport = GrpcWebTransport.xhr;

  @override
  ClientConnection createConnection() {
    return switch (transport) {
      GrpcWebTransport.xhr => XhrClientConnection(uri),
      GrpcWebTransport.fetch => FetchClientConnection(
        uri,
        BrowserFetchRequest.new,
      ),
    };
  }
}
