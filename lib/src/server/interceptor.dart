import '../shared/status.dart';

import 'call.dart';

abstract class Interceptor {
  GrpcError handle(ServiceCall call);
}
