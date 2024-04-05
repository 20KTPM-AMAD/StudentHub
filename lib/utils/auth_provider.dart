import 'package:flutter/foundation.dart';
import 'package:studenthub/models/Company.dart';
import 'package:studenthub/models/User.dart';

class AuthProvider with ChangeNotifier {
  User? _loginUser;
  String? _token;

  User? get loginUser => _loginUser;

  String? get token => _token;

  void setLoginUser(User user) {
    _loginUser = user;
    notifyListeners();
  }

  void setCompany(Company company) {
    _loginUser?.company = company;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }
}
