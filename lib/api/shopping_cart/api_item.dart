import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/models/shopping_cart/ItemMaskerCart.dart';

Future<List<ItemMaskerCart>?> fetchItemMaskerCart() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/item_json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseItem(response.body);
  } else {
    // If the server did not return a 200 OK response,d
    // then throw an exception.
    throw Exception('Failed to load Get');
  }
}

List<ItemMaskerCart>? parseItem(String responseBody) {
  final List<ItemMaskerCart> items = [];
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  for (var e in parsed) {
    items.add(ItemMaskerCart.fromJson(e));
  }

  return items;
}