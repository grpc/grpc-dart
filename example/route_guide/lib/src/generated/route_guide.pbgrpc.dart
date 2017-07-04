///
//  Generated code. Do not modify.
//
// ...yeah, alright, is isn't actually generated *yet*, but this is just about
// what it'll look like when it is...
///
import 'dart:async';

import 'package:grpc/grpc.dart';
import 'route_guide.pb.dart';

abstract class RouteGuideClient {
  ResponseFuture<Feature> getFeature(Point request);
  ResponseStream<Feature> listFeatures(Rectangle request);
  ResponseFuture<RouteSummary> recordRoute(Stream<Point> request);
  ResponseStream<RouteNote> routeChat(Stream<RouteNote> request);

  factory RouteGuideClient(ClientChannel channel) = RouteGuideClientImpl;
}

class RouteGuideClientImpl implements RouteGuideClient {
  final ClientChannel _channel;

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

  RouteGuideClientImpl(this._channel);

  @override
  ResponseFuture<Feature> getFeature(Point request) {
    final call = new ClientCall(_channel, _$getFeature);
    call.request
      ..add(request)
      ..close();
    return new ResponseFuture(call);
  }

  @override
  ResponseStream<Feature> listFeatures(Rectangle request) {
    final call = new ClientCall(_channel, _$listFeatures);
    call.request
      ..add(request)
      ..close();
    return new ResponseStream(call);
  }

  @override
  ResponseFuture<RouteSummary> recordRoute(Stream<Point> request) {
    final call = new ClientCall(_channel, _$recordRoute,
        metadata: {'grpc-timeout': '20S'});
    request.pipe(call.request);
    return new ResponseFuture(call);
  }

  @override
  ResponseStream<RouteNote> routeChat(Stream<RouteNote> request) {
    final call = new ClientCall(_channel, _$routeChat);
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
