import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences>? _sharedPreference;
  static const String is_dark_mode = "is_dark_mode";
  static const String language_code = "language_code";
  static const String is_sidebar_open = "is_sidebar_open";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme module
  Future<void> changeTheme(bool value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setBool(is_dark_mode, value);
    });
  }

  Future<bool> get isDarkMode {
    return _sharedPreference!.then((prefs) {
      return prefs.getBool(is_dark_mode) ?? false;
    });
  }

  //Locale module
  Future<String>? get appLocale {
    return _sharedPreference?.then((prefs) {
      return prefs.getString(language_code) ?? 'en';
    });
  }

  Future<void> changeLanguage(String value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setString(language_code, value);
    });
  }

  // Sidebar module
  Future<void> changeSidebar(bool value) {
    return _sharedPreference!.then((prefs) {
      return prefs.setBool(is_sidebar_open, value);
    });
  }

  Future<bool> get isSidebarOpen {
    return _sharedPreference!.then((prefs) {
      return prefs.getBool(is_sidebar_open) ?? false;
    });
  }
}
