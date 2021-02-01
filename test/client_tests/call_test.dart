import 'package:grpc/src/client/call.dart';
import 'package:test/test.dart';

void main() {
  test('WebCallOptions mergeWith CallOptions returns WebCallOptions', () {
    final options =
        WebCallOptions(bypassCorsPreflight: true, withCredentials: true);
    final metadata = {'test': '42'};
    final mergedOptions =
        options.mergedWith(CallOptions(metadata: metadata)) as WebCallOptions;

    expect(mergedOptions.metadata, metadata);
    expect(mergedOptions.bypassCorsPreflight, true);
    expect(mergedOptions.withCredentials, true);
  });
}
