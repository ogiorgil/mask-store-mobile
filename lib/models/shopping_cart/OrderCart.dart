// class OrderCart {
//   String model;
//   int pk;
//   Fields? fields;
//
//   OrderCart({required this.model, required this.pk, required this.fields});
//
//   factory OrderCart.fromJson(Map<String, dynamic> json) {
//     return OrderCart(
//         model : json['model'],
//         pk : json['pk'],
//         fields : json['fields'] != null ? new Fields.fromJson(json['fields']) : null,
//     );
//   }
//
//   dynamic toJson() => {
//     'model' : model,
//     'pk' : pk,
//     'fields' : fields != null ? fields!.toJson() : null,
//   };
//
// }
//
// class Fields {
//   int user;
//   bool complete;
//   String note;
//
//   Fields({required this.user, required this.complete, required this.note});
//
//   factory Fields.fromJson(Map<String, dynamic> json) {
//     return Fields(
//         user : json['user'],
//         complete : json['complete'],
//         note : json['note'],
//     );
//   }
//
//   dynamic toJson() => {
//     'user' : user,
//     'complete' : complete,
//     'note' : note,
//   };
// }

class OrderCart {
  int id;
  int user;
  bool complete;
  String note;

  OrderCart({required this.id, required this.user, required this.complete, required this.note});

  factory OrderCart.fromJson(Map<String, dynamic> json) {
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

  dynamic toJson() => {
    'id' : id,
    'user' : user,
    'complete' : complete,
    'note' : note,
  };
}