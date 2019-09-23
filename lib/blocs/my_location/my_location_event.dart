import 'package:location/location.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyLocationEvent {}
class AppStatedEvent extends MyLocationEvent {}
class LocationChangedEvent extends MyLocationEvent {
  final LocationData locationData;
  LocationChangedEvent({this.locationData});
}
class FromTimerEvent extends MyLocationEvent {}
class RequestLocationServiceEvent extends MyLocationEvent {}
