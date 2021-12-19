import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import '../widgets/masker_item.dart';
import '../models/masker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool isFetched = false;
List<Masker> maskers = List.empty();

class _HomeScreenState extends State<HomeScreen> {
  bool pertamax = true;
  int counter = 0;
  double _opacity1 = 0;
  final int _duration = 6;

  final headingFitur = ['Terpercaya', 'Higienis', 'Fashionable'];
  final contentFitur = [
    'Masker kami memiliki tingkat filtrasi hingga 70%',
    'Kesterilan produk masker dijaga hingga ke tangan pembeli',
    'Tidak hanya faktor kesehatan, kami selalu berusaha untuk menjaga faktor estetika produk masker kami',
  ];

  List<Masker>? parseMasker(String responseBody) {
    if (isFetched) return null;
    final parsed = jsonDecode(responseBody) as List<dynamic>;
    for (var e in parsed) {
      maskers.add(Masker.fromJson(e));
    }
    return maskers;
  }

  Future<List<Masker>?> fetchMasker() async {
    // test apakah gambar sudah di-fetch
    // mencegah request server saat screen di-build ulang karane perubahan contentFitur
    if (isFetched) {
      return maskers;
    }
    const url = 'https://pbp-c07.herokuapp.com/api/mobile/get-data/15';
    try {
      final response = await http.get(Uri.parse(url));
      maskers = List.empty(growable: true);
      return parseMasker(response.body);
    } catch (error) {
      print(error);
    } finally {
      isFetched = true;
    }
    return maskers;
  }

  @override
  void initState() {
    if (pertamax) {
      setState(() {
        _opacity1 = 1;
        pertamax = false;
      });
    }
    fade();
    super.initState();
  }

  void fade() {
    Timer.periodic(Duration(milliseconds: _duration * 1000), (timer) {
      Timer(const Duration(milliseconds: 495), () {
        setState(() {
          counter = (counter + 1) % 3;
          _opacity1 = 1;
        });
      });
      setState(() {
        _opacity1 = 0;
      });
    });
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
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SizedBox(
                child: Padding(
                    child: fiturMasker(), padding: const EdgeInsets.all(20)));
          },
          childCount: 1,
        )),
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

  Container fiturMasker() {
    return Container(
        padding: const EdgeInsets.all(30),
        height: 200,
        width: 280,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              child: Text(
                headingFitur[counter],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              opacity: _opacity1,
            ),
            AnimatedOpacity(
              child: Text(
                contentFitur[counter],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              opacity: _opacity1,
            ),
          ],
        ));
  }
}
