import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';

class QNASNotifier extends StateNotifier<List<QNA>> {
  QNASNotifier() : super([]);

  void set(List<QNA> qnas) {
    state = qnas;
  }

  Future<void> load() async {
    final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/find',
    ));

    req.headers.add('content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');
    req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'qnas',
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();

    final qnas = (jsonDecode(data)['documents'] as List).map((doc) {
      return QNA.fromMap(doc);
    }).toList();

    state = qnas;
  }

  Future<bool> insertOne(QNA qna) async {
    final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/insertOne',
    ));

    req.headers.add('content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');
    req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'qnas',
      'document': qna.toMap(),
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();

    // Jika data berhasil ditambahkan
    if (jsonDecode(data)['error'] == null) {
      final newState = [...state];
      newState.add(qna);

      state = newState;
      return true;
    }

    return false;
  }

  Future<bool> deleteOne(QNA qna) async {
    final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/deleteOne',
    ));

    req.headers.add('content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');
    req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'qnas',
      'filter': qna.toMap(),
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();

    // Jika data berhasil dihapus
    if (jsonDecode(data)['error'] == null) {
      final newState = [...state];
      newState.remove(qna);

      state = newState;
      return true;
    }

    return false;
  }

  Future<bool> replaceOne(QNA qna, QNA newQNA) async {
    final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/replaceOne',
    ));

    req.headers.add('content-Type', 'application/ejson');
    req.headers.add('Accept', 'application/json');
    req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    req.write(jsonEncode({
      'dataSource': 'Cluster',
      'database': 'nasiIgutHanDB',
      'collection': 'qnas',
      'filter': qna.toMap(),
      'replacement': newQNA.toMap(),
    }));

    final res = await req.close();
    final data = await res.transform(utf8.decoder).join();

    // Jika data berhasil direplace
    if (jsonDecode(data)['error'] == null) {
      final newState = [...state];

      final index = newState.indexWhere((element) => element == qna);
      newState[index] = newQNA;

      state = newState;
      return true;
    }

    return false;
  }
}

final qnasProvider = StateNotifierProvider((ref) => QNASNotifier());
