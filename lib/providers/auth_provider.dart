import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _validUsername = 'admin';
  static const String _validPassword = 'admin123';
  
  bool _isLoggedIn = false;
  SharedPreferences? _prefs;
  
  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    try {
      
      _prefs = await _getPrefsWithRetry();
      
      if (_prefs != null) {
        _isLoggedIn = _prefs!.getBool(_keyIsLoggedIn) ?? false;
      } else {
        debugPrint('AuthProvider: SharedPreferences not available, defaulting to logged out');
        _isLoggedIn = false;
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('AuthProvider: Error checking login status: $e');
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  Future<SharedPreferences?> _getPrefsWithRetry() async {
    for (int i = 0; i < 3; i++) {
      try {
        final prefs = await SharedPreferences.getInstance();
        return prefs;
      } catch (e) {
        debugPrint('AuthProvider: Attempt ${i + 1} to get SharedPreferences failed: $e');
        if (i < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
    return null;
  }

  Future<bool> login(String username, String password) async {
    
    if (username == _validUsername && password == _validPassword) {
      _isLoggedIn = true;
      
      try {
        _prefs ??= await _getPrefsWithRetry();
        if (_prefs != null) {
          await _prefs!.setBool(_keyIsLoggedIn, true);
        }
      } catch (e) {
        debugPrint('AuthProvider: Failed to save login state: $e');
      }
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    
    try {
      if (_prefs != null) {
        await _prefs!.setBool(_keyIsLoggedIn, false);
      }
    } catch (e) {
      debugPrint('AuthProvider: Failed to save logout state: $e');
    }
    
    notifyListeners();
  }
}