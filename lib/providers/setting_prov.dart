import 'package:flutter/material.dart';

import '../data/setting_repo.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  String _language = 'en';

  ThemeMode get themeMode => _themeMode;

  String get language => _language;

  bool get isDark => _themeMode == ThemeMode.dark;



  SettingProvider() {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    _themeMode = await SettingPref.loadThemeMode();
    _language = await SettingPref.loadLanguage();
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    await SettingPref.saveThemeMode(_themeMode);
    await SettingPref.saveLanguage(_language);
  }

  void changeTheme(ThemeMode selectThemeMode) {
    if (_themeMode != selectThemeMode) {
      _themeMode = selectThemeMode;
      _savePreferences();
      notifyListeners();
    }
  }

  void changeLanguage(String lang) {
    if (_language != lang) {
      _language = lang;
      _savePreferences();
      notifyListeners();
    }
  }
}
