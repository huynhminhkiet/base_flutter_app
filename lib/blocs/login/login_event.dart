import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class LoginClickEvent extends LoginEvent {
  final String username;
  final String password;

  LoginClickEvent(this.username, this.password);
}
