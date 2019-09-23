import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_TOKEN = "PREFS_TOKEN";
const String PREFS_LOCALE = "PREFS_LOCALE";
const String PREFS_THEME_TYPE = "PREFS_THEME_TYPE";

class AppPreferences {

  SharedPreferences prefs;

  Future _init() async {
    if (prefs == null)
      prefs = await SharedPreferences.getInstance();
  }

  Future putLocale(String langCode) async {
    await _init();
    return prefs.setString(PREFS_LOCALE, langCode);
  }

  Future<String> getLocal() async {
    await _init();
    return prefs.getString(PREFS_LOCALE);
  }

  Future putThemeType(int themeType) async {
    await _init();
    return prefs.setInt(PREFS_THEME_TYPE, themeType);
  }

  Future<int> getThemeType() async {
    await _init();
    return prefs.getInt(PREFS_THEME_TYPE);
  }

  Future putToken(String token) async {
    await _init();
    return prefs.setString(PREFS_TOKEN, token);
  }

  Future<String> getToken() async {
    await _init();
    return prefs.getString(PREFS_TOKEN);
  }

}