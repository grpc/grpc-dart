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

import 'codec.dart';
import 'codec_registry.dart';
import 'message.dart';
import 'status.dart';

/// HTTP/2 stream receive window requested by package:grpc's client and server
/// connections, instead of the protocol's default of 64 KiB.
///
/// Larger windows let more data be in flight per round trip, but also let more
/// data be queued ahead of other calls on the same connection.
const defaultStreamWindowSize = 256 * 1024;

/// HTTP/2 connection receive window requested by package:grpc's client and
/// server connections, instead of the protocol's default of 64 KiB.
const defaultConnectionWindowSize = 1024 * 1024;

/// Adds [payload] to [sink] as one length-prefixed gRPC message.
///
/// Uncompressed [Uint8List] payloads larger than [zeroCopyFrameThreshold] are
/// added as a separate 5-byte prefix followed by [payload] itself, without
/// copying it. package:http2 may keep a reference to [payload] until the peer's
/// flow-control window allows it to be sent, so [payload] must not be modified
/// afterwards.
void addGrpcMessage(
  StreamSink<StreamMessage> sink,
  List<int> payload,
  Codec? codec, {
  bool endStream = false,
}) {
  if (payload is Uint8List &&
      payload.length > zeroCopyFrameThreshold &&
      isIdentityCodec(codec)) {
    sink
      ..add(DataStreamMessage(frameHeader(payload.length)))
      ..add(DataStreamMessage(payload, endStream: endStream));
  } else {
    sink.add(DataStreamMessage(frame(payload, codec), endStream: endStream));
  }
}

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

/// A [GrpcHttpDecoder] that also decompresses messages with the codec named by
/// the `grpc-encoding` header, like a following [grpcDecompressor] would, but
/// without a second stream transformation per call.
class GrpcDecompressingHttpDecoder extends GrpcHttpDecoder {
  final CodecRegistry? codecRegistry;

  GrpcDecompressingHttpDecoder({super.forResponse, this.codecRegistry});

  @override
  Sink<StreamMessage> startChunkedConversion(Sink<GrpcMessage> sink) {
    return _GrpcMessageConversionSink(
      sink,
      forResponse,
      decompress: true,
      codecRegistry: codecRegistry,
    );
  }
}

class _GrpcMessageConversionSink
    implements ChunkedConversionSink<StreamMessage> {
  final Sink<GrpcMessage> _out;
  final bool _forResponse;

  /// Whether compressed messages are decompressed with [_codec].
  final bool _decompress;
  final CodecRegistry? _codecRegistry;
  Codec? _codec;

  static const _headerLength = 5;
  final _dataHeader = Uint8List(_headerLength);
  Uint8List? _data;
  int _dataOffset = 0;

  bool _headersReceived = false;

  _GrpcMessageConversionSink(
    this._out,
    this._forResponse, {
    bool decompress = false,
    CodecRegistry? codecRegistry,
  }) : _decompress = decompress,
       _codecRegistry = codecRegistry;

  void _addMessage(Uint8List data, {required bool isCompressed}) {
    if (isCompressed && _decompress) {
      final codec = _codec;
      if (codec == null) {
        throw GrpcError.unimplemented('Compression mechanism not supported');
      }
      _out.add(GrpcData(codec.decompress(data), isCompressed: false));
    } else {
      _out.add(GrpcData(data, isCompressed: isCompressed));
    }
  }

  void _addData(DataStreamMessage chunk) {
    final chunkData = chunk.bytes;
    final chunkLength = chunkData.length;
    var chunkReadOffset = 0;

    while (chunkReadOffset < chunkLength) {
      if (_data == null && _dataOffset == 0 && chunkData is Uint8List) {
        // Fast path: emit a complete frame as a view into the chunk.
        final start = chunkReadOffset + _headerLength;
        if (start <= chunkLength) {
          final header = ByteData.sublistView(chunkData, chunkReadOffset);
          final end = start + header.getUint32(1);
          if (end <= chunkLength) {
            chunkReadOffset = end;
            _addMessage(
              Uint8List.sublistView(chunkData, start, end),
              isCompressed: header.getUint8(0) != 0,
            );
            continue;
          }
        }
      }
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
        if (_data case final data? when _dataOffset == data.lengthInBytes) {
          _data = null;
          _dataOffset = 0;
          _addMessage(data, isCompressed: _dataHeader[0] != 0);
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
    if (_decompress) {
      if (headers['grpc-encoding'] case final encoding?) {
        _codec = _codecRegistry?.lookup(encoding);
      }
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
