import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'widgets/simple_table_page.dart';
import '../models/wishlist_item.dart';

Future<List<WishlistItem>> fetchItems() async {
  const url = 'http://localhost:8000/request-data';
  List<WishlistItem> items = [];
  try {
    final response = await http.get(
      Uri.parse(url),
    );
    // print(response.body);
    List<dynamic> extractedData = jsonDecode(response.body);
    extractedData.forEach((map) {
      Map<String, dynamic> fields = map["fields"];
      // List<String> temp = [];
      // fields.forEach((vkey, vvalue) {
      //   temp.add(vvalue.toString());
      // });
      // data.add(temp);
      items.add(WishlistItem.fromJson(fields));
    });
  } catch (error) {
    print(error);
  }
  return Future.value(items);
}

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  List<List<String>> makeData() {
    final List<List<String>> output = [];

    List<String> r = [];
    r.add("1");
    r.add("2");

    output.add(r);
    output.add(r);

    return output;
  }

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late Future<List<WishlistItem>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = fetchItems();
  }

  double iconSize = 40;
  static double buttonIconSize = 18;
  static const rowTextStyle = TextStyle(
    fontSize: 17,
  );
  static const buttonSize = Size(150, 25);

  @override
  Widget build(BuildContext context) {
    print("FUTURE");
    print(futureItems);
    // inspired by https://blog.devgenius.io/understanding-futurebuilder-in-flutter-491501526373
    return FutureBuilder<List<WishlistItem>>(
      future: futureItems,
      builder: (ctx, snapshot) {
        List<WishlistItem>? items = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return buildTable(items!);
          default:
            return buildLoadingScreen();
        }
      },
    );
  }

  Widget buildTable(List<WishlistItem> items) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: const Text(
            "Wishlist Page",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
            icon: const Icon(Icons.add),
            label: const Text("New Wishlist Item"),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Table(
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                Column(children: [
                  Icon(Icons.text_fields, size: iconSize),
                  const Center(
                    child: Text("Name", style: rowTextStyle),
                  ),
                ]),
                Column(children: [
                  Icon(Icons.money, size: iconSize),
                  const Text("Price", style: rowTextStyle),
                ]),
                Column(children: [
                  Icon(Icons.confirmation_number, size: iconSize),
                  const Text("Count", style: rowTextStyle),
                ]),
                Column(children: [
                  Icon(Icons.call_to_action, size: iconSize),
                  const Text("Action", style: rowTextStyle),
                ]),
              ]),
              for (WishlistItem item in items)
                TableRow(
                  children: [
                    // name
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(32.5),
                          child: Text(item.name, style: rowTextStyle),
                        ),
                      ],
                    ),

                    // price
                    Column(children: [
                      Padding(
                        padding: EdgeInsets.all(32.5),
                        child: Text("\$${item.price}", style: rowTextStyle),
                      ),
                    ]),

                    // count
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(32.5),
                          child:
                              Text(item.count.toString(), style: rowTextStyle),
                        ),
                      ],
                    ),

                    // action
                    Column(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text("Edit"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow.shade800,
                            fixedSize: buttonSize,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete, size: 18),
                          label: const Text("Delete"),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            fixedSize: buttonSize,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_cart, size: 18),
                          label: const Text("Add to Cart"),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            fixedSize: buttonSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
