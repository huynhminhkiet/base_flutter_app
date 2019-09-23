import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:sprintf/sprintf.dart';

class AppLocalizations {

  AppLocalizations(this.locale);

  final Locale locale;

  String get settingTitle => _localizedValues[locale.languageCode]['settingTitle'];
  String get login => _localizedValues[locale.languageCode]['login'];
  String get languageLabel => _localizedValues[locale.languageCode]['languageLabel'];
  String get themeLabel => _localizedValues[locale.languageCode]['themeLabel'];
  String get light => _localizedValues[locale.languageCode]['light'];
  String get dark => _localizedValues[locale.languageCode]['dark'];
  String get home => _localizedValues[locale.languageCode]['home'];
  String hello(String name) => sprintf(_localizedValues[locale.languageCode]['helloParams'], [name]);


  static Map<String, Map<String, String>> _localizedValues = {

    'en': {
      'home': 'Home',
      'light': 'Light',
      'dark': 'Dark',
      'themeLabel': 'Theme',
      'login': 'Login',
      'helloParams': 'Hello %s',
      'settingTitle': 'Setting',
      'languageLabel': 'Language',
    },

    'vi': {
      'home': "Trang chủ",
      'dark': "Tối",
      'light': "Sáng",
      'themeLabel': "Giao diện",
      'login': "Đăng nhập",
      'helloParams': 'Xin chào %s',
      'settingTitle': 'Cài đặt',
      'languageLabel': 'Ngôn ngữ',
    },

  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}