// Copyright (c) 2024, the gRPC project authors. Please see the AUTHORS file
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
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart'
    show ClientConnection, ErrorHandler, GrpcTransportStream;
import 'package:grpc/src/client/call.dart';
import 'package:test/test.dart';

import '../src/client_utils.dart';

class _LoopbackTransportStream implements GrpcTransportStream {
  final StreamController<GrpcMessage> incoming = StreamController();
  final StreamController<List<int>> outgoing = StreamController();

  _LoopbackTransportStream() {
    outgoing.stream.listen((payload) {
      incoming.add(
        GrpcMetadata({':status': '200', 'content-type': 'application/grpc'}),
      );
      incoming.add(GrpcData(payload, isCompressed: false));
      incoming.add(GrpcMetadata({'grpc-status': '0'}));
      incoming.close();
    });
  }

  @override
  Stream<GrpcMessage> get incomingMessages => incoming.stream;

  @override
  StreamSink<List<int>> get outgoingMessages => outgoing.sink;

  @override
  Future<void> terminate() async {
    await outgoing.close();
    await incoming.close();
  }
}

/// Mimics [XhrClientConnection] / custom [ClientConnection] implementations
/// that add transport headers directly into `metadata` and clear `metadata`
/// when moving headers into query parameters (`bypassCorsPreflight`).
class _MutatingMetadataConnection implements ClientConnection {
  final List<Map<String, String>> capturedBeforeClear = [];

  @override
  String get authority => 'example.test';

  @override
  String get scheme => 'http';

  @override
  set onStateChanged(void Function(ConnectionState) cb) {}

  @override
  void dispatchCall(ClientCall call) {
    call.onConnectionReady(this);
  }

  @override
  GrpcTransportStream makeRequest(
    String path,
    Duration? timeout,
    Map<String, String> metadata,
    ErrorHandler onRequestFailure, {
    required CallOptions callOptions,
  }) {
    metadata['Content-Type'] = 'application/grpc-web+proto';
    metadata['X-Grpc-Web'] = '1';
    capturedBeforeClear.add(Map<String, String>.of(metadata));
    if (callOptions is WebCallOptions &&
        callOptions.bypassCorsPreflight == true) {
      metadata.clear();
    }
    return _LoopbackTransportStream();
  }

  @override
  Future<void> shutdown() async {}

  @override
  Future<void> terminate() async {}
}

void main() {
  const dummyValue = 0;
  const cancelDurationMillis = 300;

  late ClientHarness harness;

  setUp(() {
    harness = ClientHarness()..setUp();
  });

  tearDown(() {
    harness.tearDown();
  });

  test('WebCallOptions mergeWith CallOptions returns WebCallOptions', () {
    final options1 = WebCallOptions(
      bypassCorsPreflight: true,
      withCredentials: true,
    );
    final metadata = {'test': '42'};
    final options2 = CallOptions(metadata: metadata);
    final mergedOptions1 = options1.mergedWith(options2) as WebCallOptions;
    final mergedOptions2 = options2.mergedWith(options1) as WebCallOptions;

    expect(mergedOptions1.metadata, metadata);
    expect(mergedOptions1.bypassCorsPreflight, true);
    expect(mergedOptions1.withCredentials, true);

    expect(mergedOptions2.metadata, metadata);
    expect(mergedOptions2.bypassCorsPreflight, true);
    expect(mergedOptions2.withCredentials, true);
  });

  test('Cancelling a call correctly complete headers future', () async {
    final clientCall = harness.client.unary(dummyValue);

    Future.delayed(
      Duration(milliseconds: cancelDurationMillis),
    ).then((_) => clientCall.cancel());

    expect(await clientCall.headers, isEmpty);

    await expectLater(
      clientCall,
      throwsA(
        isA<GrpcError>().having(
          (e) => e.codeName,
          'Test codename',
          contains('CANCELLED'),
        ),
      ),
    );
  });

  test('Cancelling a call correctly complete trailers futures', () async {
    final clientCall = harness.client.unary(dummyValue);

    Future.delayed(Duration(milliseconds: cancelDurationMillis)).then((_) {
      clientCall.cancel();
    });

    expect(await clientCall.trailers, isEmpty);

    await expectLater(
      clientCall,
      throwsA(
        isA<GrpcError>().having(
          (e) => e.codeName,
          'Test codename',
          contains('CANCELLED'),
        ),
      ),
    );
  });

  test(
    'ClientCall passes a fresh mutable metadata map per RPC to custom/web ClientConnections',
    () async {
      final connection = _MutatingMetadataConnection();
      final method = ClientMethod<int, int>(
        '/test.Mutating/Echo',
        (int v) => Uint8List.fromList([v]),
        (List<int> b) => b.isEmpty ? 0 : b[0],
      );

      // 1. Default empty CallOptions() singleton must not throw UnsupportedError
      // when makeRequest mutates metadata in place.
      final defaultCall = ClientCall<int, int>(
        method,
        Stream<int>.value(11),
        CallOptions(),
      );
      connection.dispatchCall(defaultCall);
      expect(await defaultCall.response.single, 11);

      // 2. Empty WebCallOptions(bypassCorsPreflight: true) must allow both
      // header insertion and metadata.clear().
      final corsEmptyCall = ClientCall<int, int>(
        method,
        Stream<int>.value(22),
        WebCallOptions(bypassCorsPreflight: true),
      );
      connection.dispatchCall(corsEmptyCall);
      expect(await corsEmptyCall.response.single, 22);

      // 3. Reusing WebCallOptions with static metadata across RPCs must not
      // lose metadata after the first call's metadata.clear().
      final sharedWebOptions = WebCallOptions(
        metadata: {'X-Api-Key': ' secret '},
        bypassCorsPreflight: true,
      );
      for (final v in [33, 44]) {
        final call = ClientCall<int, int>(
          method,
          Stream<int>.value(v),
          sharedWebOptions,
        );
        connection.dispatchCall(call);
        expect(await call.response.single, v);
      }

      expect(connection.capturedBeforeClear, [
        {'Content-Type': 'application/grpc-web+proto', 'X-Grpc-Web': '1'},
        {'Content-Type': 'application/grpc-web+proto', 'X-Grpc-Web': '1'},
        {
          'x-api-key': 'secret',
          'Content-Type': 'application/grpc-web+proto',
          'X-Grpc-Web': '1',
        },
        {
          'x-api-key': 'secret',
          'Content-Type': 'application/grpc-web+proto',
          'X-Grpc-Web': '1',
        },
      ]);
    },
  );
}
