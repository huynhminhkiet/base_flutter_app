import 'package:meta/meta.dart';

@immutable
abstract class PageEvent{}

class ErrorOccurEvent extends PageEvent {
  final Exception exception;

  ErrorOccurEvent({this.exception});
}

class ActionSuccessEvent extends PageEvent {
  final String title;
  final String message;

  ActionSuccessEvent({this.title, this.message});
}