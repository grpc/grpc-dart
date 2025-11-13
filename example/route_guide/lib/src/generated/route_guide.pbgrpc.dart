// This is a generated file - do not edit.
//
// Generated from route_guide.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'route_guide.pb.dart' as $0;

export 'route_guide.pb.dart';

/// Interface exported by the server.
@$pb.GrpcServiceName('routeguide.RouteGuide')
class RouteGuideClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RouteGuideClient(super.channel, {super.options, super.interceptors});

  /// A simple RPC.
  ///
  /// Obtains the feature at a given position.
  ///
  /// A feature with an empty name is returned if there's no feature at the given
  /// position.
  $grpc.ResponseFuture<$0.Feature> getFeature(
    $0.Point request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFeature, request, options: options);
  }

  /// A server-to-client streaming RPC.
  ///
  /// Obtains the Features available within the given Rectangle.  Results are
  /// streamed rather than returned at once (e.g. in a response message with a
  /// repeated field), as the rectangle may cover a large area and contain a
  /// huge number of features.
  $grpc.ResponseStream<$0.Feature> listFeatures(
    $0.Rectangle request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$listFeatures, $async.Stream.fromIterable([request]),
        options: options);
  }

  /// A client-to-server streaming RPC.
  ///
  /// Accepts a stream of Points on a route being traversed, returning a
  /// RouteSummary when traversal is completed.
  $grpc.ResponseFuture<$0.RouteSummary> recordRoute(
    $async.Stream<$0.Point> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$recordRoute, request, options: options)
        .single;
  }

  /// A Bidirectional streaming RPC.
  ///
  /// Accepts a stream of RouteNotes sent while a route is being traversed,
  /// while receiving other RouteNotes (e.g. from other users).
  $grpc.ResponseStream<$0.RouteNote> routeChat(
    $async.Stream<$0.RouteNote> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$routeChat, request, options: options);
  }

  // method descriptors

  static final _$getFeature = $grpc.ClientMethod<$0.Point, $0.Feature>(
      '/routeguide.RouteGuide/GetFeature',
      ($0.Point value) => value.writeToBuffer(),
      $0.Feature.fromBuffer);
  static final _$listFeatures = $grpc.ClientMethod<$0.Rectangle, $0.Feature>(
      '/routeguide.RouteGuide/ListFeatures',
      ($0.Rectangle value) => value.writeToBuffer(),
      $0.Feature.fromBuffer);
  static final _$recordRoute = $grpc.ClientMethod<$0.Point, $0.RouteSummary>(
      '/routeguide.RouteGuide/RecordRoute',
      ($0.Point value) => value.writeToBuffer(),
      $0.RouteSummary.fromBuffer);
  static final _$routeChat = $grpc.ClientMethod<$0.RouteNote, $0.RouteNote>(
      '/routeguide.RouteGuide/RouteChat',
      ($0.RouteNote value) => value.writeToBuffer(),
      $0.RouteNote.fromBuffer);
}

@$pb.GrpcServiceName('routeguide.RouteGuide')
abstract class RouteGuideServiceBase extends $grpc.Service {
  $core.String get $name => 'routeguide.RouteGuide';

  RouteGuideServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Point, $0.Feature>(
        'GetFeature',
        getFeature_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Point.fromBuffer(value),
        ($0.Feature value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Rectangle, $0.Feature>(
        'ListFeatures',
        listFeatures_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Rectangle.fromBuffer(value),
        ($0.Feature value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Point, $0.RouteSummary>(
        'RecordRoute',
        recordRoute,
        true,
        false,
        ($core.List<$core.int> value) => $0.Point.fromBuffer(value),
        ($0.RouteSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RouteNote, $0.RouteNote>(
        'RouteChat',
        routeChat,
        true,
        true,
        ($core.List<$core.int> value) => $0.RouteNote.fromBuffer(value),
        ($0.RouteNote value) => value.writeToBuffer()));
  }

  $async.Future<$0.Feature> getFeature_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Point> $request) async {
    return getFeature($call, await $request);
  }

  $async.Future<$0.Feature> getFeature(
      $grpc.ServiceCall call, $0.Point request);

  $async.Stream<$0.Feature> listFeatures_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Rectangle> $request) async* {
    yield* listFeatures($call, await $request);
  }

  $async.Stream<$0.Feature> listFeatures(
      $grpc.ServiceCall call, $0.Rectangle request);

  $async.Future<$0.RouteSummary> recordRoute(
      $grpc.ServiceCall call, $async.Stream<$0.Point> request);

  $async.Stream<$0.RouteNote> routeChat(
      $grpc.ServiceCall call, $async.Stream<$0.RouteNote> request);
}
