import 'dart:convert';
import 'dart:io';

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

  Future<Admin?> findByEmail(String email) async {
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

  Future<bool> insertOne(Admin admin) async {
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

    // Jika data berhasil ditambahkan
    return jsonDecode(data)['error'] == null ? true : false;
  }
}

final adminProvider = StateNotifierProvider((ref) => AdminNotifier());
