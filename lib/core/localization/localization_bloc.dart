import 'dart:async';
import 'package:base_flutter_app/data/prefs/app_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import './bloc.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final AppPreferences prefs = Injector.getInjector().get<AppPreferences>();

  @override
  LocalizationState get initialState => LocalizationState();

  @override
  Stream<LocalizationState> mapEventToState(
    LocalizationEvent event,
  ) async* {

    if (event is LocaleChangeEvent) {
      if (event.locale == null) {
        var langCodeInPrefs = await prefs.getLocal();
        if (langCodeInPrefs == null) {
          var langCode = "en";
          await prefs.putLocale(langCode);
          yield new LocalizationState(locale: Locale(langCode));
        } else {
          yield new LocalizationState(locale: Locale(langCodeInPrefs));
        }
      } else {
        await prefs.putLocale(event.locale.languageCode);
        yield new LocalizationState(locale: event.locale);
      }
    }

  }
}
