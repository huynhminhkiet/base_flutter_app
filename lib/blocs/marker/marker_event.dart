import 'package:meta/meta.dart';

@immutable
abstract class MarkerEvent {}
class FromTimerEvent extends MarkerEvent {}
