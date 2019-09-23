import 'dart:async';
import 'package:base_flutter_app/core/page/page_bloc.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  PageBloc _pageBloc;

  set pageBloc(PageBloc value) {
    if (_pageBloc != null) return;
    _pageBloc = value;
  }

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {

    if (event is LoginClickEvent) {
      yield new LoginLoadingState();
      await Future.delayed(Duration(seconds: 2));
      yield new LoginSuccessState();
    }

  }
}
