import 'package:meta/meta.dart';

@immutable
abstract class AuthorizationEvent {}

class AppStarted extends AuthorizationEvent {}
