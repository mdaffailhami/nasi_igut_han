import 'dart:convert';

import 'package:nasi_igut_han/models/socmed.dart';

class Settings {
  String logo;
  String title;
  String quote;
  String aboutUs;
  String banner;
  String background;
  Socmed socmed1;
  Socmed socmed2;
  Socmed socmed3;

  Settings({
    required this.logo,
    required this.title,
    required this.quote,
    required this.aboutUs,
    required this.banner,
    required this.background,
    required this.socmed1,
    required this.socmed2,
    required this.socmed3,
  });

  factory Settings.fromMap(Map value) {
    return Settings(
      logo: value['logo'],
      title: value['title'],
      quote: value['quote'],
      aboutUs: value['aboutUs'],
      banner: value['banner'],
      background: value['background'],
      socmed1: Socmed.fromMap(value['socmed1']),
      socmed2: Socmed.fromMap(value['socmed2']),
      socmed3: Socmed.fromMap(value['socmed3']),
    );
  }

  factory Settings.fromJson(String json) {
    return Settings.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'logo': logo,
      'title': title,
      'quote': quote,
      'aboutUs': aboutUs,
      'banner': banner,
      'background': background,
      'socmed1': socmed1.toMap(),
      'socmed2': socmed2.toMap(),
      'socmed3': socmed3.toMap(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
