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

import 'package:http2/transport.dart';

import '../shared/status.dart';
import '../shared/streams.dart';

import 'common.dart';
import 'connection.dart';
import 'method.dart';
import 'options.dart';

const _reservedHeaders = const [
  'content-type',
  'te',
  'grpc-timeout',
  'grpc-accept-encoding',
  'user-agent',
];

/// An active call to a gRPC endpoint.
class ClientCall<Q, R> implements Response {
  final ClientMethod<Q, R> _method;
  final Stream<Q> _requests;
  final CallOptions options;

  final _headers = new Completer<Map<String, String>>();
  final _trailers = new Completer<Map<String, String>>();
  bool _hasReceivedResponses = false;

  Map<String, String> _headerMetadata;

  TransportStream _stream;
  StreamController<R> _responses;
  StreamSubscription<StreamMessage> _requestSubscription;
  StreamSubscription<GrpcMessage> _responseSubscription;

  bool isCancelled = false;
  Timer _timeoutTimer;

  ClientCall(this._method, this._requests, this.options) {
    _responses = new StreamController(onListen: _onResponseListen);
    if (options.timeout != null) {
      _timeoutTimer = new Timer(options.timeout, _onTimedOut);
    }
  }

  String get path => _method.path;

  void onConnectionError(error) {
    _terminateWithError(new GrpcError.unavailable('Error connecting: $error'));
  }

  void _terminateWithError(GrpcError error) {
    if (!_responses.isClosed) {
      _responses.addError(error);
    }
    _safeTerminate();
  }

  static Map<String, String> _sanitizeMetadata(Map<String, String> metadata) {
    final sanitizedMetadata = <String, String>{};
    metadata.forEach((String key, String value) {
      final lowerCaseKey = key.trim().toLowerCase();
      if (!lowerCaseKey.startsWith(':') &&
          !_reservedHeaders.contains(lowerCaseKey)) {
        sanitizedMetadata[lowerCaseKey] = value.trim();
      }
    });
    return sanitizedMetadata;
  }

  void onConnectionReady(ClientConnection connection) {
    if (isCancelled) return;

    if (options.metadataProviders.isEmpty) {
      _sendRequest(connection, _sanitizeMetadata(options.metadata));
    } else {
      final metadata = new Map<String, String>.from(options.metadata);
      String audience;
      if (connection.options.credentials.isSecure) {
        final port = connection.port != 443 ? ':${connection.port}' : '';
        final lastSlashPos = path.lastIndexOf('/');
        final audiencePath =
            lastSlashPos == -1 ? path : path.substring(0, lastSlashPos);
        audience = 'https://${connection.authority}$port$audiencePath';
      }
      Future.forEach(options.metadataProviders,
              (provider) => provider(metadata, audience))
          .then((_) => _sendRequest(connection, _sanitizeMetadata(metadata)))
          .catchError(_onMetadataProviderError);
    }
  }

  void _onMetadataProviderError(error) {
    _terminateWithError(new GrpcError.internal('Error making call: $error'));
  }

  void _sendRequest(ClientConnection connection, Map<String, String> metadata) {
    try {
      _stream = connection.makeRequest(path, options.timeout, metadata);
    } catch (e) {
      _terminateWithError(new GrpcError.unavailable('Error making call: $e'));
      return;
    }
    _requestSubscription = _requests
        .map(_method.requestSerializer)
        .map(GrpcHttpEncoder.frame)
        .map<StreamMessage>((bytes) => new DataStreamMessage(bytes))
        .handleError(_onRequestError)
        .listen(_stream.outgoingMessages.add,
            onError: _stream.outgoingMessages.addError,
            onDone: _stream.outgoingMessages.close,
            cancelOnError: true);
    // The response stream might have been listened to before _stream was ready,
    // so try setting up the subscription here as well.
    _onResponseListen();
  }

  void _onTimedOut() {
    _responses.addError(new GrpcError.deadlineExceeded('Deadline exceeded'));
    _safeTerminate();
  }

  /// Subscribe to incoming response messages, once [_stream] is available, and
  /// the caller has subscribed to the [_responses] stream.
  void _onResponseListen() {
    if (_stream != null &&
        _responses.hasListener &&
        _responseSubscription == null) {
      _responseSubscription = _stream.incomingMessages
          .transform(new GrpcHttpDecoder())
          .transform(grpcDecompressor())
          .listen(_onResponseData,
              onError: _onResponseError,
              onDone: _onResponseDone,
              cancelOnError: true);
      if (_responses.isPaused) {
        _responseSubscription.pause();
      }
      _responses.onPause = _responseSubscription.pause;
      _responses.onResume = _responseSubscription.resume;
      _responses.onCancel = _responseSubscription.cancel;
    }
  }

