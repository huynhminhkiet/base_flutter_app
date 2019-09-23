import 'package:base_flutter_app/blocs/marker/bloc.dart';
import 'package:base_flutter_app/core/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends BaseState<LogScreen> {
  @override
  Widget onBuild(BuildContext context) {
    return BlocBuilder<MarkerBloc, MarkerState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text("Log"),),
        body: Container(
          child: ListView(
            children: (state as MarkerLoadedState).markers.map((latlng) => _buildLogLayout(latlng)).toList(),
          )
        ),
      );
    });
  }

  Widget _buildLogLayout(LatLng latlng) {
    return ListTile(
      title: Text("${latlng.latitude} - ${latlng.longitude}"),
    );
  }
}
