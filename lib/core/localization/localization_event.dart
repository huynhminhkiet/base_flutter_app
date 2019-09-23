import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocalizationEvent {}

class LocaleChangeEvent extends LocalizationEvent {
  final Locale locale;
  LocaleChangeEvent({this.locale});
}
