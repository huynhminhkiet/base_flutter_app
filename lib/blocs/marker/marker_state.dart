import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MarkerState {}

class MarkerLoadedState extends MarkerState {
  final Set<LatLng> markers;

  MarkerLoadedState({this.markers});
}
