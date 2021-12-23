class CustomMaskerCart {
  String model;
  int pk;
  Fields? fields;

  CustomMaskerCart({required this.model, required this.pk, required this.fields});

  factory CustomMaskerCart.fromJson(Map<String, dynamic> json) {
    return CustomMaskerCart(
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
  String sex;
  String size;
  String model;
  String color;
  String style;
  int price;
  int quantity;
  int order;

  Fields({
    required this.sex,
    required this.size,
    required this.model,
    required this.color,
    required this.style,
    required this.price,
    required this.quantity,
    required this.order
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      sex : json['sex'],
      size : json['size'],
      model : json['model'],
      color : json['color'],
      style : json['style'],
      price : json['price'],
      quantity : json['quantity'],
      order : json['order'],
    );
  }

  dynamic toJson() => {
    'sex' : sex,
    'size' : size,
    'model' : model,
    'color' : color,
    'style' : style,
    'price' : price,
    'quantity' : quantity,
    'order' : order,
  };
}