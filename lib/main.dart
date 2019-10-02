import 'package:base_flutter_app/blocs/marker/bloc.dart';
import 'package:base_flutter_app/blocs/my_location/bloc.dart';
import 'package:base_flutter_app/blocs/timer/bloc.dart';
import 'package:base_flutter_app/core/localization/bloc.dart';
import 'package:base_flutter_app/core/theme/bloc.dart';
import 'package:base_flutter_app/di/app_injection.dart';
import 'package:base_flutter_app/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/authorization/authorization_bloc.dart';
import 'core/authorization/authorization_event.dart';
import 'core/localization/localization.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final AppInjection appInjection = AppInjection();
  appInjection.map();

  final MyLocationBloc myLocationBloc = new MyLocationBloc();
  final MarkerBloc markerBloc = new MarkerBloc(myLocationBloc);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthorizationBloc>(builder: (context) {
        return AuthorizationBloc()..dispatch(AppStarted());
      }),
      BlocProvider<LocalizationBloc>(builder: (context) {
        return LocalizationBloc()..dispatch(LocaleChangeEvent());
      }),
      BlocProvider<ThemeBloc>(builder: (context) {
        return ThemeBloc()..dispatch(ThemeChangedEvent());
      }),
      BlocProvider<MyLocationBloc>(builder: (context) {
        return myLocationBloc..dispatch(AppStatedEvent());
      }),
      BlocProvider<TimerBloc>(builder: (context) {
        return TimerBloc(myLocationBloc, markerBloc);
      }),
      BlocProvider<MarkerBloc>(builder: (context) {
        return markerBloc;
      })
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localizationState) {
      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: themeState.theme,
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [Locale("en"), Locale("vi")],
            locale: localizationState.locale,
            home: SplashScreen());
      });
    });
  }
}

// hotfix 3

// feature 3

// hot fix 4