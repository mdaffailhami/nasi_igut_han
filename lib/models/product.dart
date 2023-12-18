import 'package:nasi_igut_han/models/rupiah.dart';

class Product {
  String name;
  String description;
  Rupiah price;
  String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
