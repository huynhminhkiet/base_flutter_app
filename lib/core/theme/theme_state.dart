import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState {
  final ThemeData theme;
  final int themeType;

  ThemeState({this.theme, this.themeType});
}
