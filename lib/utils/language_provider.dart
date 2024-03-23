import 'package:flutter/material.dart';

enum AppLanguage { English, Vietnamese }

class LanguageProvider extends ChangeNotifier {
  AppLanguage _currentLanguage = AppLanguage.English;

  AppLanguage get currentLanguage => _currentLanguage;

  void changeLanguage(AppLanguage language) {
    _currentLanguage = language;
    notifyListeners();
  }
}
