class Socmed {
  String icon;
  String link;

  Socmed({required this.icon, required this.link});

  factory Socmed.fromMap(Map value) {
    return Socmed(
      icon: value['icon'],
      link: value['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'link': link,
    };
  }
}
