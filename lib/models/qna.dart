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
}
