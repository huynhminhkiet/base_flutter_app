import 'package:meta/meta.dart';

@immutable
abstract class AuthorizationState {}

class InitialAuthorizationState extends AuthorizationState {}

class AuthorizationUnauthenticatedState extends AuthorizationState {}

class AuthorizationAuthenticatedState extends AuthorizationState {}

