import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/qna.dart';

class QNASNotifier extends StateNotifier<List<QNA>> {
  QNASNotifier() : super([]);

  Future<void> load() async {
    final res = await http.get(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/qnas',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final docs = jsonDecode(res.body)['docs'];

    final qnas = (docs as List).map((doc) {
      return QNA.fromMap(doc);
    }).toList();

    state = qnas;

    // final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
    //   'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/find',
    // ));

    // req.headers.add('content-Type', 'application/ejson');
    // req.headers.add('Accept', 'application/json');
    // req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    // req.write(jsonEncode({
    //   'dataSource': 'Cluster',
    //   'database': 'nasiIgutHanDB',
    //   'collection': 'qnas',
    // }));

    // final res = await req.close();
    // final data = await res.transform(utf8.decoder).join();

    // final qnas = (jsonDecode(data)['documents'] as List).map((doc) {
    //   return QNA.fromMap(doc);
    // }).toList();

    // state = qnas;
  }

  Future<bool> insertOne(QNA qna) async {
    final res = await http.post(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/qnas',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(qna.toMap()),
    );

    final resBody = jsonDecode(res.body);

    // Jika data gagal ditambahkan
    if (!resBody['status']) return false;

    final newState = [...state];

    qna.id = resBody['insertedID'];
    newState.add(qna);

    state = newState;
    return true;

    // final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
    //   'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/insertOne',
    // ));

    // req.headers.add('content-Type', 'application/ejson');
    // req.headers.add('Accept', 'application/json');
    // req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    // req.write(jsonEncode({
    //   'dataSource': 'Cluster',
    //   'database': 'nasiIgutHanDB',
    //   'collection': 'qnas',
    //   'document': qna.toMap(),
    // }));

    // final res = await req.close();
    // final data = await res.transform(utf8.decoder).join();

    // // Jika data berhasil ditambahkan
    // if (jsonDecode(data)['error'] == null) {
    //   final newState = [...state];
    //   newState.add(qna);

    //   state = newState;
    //   return true;
    // }

    // return false;
  }

  Future<bool> deleteOne(QNA qna) async {
    final res = await http.delete(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/qnas?id=${qna.id}',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final bool status = jsonDecode(res.body)['status'];

    // Jika data gagal dihapus
    if (!status) return false;

    final newState = [...state];
    newState.remove(qna);

    state = newState;
    return true;

    // final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
    //   'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/deleteOne',
    // ));

    // req.headers.add('content-Type', 'application/ejson');
    // req.headers.add('Accept', 'application/json');
    // req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    // req.write(jsonEncode({
    //   'dataSource': 'Cluster',
    //   'database': 'nasiIgutHanDB',
    //   'collection': 'qnas',
    //   'filter': qna.toMap(),
    // }));

    // final res = await req.close();
    // final data = await res.transform(utf8.decoder).join();

    // // Jika data berhasil dihapus
    // if (jsonDecode(data)['error'] == null) {
    //   final newState = [...state];
    //   newState.remove(qna);

    //   state = newState;
    //   return true;
    // }

    // return false;
  }

  Future<bool> replaceOne(QNA qna, QNA newQNA) async {
    final res = await http.put(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/qnas?id=${qna.id}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newQNA.toMap()),
    );

    final bool status = jsonDecode(res.body)['status'];

    // Jika data gagal direplace
    if (!status) return false;

    final newState = [...state];

    final index = newState.indexWhere((element) => element == qna);
    newState[index] = newQNA;

    state = newState;
    return true;

    // final HttpClientRequest req = await HttpClient().postUrl(Uri.parse(
    //   'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-vpphc/endpoint/data/v1/action/replaceOne',
    // ));

    // req.headers.add('content-Type', 'application/ejson');
    // req.headers.add('Accept', 'application/json');
    // req.headers.add('apiKey', const String.fromEnvironment('api_key'));

    // req.write(jsonEncode({
    //   'dataSource': 'Cluster',
    //   'database': 'nasiIgutHanDB',
    //   'collection': 'qnas',
    //   'filter': qna.toMap(),
    //   'replacement': newQNA.toMap(),
    // }));

    // final res = await req.close();
    // final data = await res.transform(utf8.decoder).join();

    // // Jika data berhasil direplace
    // if (jsonDecode(data)['error'] == null) {
    //   final newState = [...state];

    //   final index = newState.indexWhere((element) => element == qna);
    //   newState[index] = newQNA;

    //   state = newState;
    //   return true;
    // }

    // return false;
  }
}

final qnasProvider = StateNotifierProvider((ref) => QNASNotifier());
