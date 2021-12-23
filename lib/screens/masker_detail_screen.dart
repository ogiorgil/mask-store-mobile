import 'package:flutter/material.dart';

import '../models/masker.dart';
import 'home_screen.dart';

class MaskerDetailScreen extends StatelessWidget {
  static const routeName = '/masker-detail';
  const MaskerDetailScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final maskerId = ModalRoute.of(context)!.settings.arguments as int;
    // print(maskerId);
    // print(snapshot.data);
    Masker selectedMasker =
        maskers.firstWhere((element) => element.id == maskerId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            selectedMasker.nama,
          ),
        ),
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 25),
                alignment: Alignment.topCenter,
                child: Image.network(
                  selectedMasker.imageUrl,
                  height: 250,
                  fit: BoxFit.fitWidth,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            for (var i = 0; i < selectedMasker.rating; i++)
                              const Icon(Icons.star,
                                  size: 32, color: Colors.deepOrange),
                          ],
                        ),
                        Text(
                          "\$${selectedMasker.harga}",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getStock(selectedMasker),
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deksripsi:\n${selectedMasker.deksripsi}",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  String getStock(Masker selectedMasker) {
    if (selectedMasker.stok == 0) {
      return "Masker tidak tersedia";
    } else {
      return selectedMasker.stok.toString() + " masker tersedia";
    }
  }
}
