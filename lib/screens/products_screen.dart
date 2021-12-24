import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import '../widgets/masker_item.dart';
import '../models/masker.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

bool isFetched = false;
List<Masker> maskers = List.empty();

class _ProductsScreenState extends State<ProductsScreen> {
  List<Masker>? parseMasker(String responseBody) {
    if (isFetched) return maskers;
    final parsed = jsonDecode(responseBody) as List<dynamic>;
    for (var e in parsed) {
      maskers.add(Masker.fromJson(e));
    }
    isFetched = true;
    return maskers;
  }

  Future<List<Masker>?> fetchMasker() async {
    // test apakah gambar sudah di-fetch
    // mencegah request server saat screen di-build ulang karane perubahan contentFitur
    if (isFetched && maskers.isNotEmpty) {
      return maskers;
    }
    const url = 'https://pbp-c07.herokuapp.com/api/mobile/get-data/30';
    try {
      final response = await http.get(Uri.parse(url));
      maskers = List.empty(growable: true);
      return parseMasker(response.body);
    } catch (error) {
      print(error);
    }
    return maskers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMasker(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return _myList(snapshot.data as List<Masker>);
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _myList(List<Masker> masks) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 0.50,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var mask = masks.elementAt(index);
                return Padding(
                  child: MaskerItem(
                    mask.id,
                    mask.nama,
                    mask.harga,
                    mask.rating,
                    mask.deksripsi,
                    mask.imageUrl,
                    mask.stok,
                  ),
                  padding: const EdgeInsets.all(15),
                );
              },
              childCount: maskers.length,
            )),
        const SliverPadding(
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}