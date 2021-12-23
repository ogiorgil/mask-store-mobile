class ProductMaskerCart {
  String model;
  int pk;
  Fields? fields;

  ProductMaskerCart({
    required this.model,
    required this.pk,
    required this.fields
  });

  factory ProductMaskerCart.fromJson(Map<String, dynamic> json) {
    return ProductMaskerCart(
      model : json['model'],
      pk : json['pk'],
      fields : json['fields'] != null ? new Fields.fromJson(json['fields']) : null,
    );
  }

  dynamic toJson() => {
    'model' : model,
    'pk' : pk,
    'fields' : fields != null ? fields!.toJson() : null,
  };
}

class Fields {
  String nama;
  int rating;
  String deskripsi;
  int harga;
  int stok;
  String image;

  Fields({
    required this.nama,
    required this.rating,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.image
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      nama : json['nama'],
      rating : json['rating'],
      deskripsi : json['deskripsi'],
      harga : json['harga'],
      stok : json['stok'],
      image : json['image'],
    );
  }

  dynamic toJson() => {
    'nama' : nama,
    'rating' : rating,
    'deskripsi' : deskripsi,
    'harga' : harga,
    'stok' : stok,
    'image' : image,
  };
}