import 'dart:async';

import 'package:base_flutter_app/blocs/marker/bloc.dart';
import 'package:base_flutter_app/blocs/my_location/bloc.dart';
import 'package:base_flutter_app/core/base_screen.dart';
import 'package:base_flutter_app/core/localization/localization.dart';
import 'package:base_flutter_app/core/navigation_utils.dart';
import 'package:base_flutter_app/ui/screens/log_screen.dart';
import 'package:base_flutter_app/ui/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = new Set();
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers = new Set();
  }

  @override
  Widget onBuild(BuildContext context) {
    final MyLocationBloc myLocationBloc =
        BlocProvider.of<MyLocationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).home),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _navigateToSettingScreen();
              })
        ],
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          BlocListener<MarkerBloc, MarkerState> (
            listener: (context, markerState) async {

              if (_markerIcon == null) {
                final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(10, 10));
                _markerIcon = await BitmapDescriptor.fromAssetImage(imageConfiguration, 'assets/marker.png');
              }


              if (markerState is MarkerLoadedState) {
                _markers = markerState.markers.map((latlng) => Marker(
                    markerId: MarkerId(DateTime.now().toIso8601String()),
                    position: latlng,
                    icon: _markerIcon)).toSet();
              }
            },
            child: BlocBuilder<MarkerBloc, MarkerState>(
                builder: (context, mState) {
              return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _locationDataToLatLng(
                        myLocationBloc.cacheLocationData),
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true);
            }),
          ),
          BlocBuilder<MyLocationBloc, MyLocationState>(
              builder: (context, myLocationState) {
            if (myLocationState is LocationServiceDisableState) {
              return Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: Card(
                  child: Container(
                      padding: EdgeInsets.only(left: 16),
                      width: double.maxFinite,
                      child: Row(
                        children: <Widget>[
                          Text("Please enable location service!"),
                          FlatButton(
                              onPressed: () {
                                myLocationBloc
                                    .dispatch(RequestLocationServiceEvent());
                              },
                              child: Text("Enable"))
                        ],
                      )),
                ),
              );
            }

            return Container();
          }),
          Container(
            child: IconButton(icon: Icon(Icons.assistant), onPressed: () {
              NavigationUtils.push(context, [], LogScreen());
            }),
          )
        ],
      )),
    );
  }

  void _navigateToSettingScreen() {
    NavigationUtils.push(context, [], SettingScreen());
  }

  LatLng _locationDataToLatLng(LocationData locationData) {
    if (locationData == null) return LatLng(0,0);
    return LatLng(locationData.latitude, locationData.longitude);
  }
}
