// Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
import 'dart:math';

// Formula for calculating distance between two coordinates
// https://stackoverflow.com/a/54138876/11910277
double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}