import 'dart:convert';

import 'package:nasi_igut_han/models/rupiah.dart';

class Product {
  String? id;
  String name;
  String description;
  Rupiah price;
  String image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromMap(Map map) {
    return Product(
      id: map['_id']['\$oid'],
      name: map['name'],
      description: map['description'],
      price: Rupiah(map['price']),
      image: map['image'],
    );
  }

  factory Product.fromJson(String json) {
    return Product.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': {'\$oid': id},
      'name': name,
      'description': description,
      'price': price.nilai,
      'image': image,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
