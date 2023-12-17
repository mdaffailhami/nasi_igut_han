import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class QNA {
  String? id;
  String question;
  String answer;

  QNA({this.id, required this.question, required this.answer});

  factory QNA.fromMap(Map map) {
    return QNA(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
    );
  }

  factory QNA.fromJson(String json) {
    return QNA.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Future<List<QNA>> find() async {
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

    return qnas;
  }

  static Future<void> insertOne(QNA qna) async {
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

    debugPrint(data);
  }
}
