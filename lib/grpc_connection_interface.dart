// Copyright (c) 2020, the gRPC project authors. Please see the AUTHORS file
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

/// Exports an interface suitable for defining an alternate implementation of
/// [ClientChannel].

export 'src/client/call.dart' show CallOptions, ClientCall;
export 'src/client/channel.dart' show ClientChannelBase;
export 'src/client/connection.dart' show ClientConnection;
export 'src/client/http2_channel.dart' show ClientChannel;
export 'src/client/options.dart' show ChannelOptions;
export 'src/client/transport/transport.dart'
    show GrpcTransportStream, ErrorHandler;

export 'src/shared/codec.dart';
export 'src/shared/codec_registry.dart';
export 'src/shared/message.dart' show frame, GrpcMessage, grpcDecompressor;
export 'src/shared/status.dart' show GrpcError;
export 'src/shared/streams.dart' show GrpcHttpDecoder;
export 'src/shared/timeout.dart' show toTimeoutString;
