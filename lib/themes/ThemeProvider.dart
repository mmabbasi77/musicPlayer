import 'package:flutter/material.dart';
import 'package:music_player_app/themes/DarkMode.dart';
import 'package:music_player_app/themes/LightMode.dart';

class ThemeProvider extends ChangeNotifier {
  // initailly : Light Mode!
  ThemeData _themeData = lightMode;

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update ui!
    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
