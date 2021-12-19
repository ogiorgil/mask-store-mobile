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
    int mapRating = (5 * json["rating"] / 100).ceil();

    return Masker(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        rating: mapRating,
        imageUrl: img,
        stok: json["stok"],
        deksripsi: json["deskripsi"]);
  }
}
