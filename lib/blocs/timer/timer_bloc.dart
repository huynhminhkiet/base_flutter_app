import 'dart:async';
import 'package:base_flutter_app/blocs/marker/bloc.dart';
import 'package:base_flutter_app/blocs/my_location/bloc.dart';
import 'package:base_flutter_app/blocs/my_location/my_location_event.dart' as myLocationEvent;
import 'package:base_flutter_app/blocs/marker/marker_event.dart' as markerEvent;
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  Timer _timer;
  MyLocationBloc _myLocationBloc;
  MarkerBloc _markerBloc;

  TimerBloc(MyLocationBloc myLocationBloc, MarkerBloc markerBloc) {
    _myLocationBloc = myLocationBloc;
    _markerBloc = markerBloc;
    _timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      _myLocationBloc.dispatch(myLocationEvent.FromTimerEvent());
      _markerBloc.dispatch(markerEvent.FromTimerEvent());
    });
  }

  @override
  TimerState get initialState => InitialTimerState();

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }
}
