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

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http2/transport.dart';

import 'message.dart';
import 'status.dart';

class GrpcHttpEncoder extends Converter<GrpcMessage, StreamMessage> {
  @override
  StreamMessage convert(GrpcMessage input) {
    if (input is GrpcMetadata) {
      final headers = <Header>[];
      input.metadata.forEach((key, value) {
        headers.add(Header(ascii.encode(key), utf8.encode(value)));
      });
      return HeadersStreamMessage(headers);
    } else if (input is GrpcData) {
      return DataStreamMessage(frame(input.data));
    }
    throw GrpcError.internal('Unexpected message type');
  }
}

class GrpcHttpDecoder extends Converter<StreamMessage, GrpcMessage> {
  /// [true] if this decoder is used for decoding responses.
  final bool forResponse;

  GrpcHttpDecoder({this.forResponse = false});

  @override
  GrpcMessage convert(StreamMessage input) {
    final sink = GrpcMessageSink();
    startChunkedConversion(sink)
      ..add(input)
      ..close();
    return sink.message;
  }

  @override
  Sink<StreamMessage> startChunkedConversion(Sink<GrpcMessage> sink) {
    return _GrpcMessageConversionSink(sink, forResponse);
  }
}

/// Incremental parser for 5-byte length-prefixed gRPC wire frames.
///
/// When an entire frame (`5 + length` bytes) is present in an incoming
/// [Uint8List] chunk, emits a zero-copy [Uint8List.sublistView] directly over
/// the chunk buffer instead of allocating and copying into a new buffer.
class GrpcFrameParser {
  Uint8List? _headerBuffer;
  Uint8List? _data;
  int _offset = 0;

  /// Whether the parser is currently mid-header or mid-payload across chunks.
  bool get hasPartialFrame => _data != null || _offset != 0;

  static int _readUint32BE(List<int> bytes, int offset) =>
      ((bytes[offset] & 0xFF) * 0x1000000) +
      (((bytes[offset + 1] & 0xFF) << 16) |
          ((bytes[offset + 2] & 0xFF) << 8) |
          (bytes[offset + 3] & 0xFF));

  /// Parses [chunkData] and invokes [onFrame] for each complete gRPC frame.
  ///
  /// Stops parsing remaining bytes in [chunkData] immediately if [onFrame]
  /// returns `false`.
  void parse(
    List<int> chunkData,
    bool Function(Uint8List payload, bool isCompressed) onFrame,
  ) {
    final chunkLength = chunkData.length;
    var readOffset = 0;

    while (readOffset < chunkLength) {
      if (_data == null && _offset == 0) {
        final remaining = chunkLength - readOffset;
        if (remaining >= 5) {
          final isCompressed = chunkData[readOffset] != 0;
          final dataLength = _readUint32BE(chunkData, readOffset + 1);
          if (remaining - 5 >= dataLength) {
            final start = readOffset + 5;
            final end = start + dataLength;
            final slice = chunkData is Uint8List
                ? Uint8List.sublistView(chunkData, start, end)
                : Uint8List.fromList(chunkData.sublist(start, end));
            readOffset = end;
            if (!onFrame(slice, isCompressed)) {
              return;
            }
            continue;
          }
          (_headerBuffer ??= Uint8List(5))[0] = isCompressed ? 1 : 0;
          _data = Uint8List(dataLength);
          readOffset += 5;
        }
      }

      if (_data == null) {
        // Reading 5-byte gRPC frame header split across chunks.
        final headerBuffer = _headerBuffer ??= Uint8List(5);
        final headerRemaining = 5 - _offset;
        final chunkRemaining = chunkLength - readOffset;
        final toCopy = min(headerRemaining, chunkRemaining);
        headerBuffer.setRange(_offset, _offset + toCopy, chunkData, readOffset);
        _offset += toCopy;
        readOffset += toCopy;
        if (_offset == 5) {
          final dataLength = _readUint32BE(headerBuffer, 1);
          // TODO(jakobr): Sanity check dataLength. Max size?
          _data = Uint8List(dataLength);
          _offset = 0;
        }
      }

      if (_data != null) {
        // Reading frame payload split across chunks.
        final data = _data!;
        final dataRemaining = data.lengthInBytes - _offset;
        if (dataRemaining > 0) {
          final chunkRemaining = chunkLength - readOffset;
          final toCopy = min(dataRemaining, chunkRemaining);
          data.setRange(_offset, _offset + toCopy, chunkData, readOffset);
          _offset += toCopy;
          readOffset += toCopy;
        }
        if (_offset == data.lengthInBytes) {
          final isCompressed = _headerBuffer![0] != 0;
          _data = null;
          _offset = 0;
          if (!onFrame(data, isCompressed)) {
            return;
          }
        }
      }
    }
  }
}

class _GrpcMessageConversionSink
    implements ChunkedConversionSink<StreamMessage> {
  final Sink<GrpcMessage> _out;
  final bool _forResponse;
  final GrpcFrameParser _frameParser = GrpcFrameParser();

  bool _headersReceived = false;

  _GrpcMessageConversionSink(this._out, this._forResponse);

  bool _emitFrame(Uint8List payload, bool isCompressed) {
    _out.add(GrpcData(payload, isCompressed: isCompressed));
    return true;
  }

  void _addData(DataStreamMessage chunk) {
    _frameParser.parse(chunk.bytes, _emitFrame);
  }

  void _addHeaders(HeadersStreamMessage chunk) {
    if (_frameParser.hasPartialFrame) {
      // We were in the middle of receiving data, so receiving a header frame
      // is a violation of the gRPC protocol.
      throw GrpcError.unimplemented('Received header while reading data');
    }
    final headers = <String, String>{};
    for (var header in chunk.headers) {
      // TODO(jakobr): Handle duplicate header names correctly.
      headers[ascii.decode(header.name)] = ascii.decode(header.value);
    }
    if (!_headersReceived) {
      if (_forResponse) {
        // Validate :status and content-type header here synchronously before
        // attempting to parse subsequent DataStreamMessage.
        final httpStatus = headers.containsKey(':status')
            ? int.tryParse(headers[':status']!)
            : null;

        // Validation might throw an exception. When [GrpcHttpDecoder] is
        // used as a [StreamTransformer] the underlying implementation of
        // [StreamTransformer.bind] will take care of forwarding this
        // exception into the stream as an error.
        validateHttpStatusAndContentType(httpStatus, headers);
      }
      _headersReceived = true;
    }
    _out.add(GrpcMetadata(headers));
  }

  @override
  void add(StreamMessage chunk) {
    if (chunk is DataStreamMessage) {
      _addData(chunk);
    } else if (chunk is HeadersStreamMessage) {
      _addHeaders(chunk);
    } else {
      // No clue what this is.
      throw GrpcError.unimplemented('Received unknown HTTP/2 frame type');
    }
  }

  @override
  void close() {
    if (_frameParser.hasPartialFrame) {
      throw GrpcError.unavailable('Closed in non-idle state');
    }
    _out.close();
  }
}
