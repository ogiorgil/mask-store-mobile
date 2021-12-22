class WishlistItem {
  int userId;
  String name;
  double price;
  int count;

  WishlistItem({
    required this.userId,
    required this.name,
    required this.price,
    required this.count,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> fields) {
    return WishlistItem(
      userId: fields["owner"],
      name: fields["name"],
      price: double.parse(fields["price"]),
      count: fields["count"],
    );
  }
}
