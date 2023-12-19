import 'dart:convert';

class QNA {
  String? id;
  String question;
  String answer;

  QNA({this.id, required this.question, required this.answer});

  factory QNA.fromMap(Map map) {
    return QNA(
      id: map['_id']['\$oid'],
      question: map['question'],
      answer: map['answer'],
    );
  }

  factory QNA.fromJson(String json) {
    return QNA.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': id},
      'question': question,
      'answer': answer,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
