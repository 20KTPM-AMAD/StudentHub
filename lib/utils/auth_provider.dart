import 'package:flutter/foundation.dart';
import 'package:studenthub/contanst/contanst.dart';
import 'package:studenthub/models/Company.dart';
import 'package:studenthub/models/Student.dart';
import 'package:studenthub/models/User.dart';

class AuthProvider with ChangeNotifier {
  User? _loginUser;
  String? _token;
  UserRole _role = UserRole.Student;

  User? get loginUser => _loginUser;

  String? get token => _token;

  UserRole? get role => _role;

  void setLoginUser(User user) {
    _loginUser = user;
    notifyListeners();
  }

  void setCompany(Company company) {
    _loginUser?.company = company;
    notifyListeners();
  }

  void setStudent(Student student) {
    _loginUser?.student = student;
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

  void setRole(UserRole role) {
    _role = role;
    notifyListeners();
  }
}
