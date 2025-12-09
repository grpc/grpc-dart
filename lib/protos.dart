// Copyright (c) 2025, the gRPC project authors. Please see the AUTHORS file
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

/// This separate export file helps in reducing conflicts between the dart:core
/// `Duration` and the proto `Duration` class.
///
/// The error types are exported to allow users to switch based on the type.
library;

export 'src/generated/google/protobuf/duration.pb.dart' show Duration;
export 'src/generated/google/rpc/error_details.pb.dart'
    show
        RetryInfo,
        DebugInfo,
        QuotaFailure,
        ErrorInfo,
        PreconditionFailure,
        BadRequest,
        RequestInfo,
        ResourceInfo,
        Help,
        LocalizedMessage,
        BadRequest_FieldViolation,
        Help_Link,
        PreconditionFailure_Violation,
        QuotaFailure_Violation;
