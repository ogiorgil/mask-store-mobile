class OrderCart {
  int id;
  int user;
  bool complete;
  String note;

  OrderCart({required this.id, required this.user, required this.complete, required this.note});

  factory OrderCart.fromJson(Map<String, dynamic> json) {
    if (json.length == 0) {
      return OrderCart(id: 0, user: 0, complete: true, note: '');
    }

    if (json['note'] == null){
      json['note'] = "None";
    };

    return OrderCart(
      id : json['id'],
      user : json['user'],
      complete : json['complete'],
      note : json['note'],
    );
  }
}