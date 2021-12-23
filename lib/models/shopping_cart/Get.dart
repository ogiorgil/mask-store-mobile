class Get {
  final int getPriceTotal;
  final int getItemsTotal;

  Get({
    required this.getPriceTotal,
    required this.getItemsTotal,
  });

  factory Get.fromJson(Map<String, dynamic> json) {
    return Get(
      getPriceTotal : json['get_price_total'],
      getItemsTotal : json['get_items_total'],
    );
  }
}