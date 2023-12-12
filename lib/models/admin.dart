import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

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

  static Future<bool> validateSignIn(Admin input) async {
    final Admin? target = await Admin.findByEmail(input.email);

    if (target == null) return false;

    final String hashedInputPassword =
        sha1.convert(utf8.encode(input.password)).toString();

    return hashedInputPassword == target.password;
  }

  static Future<Admin?> findByEmail(String email) async {
    final req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/findOne',
    ));

    req.headers.add('apiKey', const String.fromEnvironment('api_key'));
    req.headers.add('Content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'admins',
      'filter': {'email': email},
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();
    final doc = jsonDecode(data)['document'];

    return doc == null ? null : Admin.fromMap(doc);
  }

  static Future<void> insertOne(Admin admin) async {
    final Admin hashedDoc = Admin(
      email: admin.email,
      password: sha1.convert(utf8.encode(admin.password)).toString(),
    );

    final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/insertOne',
    ));

    req.headers.add('content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');
    req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'admins',
      'document': hashedDoc.toMap(),
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();

    debugPrint(data);
  }
}
