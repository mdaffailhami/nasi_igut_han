import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/models/product.dart';

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  Future<void> load() async {
    final res = await http.get(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/products',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final docs = jsonDecode(res.body)['docs'];

    final products = (docs as List).map((doc) {
      return Product.fromMap(doc);
    }).toList();

    state = products;
  }

  Future<bool> insertOne(Product product) async {
    final res = await http.post(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/products',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toMap()),
    );

    final resBody = jsonDecode(res.body);

    // Jika data gagal ditambahkan
    if (!resBody['status']) return false;

    final newState = [...state];

    product.id = resBody['insertedID'];
    newState.add(product);

    state = newState;
    return true;
  }

  Future<bool> deleteOne(Product product) async {
    final res = await http.delete(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/products?id=${product.id}',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    final bool status = jsonDecode(res.body)['status'];

    // Jika data gagal dihapus
    if (!status) return false;

    final newState = [...state];
    newState.remove(product);

    state = newState;
    return true;
  }

  Future<bool> replaceOne(Product product, Product newQNA) async {
    final res = await http.put(
      Uri.parse(
        '${const String.fromEnvironment('API_URL')}/products?id=${product.id}',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newQNA.toMap()),
    );

    final bool status = jsonDecode(res.body)['status'];

    // Jika data gagal direplace
    if (!status) return false;

    final newState = [...state];

    final index = newState.indexWhere((element) => element == product);
    newState[index] = newQNA;

    state = newState;
    return true;
  }
}

final productsProvider = StateNotifierProvider((ref) => ProductsNotifier());
