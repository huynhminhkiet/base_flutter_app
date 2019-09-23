import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class LocalizationState {
  final Locale locale;
  LocalizationState({this.locale});
}
