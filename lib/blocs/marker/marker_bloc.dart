import 'dart:async';
import 'dart:math' as Math;

import 'package:base_flutter_app/blocs/marker/bloc.dart' as marker;
import 'package:base_flutter_app/blocs/my_location/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_math/vector_math.dart';

import './bloc.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  Set<LatLng> _markers;
  Set<LatLng> get markers => _markers;

  MyLocationBloc _myLocationBloc;

  MarkerBloc(MyLocationBloc myLocationBloc) {
    _myLocationBloc = myLocationBloc;
    _markers = new Set<LatLng>();
  }


  @override
  MarkerState get initialState => MarkerLoadedState(markers: new Set<LatLng>());

  @override
  Stream<MarkerState> mapEventToState(
    MarkerEvent event,
  ) async* {

    if (event is marker.FromTimerEvent) {
      if (_shouldAddMarker()) {
        _markers.add(LatLng(_myLocationBloc.cacheLocationData.latitude, _myLocationBloc.cacheLocationData.longitude
        ));
        yield new marker.MarkerLoadedState(markers: _markers);
      }
    }

  }

  double distFrom(double lat1, double lng1, double lat2, double lng2) {
    double earthRadius = 6371000; //meters
    double dLat = radians(lat2-lat1);
    double dLng = radians(lng2-lng1);
    double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(radians(lat1)) * Math.cos(radians(lat2)) *
            Math.sin(dLng/2) * Math.sin(dLng/2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    double dist = earthRadius * c;
    return dist;
  }

  bool _shouldAddMarker() {

    if (_myLocationBloc.cacheLocationData == null) return false;

    if (_markers.length == 0) return true;

    double dis = distFrom(_myLocationBloc.cacheLocationData.latitude, _myLocationBloc.cacheLocationData.longitude,
        _markers.last.latitude, _markers.last.longitude);

    print("dis " + dis.toString() + " "+ _markers.last.latitude.toString() + " " + _markers.last.longitude.toString());
    print("dis " + dis.toString() + " "+ _myLocationBloc.cacheLocationData.latitude.toString() + " " + _myLocationBloc.cacheLocationData.longitude.toString());

    return dis > 50;
  }
}
