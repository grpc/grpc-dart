///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_prefixes
library routeguide_route_guide_pbgrpc;

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'route_guide.pb.dart';
export 'route_guide.pb.dart';

class RouteGuideClient extends Client {
  static final _$getFeature = new ClientMethod<Point, Feature>(
      '/routeguide.RouteGuide/GetFeature',
      (Point value) => value.writeToBuffer(),
      (List<int> value) => new Feature.fromBuffer(value));
  static final _$listFeatures = new ClientMethod<Rectangle, Feature>(
      '/routeguide.RouteGuide/ListFeatures',
      (Rectangle value) => value.writeToBuffer(),
      (List<int> value) => new Feature.fromBuffer(value));
  static final _$recordRoute = new ClientMethod<Point, RouteSummary>(
      '/routeguide.RouteGuide/RecordRoute',
      (Point value) => value.writeToBuffer(),
      (List<int> value) => new RouteSummary.fromBuffer(value));
  static final _$routeChat = new ClientMethod<RouteNote, RouteNote>(
      '/routeguide.RouteGuide/RouteChat',
      (RouteNote value) => value.writeToBuffer(),
      (List<int> value) => new RouteNote.fromBuffer(value));

  RouteGuideClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Feature> getFeature(Point request, {CallOptions options}) {
    final call = $createCall(_$getFeature, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseFuture(call);
  }

  ResponseStream<Feature> listFeatures(Rectangle request,
      {CallOptions options}) {
    final call = $createCall(_$listFeatures, options: options);
    call.request
      ..add(request)
      ..close();
    return new ResponseStream(call);
  }

  ResponseFuture<RouteSummary> recordRoute(Stream<Point> request,
      {CallOptions options}) {
    final call = $createCall(_$recordRoute, options: options);
    request.pipe(call.request);
    return new ResponseFuture(call);
  }

  ResponseStream<RouteNote> routeChat(Stream<RouteNote> request,
      {CallOptions options}) {
    final call = $createCall(_$routeChat, options: options);
    request.pipe(call.request);
    return new ResponseStream(call);
  }
}

abstract class RouteGuideServiceBase extends Service {
  String get $name => 'routeguide.RouteGuide';

  RouteGuideServiceBase() {
    $addMethod(new ServiceMethod(
        'GetFeature',
        getFeature_Pre,
        false,
        false,
        (List<int> value) => new Point.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod(
        'ListFeatures',
        listFeatures_Pre,
        false,
        true,
        (List<int> value) => new Rectangle.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod(
        'RecordRoute',
        recordRoute,
        true,
        false,
        (List<int> value) => new Point.fromBuffer(value),
        (RouteSummary value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod(
        'RouteChat',
        routeChat,
        true,
        true,
        (List<int> value) => new RouteNote.fromBuffer(value),
        (RouteNote value) => value.writeToBuffer()));
  }

  Future<Feature> getFeature_Pre(
      ServiceCall call, Future<Point> request) async {
    return getFeature(call, await request);
  }

  Stream<Feature> listFeatures_Pre(
      ServiceCall call, Future<Rectangle> request) async* {
    yield* listFeatures(call, await request);
  }

  Future<Feature> getFeature(ServiceCall call, Point request);
  Stream<Feature> listFeatures(ServiceCall call, Rectangle request);
  Future<RouteSummary> recordRoute(ServiceCall call, Stream<Point> request);
  Stream<RouteNote> routeChat(ServiceCall call, Stream<RouteNote> request);
}
