///
//  Generated code. Do not modify.
///
library routeguide_route_guide_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'route_guide.pb.dart';
import 'route_guide.pbjson.dart';

export 'route_guide.pb.dart';

abstract class RouteGuideServiceBase extends GeneratedService {
  Future<Feature> getFeature(ServerContext ctx, Point request);
  Future<Feature> listFeatures(ServerContext ctx, Rectangle request);
  Future<RouteSummary> recordRoute(ServerContext ctx, Point request);
  Future<RouteNote> routeChat(ServerContext ctx, RouteNote request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'GetFeature':
        return new Point();
      case 'ListFeatures':
        return new Rectangle();
      case 'RecordRoute':
        return new Point();
      case 'RouteChat':
        return new RouteNote();
      default:
        throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(
      ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'GetFeature':
        return this.getFeature(ctx, request);
      case 'ListFeatures':
        return this.listFeatures(ctx, request);
      case 'RecordRoute':
        return this.recordRoute(ctx, request);
      case 'RouteChat':
        return this.routeChat(ctx, request);
      default:
        throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => RouteGuide$json;
  Map<String, Map<String, dynamic>> get $messageJson => RouteGuide$messageJson;
}
