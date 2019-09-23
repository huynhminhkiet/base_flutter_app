import 'dart:async';

import 'package:base_flutter_app/data/prefs/app_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import './bloc.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AppPreferences _appPreferences = Injector.getInjector().get<AppPreferences>();

  @override
  AuthorizationState get initialState => InitialAuthorizationState();

  @override
  Stream<AuthorizationState> mapEventToState(
    AuthorizationEvent event,
  ) async* {

    if (event is AppStarted) {
      var token = await _appPreferences.getToken();

      if (token == null || token.isEmpty) {
        yield new AuthorizationUnauthenticatedState();
      } else {
        yield new AuthorizationAuthenticatedState();
      }
    }
  }
}
