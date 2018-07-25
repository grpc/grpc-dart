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
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http2/transport.dart';

import 'status.dart';

abstract class GrpcMessage {}

class GrpcMetadata extends GrpcMessage {
  final Map<String, String> metadata;
  GrpcMetadata(this.metadata);

  @override
  String toString() => 'gRPC Metadata ($metadata)';
}

class GrpcData extends GrpcMessage {
  final List<int> data;
  final bool isCompressed;
  GrpcData(this.data, {this.isCompressed});

  @override
  String toString() => 'gRPC Data (${data.length} bytes)';
}

StreamTransformer<GrpcMessage, GrpcMessage> grpcDecompressor() =>
    new StreamTransformer<GrpcMessage, GrpcMessage>.fromHandlers(
        handleData: (GrpcMessage value, EventSink<GrpcMessage> sink) {
      if (value is GrpcData) {
        if (value.isCompressed) {
          // TODO(dart-lang/grpc-dart#6): Actually handle decompression.
          sink.add(new GrpcData(value.data, isCompressed: false));
          return;
        }
      }
      sink.add(value);
    });

class GrpcHttpEncoder extends Converter<GrpcMessage, StreamMessage> {
  @override
  StreamMessage convert(GrpcMessage input) {
    if (input is GrpcMetadata) {
      final headers = <Header>[];
      input.metadata.forEach((key, value) {
        headers.add(new Header(ascii.encode(key), utf8.encode(value)));
      });
      return new HeadersStreamMessage(headers);
    } else if (input is GrpcData) {
      return new DataStreamMessage(frame(input.data));
    }
    throw new GrpcError.internal('Unexpected message type');
  }

  static List<int> frame(List<int> payload) {
    final payloadLength = payload.length;
    final bytes = new Uint8List(payloadLength + 5);
    final header = bytes.buffer.asByteData(0, 5);
    header.setUint8(0, 0); // TODO(dart-lang/grpc-dart#6): Handle compression
    header.setUint32(1, payloadLength);
    bytes.setRange(5, bytes.length, payload);
    return bytes;
  }
}

class GrpcHttpDecoder extends Converter<StreamMessage, GrpcMessage> {
  @override
  GrpcMessage convert(StreamMessage input) {
    final sink = new _GrpcMessageSink();
    startChunkedConversion(sink)
      ..add(input)
      ..close();
    return sink.message;
  }

  @override
  Sink<StreamMessage> startChunkedConversion(Sink<GrpcMessage> sink) {
    return new _GrpcMessageConversionSink(sink);
  }
}

class _GrpcMessageConversionSink extends ChunkedConversionSink<StreamMessage> {
  final Sink<GrpcMessage> _out;

  final _dataHeader = new Uint8List(5);
  Uint8List _data;
  int _dataOffset = 0;

  _GrpcMessageConversionSink(this._out);

  void _addData(DataStreamMessage chunk) {
    final chunkData = chunk.bytes;
    final chunkLength = chunkData.length;
    var chunkReadOffset = 0;

    while (chunkReadOffset < chunkLength) {
      if (_data == null) {
        // Reading header.
        final headerRemaining = _dataHeader.lengthInBytes - _dataOffset;
        final chunkRemaining = chunkLength - chunkReadOffset;
        final toCopy = min(headerRemaining, chunkRemaining);
        _dataHeader.setRange(
            _dataOffset, _dataOffset + toCopy, chunkData, chunkReadOffset);
        _dataOffset += toCopy;
        chunkReadOffset += toCopy;
        if (_dataOffset == _dataHeader.lengthInBytes) {
          final dataLength = _dataHeader.buffer.asByteData().getUint32(1);
          // TODO(jakobr): Sanity check dataLength. Max size?
          _data = new Uint8List(dataLength);
          _dataOffset = 0;
        }
      }
      if (_data != null) {
        // Reading data.
        final dataRemaining = _data.lengthInBytes - _dataOffset;
        if (dataRemaining > 0) {
          final chunkRemaining = chunkLength - chunkReadOffset;
          final toCopy = min(dataRemaining, chunkRemaining);
          _data.setRange(
              _dataOffset, _dataOffset + toCopy, chunkData, chunkReadOffset);
          _dataOffset += toCopy;
          chunkReadOffset += toCopy;
        }
        if (_dataOffset == _data.lengthInBytes) {
          _out.add(new GrpcData(_data,
              isCompressed: _dataHeader.buffer.asByteData().getUint8(0) != 0));
          _data = null;
          _dataOffset = 0;
        }
      }
    }
  }

  void _addHeaders(HeadersStreamMessage chunk) {
    if (_data != null || _dataOffset != 0) {
      // We were in the middle of receiving data, so receiving a header frame
      // is a violation of the gRPC protocol.
      throw new GrpcError.unimplemented('Received header while reading data');
    }
    final headers = <String, String>{};
    for (var header in chunk.headers) {
      // TODO(jakobr): Handle duplicate header names correctly.
      headers[ascii.decode(header.name)] = ascii.decode(header.value);
    }
    // TODO(jakobr): Check :status, go to error mode if not 2xx.
    _out.add(new GrpcMetadata(headers));
  }

  @override
  void add(StreamMessage chunk) {
    if (chunk is DataStreamMessage) {
      _addData(chunk);
    } else if (chunk is HeadersStreamMessage) {
      _addHeaders(chunk);
    } else {
      // No clue what this is.
      throw new GrpcError.unimplemented('Received unknown HTTP/2 frame type');
    }
  }

  @override
  void close() {
    if (_data != null || _dataOffset != 0) {
      throw new GrpcError.unavailable('Closed in non-idle state');
    }
    _out.close();
  }
}

class _GrpcMessageSink extends Sink<GrpcMessage> {
  GrpcMessage message;

  @override
  void add(GrpcMessage data) {
    if (message != null) {
      throw 'Too many messages received!';
    }
    message = data;
  }

  @override
  void close() {
    if (message == null) {
      throw 'No messages received!';
    }
  }
}
