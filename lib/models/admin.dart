import 'dart:convert';

class Admin {
  String? id;
  String email;
  String password;

  Admin({this.id, required this.email, required this.password});

  factory Admin.fromMap(Map map) {
    return Admin(
      id: map['_id']['\$oid'],
      email: map['email'],
      password: map['password'],
    );
  }

  factory Admin.fromJson(String json) {
    return Admin.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': id},
      'email': email,
      'password': password,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
