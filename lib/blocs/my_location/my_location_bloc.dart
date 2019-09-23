import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:location/location.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {

  Location location = new Location();
  LocationData cacheLocationData;

  @override
  MyLocationState get initialState => InitialMyLocationState();

  @override
  Stream<MyLocationState> mapEventToState(
    MyLocationEvent event,
  ) async* {

    if (event is AppStatedEvent) {
      bool hasPermission = await location.hasPermission();
      if (hasPermission) {

        yield new LocationPermissionGrantedState();

        bool serviceEnable = await location.serviceEnabled();
        if (serviceEnable) {
          yield new LocationServiceEnableState();
        } else {
          yield new LocationServiceDisableState();
        }

      } else {
        yield new LocationPermissionDenyState();

      }
    }
    
    if (event is LocationChangedEvent) {
      yield new LocationPermissionGrantedState();
      yield new LocationServiceEnableState();
      yield new LocationChangedState(locationData: event.locationData);
    }

    if (event is FromTimerEvent) {
      bool serviceEnable = await location.serviceEnabled();
      if (serviceEnable) {
        yield new LocationServiceEnableState();
        cacheLocationData = await location.getLocation();
        dispatch(LocationChangedEvent(locationData: cacheLocationData));
      } else {
        yield new LocationServiceDisableState();
      }
    }

    if (event is RequestLocationServiceEvent) {
      bool requestService = await location.requestService();
      if (requestService) {
        yield new LocationServiceEnableState();
      } else {
        yield new LocationServiceDisableState();
      }
    }

  }
}
