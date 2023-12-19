import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/admin.dart';

class AdminNotifier extends StateNotifier<Admin?> {
  AdminNotifier() : super(null);

  Future<bool> signIn(Admin input) async {
    final Admin? target = await findByEmail(input.email);

    if (target == null) return false;

    final String hashedInputPassword =
        sha1.convert(utf8.encode(input.password)).toString();

    if (hashedInputPassword != target.password) return false;

    state = target;
    return true;
  }

  void signOut() => state = null;

  Future<Admin?> findByEmail(String email) async {
    final res = await http.get(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/admins?email=$email',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final resBody = jsonDecode(res.body);

    return resBody['status'] ? Admin.fromMap(resBody['doc']) : null;
  }

  Future<bool> insertOne(Admin admin) async {
    final Admin hashedDoc = Admin(
      email: admin.email,
      password: sha1.convert(utf8.encode(admin.password)).toString(),
    );

    final res = await http.post(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/admins',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(hashedDoc.toMap()),
    );

    return jsonDecode(res.body)['status'];
  }
}

final adminProvider = StateNotifierProvider((ref) => AdminNotifier());
