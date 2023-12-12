import 'package:nasi_igut_han/models/rupiah.dart';

class Product {
  String name;
  String description;
  String imageUrl;
  Rupiah price;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}
