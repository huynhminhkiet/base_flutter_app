import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChangedEvent extends ThemeEvent {
  final int themeType;

  ThemeChangedEvent({this.themeType});
}
