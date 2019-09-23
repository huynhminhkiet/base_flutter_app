import 'package:meta/meta.dart';

@immutable
abstract class PageState  {}

class InitialPageState extends PageState {}

class ErrorState extends PageState {
  final String title;
  final String message;

  ErrorState({this.title, this.message});
}


class SuccessState extends PageState {
  final String title;
  final String message;

  SuccessState({this.title, this.message});
}

