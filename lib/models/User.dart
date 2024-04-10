import 'Company.dart';
import 'Student.dart';

class User {
  late int id;
  late String fullname;
  late List<int> roles;

  Company? company;

  Student? student;

  User(this.id, this.fullname, this.roles, this.company, this.student);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['fullname'] as String,
      (json['roles'] as List<dynamic>?)?.map((role) => role as int).toList() ??
          [],
      json['company'] != null ? Company.fromJson(json['company']) : null,
      json['student'] != null ? Student.fromJson(json['student']) : null,
    );
  }
}
