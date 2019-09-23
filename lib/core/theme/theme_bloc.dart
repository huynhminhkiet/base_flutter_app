import 'dart:async';
import 'package:base_flutter_app/data/prefs/app_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppPreferences prefs = Injector.getInjector().get<AppPreferences>();

  @override
  ThemeState get initialState => ThemeState(
    theme: ThemeData.light()
  );

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {

    if (event is ThemeChangedEvent) {

      int themeType = event.themeType;

      if (themeType == null) {
        themeType = await prefs.getThemeType();
        if (themeType == null) {
          themeType = LIGHT;
          await prefs.putThemeType(LIGHT);
        }
      } else {
        await prefs.putThemeType(themeType);
      }

      yield new ThemeState(theme: _getTheme(themeType), themeType: themeType);
    }

  }

  _getTheme(int themeType) {
    if (themeType == LIGHT) {
      return ThemeData.light();
    } else if (themeType == DARK) {
      return ThemeData.dark();
    }

    return ThemeData.light();
  }
}

const LIGHT = 1;
const DARK = 2;
