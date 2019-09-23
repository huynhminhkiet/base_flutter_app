import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => InitialPageState();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {

    if (event is ActionSuccessEvent) yield new SuccessState(title: event.title, message: event.message);

    if (event is ErrorOccurEvent) {
      yield* _handleError(event);
    }

  }

  Stream<PageState> _handleError(ErrorOccurEvent event) async* {
    if (event.exception is DioError) {
      try {
        DioError dioError = event.exception;
        yield new ErrorState(title: "Error", message: dioError.response.toString());
      } catch (e) {
        yield new ErrorState(title: "Error", message: "Something went wrong!");
      }
    } else {
      yield new ErrorState(title: "Error", message: "Something went wrong!");
    }
  }
}
