class ItemMaskerCart {
  String model;
  int pk;
  Fields? fields;

  ItemMaskerCart({
    required this.model,
    required this.pk,
    required this.fields
  });

  factory ItemMaskerCart.fromJson(Map<String, dynamic> json) {
    return ItemMaskerCart(
      model : json['model'],
      pk : json['pk'],
      fields : json['fields'] != null ? new Fields.fromJson(json['fields']) : null,
    );
  }
}

class Fields {
  int product;
  int order;
  int quantity;
  String dateAdded;

  Fields({required this.product, required this.order, required this.quantity, required this.dateAdded});

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      product : json['product'],
      order : json['order'],
      quantity : json['quantity'],
      dateAdded : json['date_added'],
    );
  }
}