  /// Emit an error response to the user, and tear down this call.
  void _responseError(GrpcError error) {
    _responses.addError(error);
    _timeoutTimer?.cancel();
    _requestSubscription?.cancel();
    _responseSubscription.cancel();
    _responses.close();
    _stream.terminate();
  }

  /// Data handler for responses coming from the server. Handles header/trailer
  /// metadata, and forwards response objects to [_responses].
  void _onResponseData(GrpcMessage data) {
    if (data is GrpcData) {
      if (!_headers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received data before headers'));
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received data after trailers'));
        return;
      }
      _responses.add(_method.responseDeserializer(data.data));
      _hasReceivedResponses = true;
    } else if (data is GrpcMetadata) {
      if (!_headers.isCompleted) {
        // TODO(jakobr): Parse, and extract common headers.
        _headerMetadata = data.metadata;
        _headers.complete(_headerMetadata);
        return;
      }
      if (_trailers.isCompleted) {
        _responseError(
            new GrpcError.unimplemented('Received multiple trailers'));
        return;
      }
      final metadata = data.metadata;
      _trailers.complete(metadata);
      // TODO(jakobr): Parse more!
      if (metadata.containsKey('grpc-status')) {
        final status = int.parse(metadata['grpc-status']);
        final message = metadata['grpc-message'];
        if (status != 0) {
          _responseError(new GrpcError.custom(status, message));
        }
      }
    } else {
      _responseError(new GrpcError.unimplemented('Unexpected frame received'));
    }
  }

  /// Handler for response errors. Forward the error to the [_responses] stream,
  /// wrapped if necessary.
  void _onResponseError(error) {
    if (error is GrpcError) {
      _responseError(error);
      return;
    }
    _responseError(new GrpcError.unknown(error.toString()));
  }

  /// Handles closure of the response stream. Verifies that server has sent
  /// response messages and header/trailer metadata, as necessary.
  void _onResponseDone() {
    if (!_headers.isCompleted) {
      _responseError(new GrpcError.unavailable('Did not receive anything'));
      return;
    }
    if (!_trailers.isCompleted) {
      if (_hasReceivedResponses) {
        // Trailers are required after receiving data.
        _responseError(new GrpcError.unavailable('Missing trailers'));
        return;
      }

      // Only received a header frame and no data frames, so the header
      // should contain "trailers" as well (Trailers-Only).
      _trailers.complete(_headerMetadata);
      final status = _headerMetadata['grpc-status'];
      // If status code is missing, we must treat it as '0'. As in 'success'.
      final statusCode = status != null ? int.parse(status) : 0;
      if (statusCode != 0) {
        final message = _headerMetadata['grpc-message'];
        _responseError(new GrpcError.custom(statusCode, message));
      }
    }
    _timeoutTimer?.cancel();
    _responses.close();
    _responseSubscription.cancel();
  }

  /// Error handler for the requests stream. Something went wrong while trying
  /// to send the request to the server. Abort the request, and forward the
  /// error to the user code on the [_responses] stream.
  void _onRequestError(error) {
    if (error is! GrpcError) {
      error = new GrpcError.unknown(error.toString());
    }

    _responses.addError(error);
    _timeoutTimer?.cancel();
    _responses.close();
    _requestSubscription?.cancel();
    _responseSubscription?.cancel();
    _stream.terminate();
  }

  Stream<R> get response => _responses.stream;

  @override
  Future<Map<String, String>> get headers => _headers.future;

  @override
  Future<Map<String, String>> get trailers => _trailers.future;

  @override
  Future<Null> cancel() {
    if (!_responses.isClosed) {
      _responses.addError(new GrpcError.cancelled('Cancelled by client.'));
    }
    return _terminate();
  }

  Future<Null> _terminate() async {
    isCancelled = true;
    _timeoutTimer?.cancel();
    // Don't await _responses.close() here. It'll only complete once the done
    // event has been delivered, and it's the caller of this function that is
    // reading from responses as well, so we might end up deadlocked.
    _responses.close();
    _stream?.terminate();
    final futures = <Future>[];
    if (_requestSubscription != null) {
      futures.add(_requestSubscription.cancel());
    }
    if (_responseSubscription != null) {
      futures.add(_responseSubscription.cancel());
    }
    await Future.wait(futures);
  }

  Future<Null> _safeTerminate() {
    return _terminate().catchError((_) {});
  }
}
