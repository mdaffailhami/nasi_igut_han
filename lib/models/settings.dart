import 'dart:convert';

class Settings {
  String logo;
  String title;
  String quote;
  String aboutUs;
  String banner;
  String background;

  Settings({
    required this.logo,
    required this.title,
    required this.quote,
    required this.aboutUs,
    required this.banner,
    required this.background,
  });

  factory Settings.fromMap(Map value) {
    return Settings(
      logo: value['logo'],
      title: value['title'],
      quote: value['quote'],
      aboutUs: value['aboutUs'],
      banner: value['banner'],
      background: value['background'],
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
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
