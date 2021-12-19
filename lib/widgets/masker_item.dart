import 'package:flutter/material.dart';

import '../screens/masker_detail_screen.dart';

class MaskerItem extends StatelessWidget {
  final int id;
  final String nama;
  final double harga;
  final int rating;
  final String deksripsi;
  final String imageUrl;
  final int stok;

  const MaskerItem(this.id, this.nama, this.harga, this.rating, this.deksripsi,
      this.imageUrl, this.stok,
      {Key? key})
      : super(key: key);

  void selectMasker(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MaskerDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => selectMasker(context), child: createTile());
  }

  Container createTile() {
    return Container(
        constraints: const BoxConstraints(maxHeight: 210, maxWidth: 180),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: [
            createImage(imageUrl),
            createTitleReview(nama, rating),
            Expanded(child: createPrice(harga))
          ],
        ));
  }

  static Container createTitleReview(String title, int rating) {
    return Container(
        constraints: const BoxConstraints(maxHeight: 75, maxWidth: 180),
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                constraints: const BoxConstraints(maxHeight: 46),
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Row(
              children: [
                for (var i = 0; i < rating; i++)
                  const Icon(Icons.star, size: 16, color: Colors.deepOrange),
              ],
            ),
          ],
        ));
  }

  static Container createPrice(double price) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 27, maxWidth: 180),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Text('\$ $price',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  static Container createImage(String imageUrl) {
    return Container(
        constraints: const BoxConstraints(maxHeight: 105, maxWidth: 180),
        alignment: Alignment.center,
        child: Image.network(imageUrl, width: 180, fit: BoxFit.scaleDown));
  }
}
