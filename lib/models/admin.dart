import 'dart:convert';

class Admin {
  String email;
  String password;

  Admin({required this.email, required this.password});

  factory Admin.fromMap(Map map) {
    return Admin(
      email: map['email'],
      password: map['password'],
    );
  }

  factory Admin.fromJson(String json) {
    return Admin.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
