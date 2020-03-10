///
//  Generated code. Do not modify.
//  source: route_guide.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'route_guide.pb.dart' as $0;
export 'route_guide.pb.dart';

class RouteGuideClient extends $grpc.Client {
  static final _$getFeature = $grpc.ClientMethod<$0.Point, $0.Feature>(
      '/routeguide.RouteGuide/GetFeature',
      ($0.Point value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Feature.fromBuffer(value));
  static final _$listFeatures = $grpc.ClientMethod<$0.Rectangle, $0.Feature>(
      '/routeguide.RouteGuide/ListFeatures',
      ($0.Rectangle value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Feature.fromBuffer(value));
  static final _$recordRoute = $grpc.ClientMethod<$0.Point, $0.RouteSummary>(
      '/routeguide.RouteGuide/RecordRoute',
      ($0.Point value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RouteSummary.fromBuffer(value));
  static final _$routeChat = $grpc.ClientMethod<$0.RouteNote, $0.RouteNote>(
      '/routeguide.RouteGuide/RouteChat',
      ($0.RouteNote value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RouteNote.fromBuffer(value));

  RouteGuideClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.Feature> getFeature($0.Point request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getFeature, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Feature> listFeatures($0.Rectangle request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$listFeatures, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<$0.RouteSummary> recordRoute(
      $async.Stream<$0.Point> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$recordRoute, request, options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.RouteNote> routeChat(
      $async.Stream<$0.RouteNote> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$routeChat, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

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
      $grpc.ServiceCall call, $async.Future<$0.Point> request) async {
    return getFeature(call, await request);
  }

  $async.Stream<$0.Feature> listFeatures_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Rectangle> request) async* {
    yield* listFeatures(call, await request);
  }

  $async.Future<$0.Feature> getFeature(
      $grpc.ServiceCall call, $0.Point request);
  $async.Stream<$0.Feature> listFeatures(
      $grpc.ServiceCall call, $0.Rectangle request);
  $async.Future<$0.RouteSummary> recordRoute(
      $grpc.ServiceCall call, $async.Stream<$0.Point> request);
  $async.Stream<$0.RouteNote> routeChat(
      $grpc.ServiceCall call, $async.Stream<$0.RouteNote> request);
}
