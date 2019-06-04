///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library routeguide_route_guide_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'route_guide.pb.dart';
export 'route_guide.pb.dart';

class RouteGuideClient extends Client {
  static final _$getFeature = ClientMethod<Point, Feature>(
      '/routeguide.RouteGuide/GetFeature',
      (Point value) => value.writeToBuffer(),
      (List<int> value) => Feature.fromBuffer(value));
  static final _$listFeatures = ClientMethod<Rectangle, Feature>(
      '/routeguide.RouteGuide/ListFeatures',
      (Rectangle value) => value.writeToBuffer(),
      (List<int> value) => Feature.fromBuffer(value));
  static final _$recordRoute = ClientMethod<Point, RouteSummary>(
      '/routeguide.RouteGuide/RecordRoute',
      (Point value) => value.writeToBuffer(),
      (List<int> value) => RouteSummary.fromBuffer(value));
  static final _$routeChat = ClientMethod<RouteNote, RouteNote>(
      '/routeguide.RouteGuide/RouteChat',
      (RouteNote value) => value.writeToBuffer(),
      (List<int> value) => RouteNote.fromBuffer(value));

  RouteGuideClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Feature> getFeature(Point request, {CallOptions options}) {
    final call = $createCall(_$getFeature, Stream.fromIterable([request]),
        options: options);
    return ResponseFuture(call);
  }

  ResponseStream<Feature> listFeatures(Rectangle request,
      {CallOptions options}) {
    final call = $createCall(_$listFeatures, Stream.fromIterable([request]),
        options: options);
    return ResponseStream(call);
  }

  ResponseFuture<RouteSummary> recordRoute(Stream<Point> request,
      {CallOptions options}) {
    final call = $createCall(_$recordRoute, request, options: options);
    return ResponseFuture(call);
  }

  ResponseStream<RouteNote> routeChat(Stream<RouteNote> request,
      {CallOptions options}) {
    final call = $createCall(_$routeChat, request, options: options);
    return ResponseStream(call);
  }
}

abstract class RouteGuideServiceBase extends Service {
  String get $name => 'routeguide.RouteGuide';

  RouteGuideServiceBase() {
    $addMethod(ServiceMethod<Point, Feature>(
        'GetFeature',
        getFeature_Pre,
        false,
        false,
        (List<int> value) => Point.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<Rectangle, Feature>(
        'ListFeatures',
        listFeatures_Pre,
        false,
        true,
        (List<int> value) => Rectangle.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<Point, RouteSummary>(
        'RecordRoute',
        recordRoute,
        true,
        false,
        (List<int> value) => Point.fromBuffer(value),
        (RouteSummary value) => value.writeToBuffer()));
    $addMethod(ServiceMethod<RouteNote, RouteNote>(
        'RouteChat',
        routeChat,
        true,
        true,
        (List<int> value) => RouteNote.fromBuffer(value),
        (RouteNote value) => value.writeToBuffer()));
  }

  Future<Feature> getFeature_Pre(ServiceCall call, Future request) async {
    return getFeature(call, await request);
  }

  Stream<Feature> listFeatures_Pre(ServiceCall call, Future request) async* {
    yield* listFeatures(call, (await request) as Rectangle);
  }

  Future<Feature> getFeature(ServiceCall call, Point request);
  Stream<Feature> listFeatures(ServiceCall call, Rectangle request);
  Future<RouteSummary> recordRoute(ServiceCall call, Stream<Point> request);
  Stream<RouteNote> routeChat(ServiceCall call, Stream<RouteNote> request);
}
