import 'package:base_flutter_app/core/page/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationUtils {
  static Future<dynamic> pushReplacement(BuildContext context, List<BlocProvider> blocs, Widget page) {

    blocs.add(BlocProvider<PageBloc>(builder: (context) => PageBloc()));

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MultiBlocProvider(
        providers: blocs,
        child: page,
      )),
    );
  }

  static Future<dynamic> push(BuildContext context, List<BlocProvider> blocs, Widget page) {

    blocs.add(BlocProvider<PageBloc>(builder: (context) => PageBloc()));

    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MultiBlocProvider(
        providers: blocs,
        child: page,
      )),
    );
  }
}