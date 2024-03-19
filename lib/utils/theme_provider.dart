import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier {
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  late ThemeData _currentTheme;

  bool _isDarkMode = false;

  ThemeProvider() {
    _lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF12B28C)),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF12B28C)),
      buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF12B28C)),
    );

    _darkTheme = ThemeData.dark();
    _currentTheme = _lightTheme;
  }

  ThemeData getTheme() => _currentTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
