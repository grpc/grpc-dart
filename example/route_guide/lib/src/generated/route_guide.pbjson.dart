///
//  Generated code. Do not modify.
///
// ignore_for_file: non_constant_identifier_names,library_prefixes
library routeguide_route_guide_pbjson;

const Point$json = {
  '1': 'Point',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 5, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 5, '10': 'longitude'},
  ],
};

const Rectangle$json = {
  '1': 'Rectangle',
  '2': [
    {'1': 'lo', '3': 1, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'lo'},
    {'1': 'hi', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'hi'},
  ],
};

const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'location',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'location'
    },
  ],
};

const RouteNote$json = {
  '1': 'RouteNote',
  '2': [
    {
      '1': 'location',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.routeguide.Point',
      '10': 'location'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const RouteSummary$json = {
  '1': 'RouteSummary',
  '2': [
    {'1': 'point_count', '3': 1, '4': 1, '5': 5, '10': 'pointCount'},
    {'1': 'feature_count', '3': 2, '4': 1, '5': 5, '10': 'featureCount'},
    {'1': 'distance', '3': 3, '4': 1, '5': 5, '10': 'distance'},
    {'1': 'elapsed_time', '3': 4, '4': 1, '5': 5, '10': 'elapsedTime'},
  ],
};
