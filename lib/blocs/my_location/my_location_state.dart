import 'package:location/location.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLocationState {}

class InitialMyLocationState extends MyLocationState {}

class LocationPermissionGrantedState extends MyLocationState {}
class LocationPermissionDenyState extends MyLocationState {}
class LocationServiceEnableState extends MyLocationState {}
class LocationServiceDisableState extends MyLocationState {}
class LocationChangedState extends MyLocationState {
  final LocationData locationData;
  LocationChangedState({this.locationData});
}
