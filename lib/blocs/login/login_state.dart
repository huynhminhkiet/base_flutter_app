import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailState extends LoginState {}
