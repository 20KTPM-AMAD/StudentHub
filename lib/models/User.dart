import 'Company.dart';

class User {
  int id;
  String fullname;
  List<String> roles; // Sử dụng List thay vì Array

  Company? company;

  User(this.id, this.fullname, this.roles, this.company);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['fullname'],
      List<String>.from(json['roles']),
      json['company'] != null ? Company.fromJson(json['company']) : null,
    );
  }
}