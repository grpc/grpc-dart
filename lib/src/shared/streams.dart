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
  /// 1-byte compression flag + 4-byte big-endian uint32 payload length.
  static const int _headerLength = 5;

  Uint8List? _headerBuffer;
  Uint8List? _data;
  bool _pendingIsCompressed = false;
  int _offset = 0;

  /// Whether the parser is currently mid-header or mid-payload across chunks.
  bool get hasPartialFrame => _data != null || _offset != 0;

  /// Parses [chunkData] and invokes [onFrame] for each complete gRPC frame.
  ///
  /// Stops parsing remaining bytes in [chunkData] immediately if [onFrame]
  /// returns `false`.
  void parse(
    List<int> chunkData,
    bool Function(Uint8List payload, bool isCompressed) onFrame,
  ) {
    final chunkLength = chunkData.length;
    if (chunkLength == 0) return;

    final bytes = chunkData is Uint8List
        ? chunkData
        : Uint8List.fromList(chunkData);
    final byteData = ByteData.sublistView(bytes);
    var readOffset = 0;

    while (readOffset < chunkLength) {
      if (_data == null && _offset == 0) {
        final remaining = chunkLength - readOffset;
        if (remaining >= _headerLength) {
          final isCompressed = bytes[readOffset] != 0;
          final dataLength = byteData.getUint32(readOffset + 1);
          if (remaining - _headerLength >= dataLength) {
            final start = readOffset + _headerLength;
            final end = start + dataLength;
            final slice = Uint8List.sublistView(bytes, start, end);
            readOffset = end;
            if (!onFrame(slice, isCompressed)) {
              return;
            }
            continue;
          }
          _pendingIsCompressed = isCompressed;
          _data = Uint8List(dataLength);
          readOffset += _headerLength;
        }
      }

      if (_data == null) {
        // Reading gRPC frame header split across chunks.
        final headerBuffer = _headerBuffer ??= Uint8List(_headerLength);
        final headerRemaining = _headerLength - _offset;
        final chunkRemaining = chunkLength - readOffset;
        final toCopy = min(headerRemaining, chunkRemaining);
        headerBuffer.setRange(_offset, _offset + toCopy, bytes, readOffset);
        _offset += toCopy;
        readOffset += toCopy;
        if (_offset == _headerLength) {
          _pendingIsCompressed = headerBuffer[0] != 0;
          final dataLength = ByteData.sublistView(headerBuffer).getUint32(1);
          // TODO(jakobr): Sanity check dataLength. Max size?
          _data = Uint8List(dataLength);
          _offset = 0;
        }
      }

      if (_data case final data?) {
        // Reading frame payload split across chunks.
        final dataRemaining = data.lengthInBytes - _offset;
        if (dataRemaining > 0) {
          final chunkRemaining = chunkLength - readOffset;
          final toCopy = min(dataRemaining, chunkRemaining);
          data.setRange(_offset, _offset + toCopy, bytes, readOffset);
          _offset += toCopy;
          readOffset += toCopy;
        }
        if (_offset == data.lengthInBytes) {
          final isCompressed = _pendingIsCompressed;
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

final Uint8List headerNameStatus = ascii.encode(':status');
final Uint8List headerNameContentType = ascii.encode('content-type');
final Uint8List headerNamePath = ascii.encode(':path');
final Uint8List headerNameGrpcTimeout = ascii.encode('grpc-timeout');
final Uint8List headerNameGrpcEncoding = ascii.encode('grpc-encoding');
final Uint8List headerNameGrpcAcceptEncoding = ascii.encode(
  'grpc-accept-encoding',
);
final Uint8List headerNameGrpcStatus = ascii.encode('grpc-status');

final Uint8List _contentTypeGrpcPrefix = ascii.encode('application/grpc');
final Uint8List _contentTypeJsonProtoPrefix = ascii.encode(
  'application/json+protobuf',
);
final Uint8List _contentTypeXProtoPrefix = ascii.encode(
  'application/x-protobuf',
);

bool headerBytesEqual(List<int> a, List<int> b) {
  final len = a.length;
  if (len != b.length) return false;
  for (var i = 0; i < len; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool headerBytesStartsWith(List<int> bytes, List<int> prefix) {
  final prefixLen = prefix.length;
  if (bytes.length < prefixLen) return false;
  for (var i = 0; i < prefixLen; i++) {
    if (bytes[i] != prefix[i]) return false;
  }
  return true;
}

Map<String, String> decodeHeadersToMetadata(List<Header> rawHeaders) {
  final headers = <String, String>{};
  for (var i = 0; i < rawHeaders.length; i++) {
    final header = rawHeaders[i];
    // TODO(jakobr): Handle duplicate header names correctly.
    headers[ascii.decode(header.name)] = ascii.decode(header.value);
  }
  return headers;
}

bool isRawGrpcStatusOk(List<Header> rawHeaders) {
  List<int>? statusValue;
  for (var i = 0; i < rawHeaders.length; i++) {
    final header = rawHeaders[i];
    if (headerBytesEqual(header.name, headerNameGrpcStatus)) {
      statusValue = header.value;
    }
  }
  return statusValue != null &&
      statusValue.length == 1 &&
      statusValue[0] == 0x30;
}

void validateRawHttp2ResponseHeaders(List<Header> rawHeaders) {
  List<int>? statusValue;
  List<int>? contentTypeValue;
  for (var i = 0; i < rawHeaders.length; i++) {
    final header = rawHeaders[i];
    final name = header.name;
    if (headerBytesEqual(name, headerNameStatus)) {
      statusValue = header.value;
    } else if (headerBytesEqual(name, headerNameContentType)) {
      contentTypeValue = header.value;
    }
  }

  final isStatus200 =
      statusValue != null &&
      statusValue.length == 3 &&
      statusValue[0] == 0x32 &&
      statusValue[1] == 0x30 &&
      statusValue[2] == 0x30;
  final isValidContentType =
      contentTypeValue != null &&
      (headerBytesStartsWith(contentTypeValue, _contentTypeGrpcPrefix) ||
          headerBytesStartsWith(
            contentTypeValue,
            _contentTypeJsonProtoPrefix,
          ) ||
          headerBytesStartsWith(contentTypeValue, _contentTypeXProtoPrefix));

  if (isStatus200 && isValidContentType) {
    return;
  }

  final headers = decodeHeadersToMetadata(rawHeaders);
  final statusHeader = headers[':status'];
  final httpStatus = statusHeader != null ? int.tryParse(statusHeader) : null;
  validateHttpStatusAndContentType(httpStatus, headers);
}

class Http2GrpcMetadata extends LazyGrpcMetadata {
  final List<Header> rawHeaders;
  Map<String, String>? _metadata;

  Http2GrpcMetadata(this.rawHeaders);

  bool get isMaterialized => _metadata != null;

  @override
  Map<String, String> get metadata =>
      _metadata ??= decodeHeadersToMetadata(rawHeaders);

  @override
  String? lookupRawAsciiValue(List<int> lowerCaseAsciiName) {
    final existing = _metadata;
    if (existing != null) {
      return existing[ascii.decode(lowerCaseAsciiName)];
    }
    List<int>? matched;
    for (var i = 0; i < rawHeaders.length; i++) {
      final header = rawHeaders[i];
      if (headerBytesEqual(header.name, lowerCaseAsciiName)) {
        matched = header.value;
      }
    }
    return matched == null ? null : ascii.decode(matched);
  }

  @override
  bool get isGrpcStatusZero {
    final existing = _metadata;
    if (existing != null) {
      return existing['grpc-status'] == '0';
    }
    return isRawGrpcStatusOk(rawHeaders);
  }

  @override
  String toString() => 'gRPC Metadata ($metadata)';
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
    if (!_headersReceived) {
      if (_forResponse) {
        // Validate :status and content-type header here synchronously before
        // attempting to parse subsequent DataStreamMessage.
        //
        // Validation might throw an exception. When [GrpcHttpDecoder] is
        // used as a [StreamTransformer] the underlying implementation of
        // [StreamTransformer.bind] will take care of forwarding this
        // exception into the stream as an error.
        validateRawHttp2ResponseHeaders(chunk.headers);
      }
      _headersReceived = true;
    }
    _out.add(Http2GrpcMetadata(chunk.headers));
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
