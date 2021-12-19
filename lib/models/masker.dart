import 'dart:math';

class Masker {
  final int id;
  final String nama;
  final double harga;
  final int rating;
  int stok;
  final String deksripsi;
  String imageUrl;

  Masker({
    required this.id,
    required this.nama,
    required this.harga,
    required this.rating,
    this.imageUrl = "",
    required this.stok,
    this.deksripsi = "",
  });

  factory Masker.fromJson(Map<String, dynamic> json) {
    var img = json["image"];
    img ??= "";
    int mapRating = (5 * json["rating"].toInt() / 100).ceil();

    return Masker(
        id: json["id"].toInt(),
        nama: json["nama"].toString(),
        harga: json["harga"].toDouble(),
        rating: mapRating,
        imageUrl: img,
        stok: json["stok"].toInt(),
        deksripsi: json["deskripsi"]);
  }
}
