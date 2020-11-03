// Copyright (c) 2020, the gRPC project authors. Please see the AUTHORS file
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

import 'dart:developer';

import 'package:meta/meta.dart';

@visibleForTesting
typedef TimelineTask TimelineTaskFactory({String filterKey});

@visibleForTesting
TimelineTaskFactory timelineTaskFactory = _defaultTimelineTaskFactory;

TimelineTask _defaultTimelineTaskFactory({String filterKey}) =>
    TimelineTask(filterKey: filterKey);

/// Enable logging requests and response for clients.
///
/// Logging is disabled by default.
bool isTimelineLoggingEnabled = false;
