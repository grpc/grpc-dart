///
//  Generated code. Do not modify.
///
library routeguide_route_guide_pbjson;

const Point$json = const {
  '1': 'Point',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 5},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 5},
  ],
};

const Rectangle$json = const {
  '1': 'Rectangle',
  '2': const [
    const {'1': 'lo', '3': 1, '4': 1, '5': 11, '6': '.routeguide.Point'},
    const {'1': 'hi', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point'},
  ],
};

const Feature$json = const {
  '1': 'Feature',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point'},
  ],
};

const RouteNote$json = const {
  '1': 'RouteNote',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 11, '6': '.routeguide.Point'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9},
  ],
};

const RouteSummary$json = const {
  '1': 'RouteSummary',
  '2': const [
    const {'1': 'point_count', '3': 1, '4': 1, '5': 5},
    const {'1': 'feature_count', '3': 2, '4': 1, '5': 5},
    const {'1': 'distance', '3': 3, '4': 1, '5': 5},
    const {'1': 'elapsed_time', '3': 4, '4': 1, '5': 5},
  ],
};

const RouteGuide$json = const {
  '1': 'RouteGuide',
  '2': const [
    const {
      '1': 'GetFeature',
      '2': '.routeguide.Point',
      '3': '.routeguide.Feature',
      '4': const {}
    },
    const {
      '1': 'ListFeatures',
      '2': '.routeguide.Rectangle',
      '3': '.routeguide.Feature',
      '4': const {}
    },
    const {
      '1': 'RecordRoute',
      '2': '.routeguide.Point',
      '3': '.routeguide.RouteSummary',
      '4': const {}
    },
    const {
      '1': 'RouteChat',
      '2': '.routeguide.RouteNote',
      '3': '.routeguide.RouteNote',
      '4': const {}
    },
  ],
};

const RouteGuide$messageJson = const {
  '.routeguide.Point': Point$json,
  '.routeguide.Feature': Feature$json,
  '.routeguide.Rectangle': Rectangle$json,
  '.routeguide.RouteSummary': RouteSummary$json,
  '.routeguide.RouteNote': RouteNote$json,
};
