import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/models/shopping_cart/ProductMaskerCart.dart';

Future<List<ProductMaskerCart>?> fetchProductCart() async {
  final response = await http.get(Uri.parse('https://pbp-c07.herokuapp.com/product_json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseProduct(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Product');
  }
}

List<ProductMaskerCart>? parseProduct(String responseBody) {
  final List<ProductMaskerCart> products = [];
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  for (var e in parsed) {
    products.add(ProductMaskerCart.fromJson(e));
  }

  return products;
}