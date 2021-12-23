import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/models/shopping_cart/CustomMaskerCart.dart';

Future<List<CustomMaskerCart>?> fetchCustomMaskerCart() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/custom_json/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseCustom(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Product');
  }
}

List<CustomMaskerCart>? parseCustom(String responseBody) {
  final List<CustomMaskerCart> customs = [];
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  for (var e in parsed) {
    customs.add(CustomMaskerCart.fromJson(e));
  }

  return customs;
}