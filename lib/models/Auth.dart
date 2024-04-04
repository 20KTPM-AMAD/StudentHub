import 'package:studenthub/models/User.dart';

class Auth {
  User loginUser;
  String token;

  Auth(this.loginUser, this.token);

  User getLoginUser() {
    return this.loginUser;
  }

  String getToken() {
    return this.token;
  }
}