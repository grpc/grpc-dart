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

class _GrpcMessageConversionSink
    implements ChunkedConversionSink<StreamMessage> {
  final Sink<GrpcMessage> _out;
  final bool _forResponse;

  final _dataHeader = Uint8List(5);
  Uint8List? _data;
  int _dataOffset = 0;

  bool _headersReceived = false;

  _GrpcMessageConversionSink(this._out, this._forResponse);

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
          _dataOffset,
          _dataOffset + toCopy,
          chunkData,
          chunkReadOffset,
        );
        _dataOffset += toCopy;
        chunkReadOffset += toCopy;
        if (_dataOffset == _dataHeader.lengthInBytes) {
          final dataLength = _dataHeader.buffer.asByteData().getUint32(1);
          // TODO(jakobr): Sanity check dataLength. Max size?
          _data = Uint8List(dataLength);
          _dataOffset = 0;
        }
      }
      if (_data != null) {
        // Reading data.
        final dataRemaining = _data!.lengthInBytes - _dataOffset;
        if (dataRemaining > 0) {
          final chunkRemaining = chunkLength - chunkReadOffset;
          final toCopy = min(dataRemaining, chunkRemaining);
          _data!.setRange(
            _dataOffset,
            _dataOffset + toCopy,
            chunkData,
            chunkReadOffset,
          );
          _dataOffset += toCopy;
          chunkReadOffset += toCopy;
        }
        if (_dataOffset == _data!.lengthInBytes) {
          _out.add(
            GrpcData(
              _data!,
              isCompressed: _dataHeader.buffer.asByteData().getUint8(0) != 0,
            ),
          );
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
    if (_data != null || _dataOffset != 0) {
      throw GrpcError.unavailable('Closed in non-idle state');
    }
    _out.close();
  }
}
