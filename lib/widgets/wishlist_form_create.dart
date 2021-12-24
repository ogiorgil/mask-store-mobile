import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishlistForm extends StatefulWidget {
  const WishlistForm({Key? key}) : super(key: key);

  @override
  _WishlistFormState createState() => _WishlistFormState();
}

class _WishlistFormState extends State<WishlistForm> {
  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  var _countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create/Edit item'),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Example: Masker",
                  labelText: "Name",
                  icon: const Icon(Icons.masks),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name can\'t be empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: "Example: 5",
                  labelText: "Price (\$)",
                  icon: const Icon(Icons.money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Price can\'t be empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _countController,
                decoration: InputDecoration(
                  hintText: "Example: 1",
                  labelText: "Count",
                  icon: const Icon(Icons.one_k),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Count can\'t be empty';
                  }
                  return null;
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        print("Submit button pressed");
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing input')),
                          );

                          var requestUrl =
                              "http://pbp-c07.herokuapp.com/post-data/";

                          final response =
                              await http.post(Uri.parse(requestUrl),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'user': '1',
                                    'name': _nameController.text,
                                    'price': _priceController.text,
                                    'count': _countController.text,
                                  }));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(letterSpacing: 2),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("Clear button pressed");
                        _nameController.clear();
                        _priceController.clear();
                        _countController.clear();
                      },
                      child: const Text(
                        "Clear form",
                        style: TextStyle(letterSpacing: 2),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
