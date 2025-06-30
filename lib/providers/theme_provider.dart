import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _keyThemeMode = 'themeMode';
  
  ThemeMode _themeMode = ThemeMode.system;
  SharedPreferences? _prefs;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadThemePreference() async {
    try {
      
      _prefs = await _getPrefsWithRetry();
      
      if (_prefs != null) {
        final themeModeString = _prefs!.getString(_keyThemeMode) ?? 'system';
        
        switch (themeModeString) {
          case 'light':
            _themeMode = ThemeMode.light;
            break;
          case 'dark':
            _themeMode = ThemeMode.dark;
            break;
          default:
            _themeMode = ThemeMode.system;
        }
      } else {
        _themeMode = ThemeMode.system;
      }
      
      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
      notifyListeners();
    }
  }

  Future<SharedPreferences?> _getPrefsWithRetry() async {
    for (int i = 0; i < 3; i++) {
      try {
        final prefs = await SharedPreferences.getInstance();
        return prefs;
      } catch (e) {
        if (i < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
    return null;
  }

  Future<void> toggleTheme() async {
    
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    
    try {
      _prefs ??= await _getPrefsWithRetry();
      if (_prefs != null) {
        await _prefs!.setString(_keyThemeMode, _themeMode.name);
      }
    } catch (e) {
      debugPrint('ThemeProvider: Failed to save theme preference: $e');
    }
    
    notifyListeners();
  }
}