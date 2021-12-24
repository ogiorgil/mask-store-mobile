import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/api/shopping_cart/api_custom.dart';
import 'package:tugas_akhir/api/shopping_cart/api_get.dart';
import 'package:tugas_akhir/api/shopping_cart/api_item.dart';
import 'package:tugas_akhir/api/shopping_cart/api_order.dart';
import 'package:tugas_akhir/api/shopping_cart/api_product.dart';
import 'package:tugas_akhir/models/shopping_cart/CustomMaskerCart.dart';
import 'package:tugas_akhir/models/shopping_cart/Get.dart';
import 'package:tugas_akhir/models/shopping_cart/ItemMaskerCart.dart';
import 'package:tugas_akhir/models/shopping_cart/OrderCart.dart';
import 'package:tugas_akhir/models/shopping_cart/ProductMaskerCart.dart';
import 'package:tugas_akhir/utils/ui_helper.dart';
import 'package:tugas_akhir/widgets/veg_badge_view.dart';

class ShoppingCartForm extends StatefulWidget {
  const ShoppingCartForm({Key? key}) : super(key: key);

  @override
  _ShoppingCartFormState createState() => _ShoppingCartFormState();
}

class _ShoppingCartFormState extends State<ShoppingCartForm> {
  late Future<OrderCart> futureOrderCart = fetchOrderCart();
  late Future<List<ItemMaskerCart>?> futureItemMaskerCart = fetchItemMaskerCart();
  late Future<List<ProductMaskerCart>?> futureProductMaskerCart = fetchProductCart();
  late Future<List<CustomMaskerCart>?> futureCustomMaskerCart = fetchCustomMaskerCart();
  late Future<Get> futureGet = fetchGet();

  final _formKey = GlobalKey<FormState>();
  String note = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Product Masker
                  Row(
                    children: <Widget>[
                      Icon(Icons.masks_rounded, size: 20.0),
                      UIHelper.horizontalSpaceSmall(),
                      Text(
                        'Product Masker Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20.0),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium(),
                  FutureBuilder(
                    future: futureProductMaskerCart,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Erro'),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data.toString().length == 2) {
                          return const Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 0.0, bottom: 10.0, start: 0.0, end: 0.0),
                              child: Center(
                                child: Text('Product Masker Cart is Empty'),
                              ));
                        }
                        var futureProduct = snapshot.data;
                        return FutureBuilder(
                            future: futureItemMaskerCart,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Error'),
                                );
                              } else if (snapshot.hasData) {
                                if (snapshot.data.toString().length == 2) {
                                  return const Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 0.0, bottom: 10.0, start: 0.0, end: 0.0),
                                      child: Center(
                                        child: Text('Product Masker Cart is Empty'),
                                      ));
                                }
                                return _listProduct(futureProduct as List<ProductMaskerCart>,
                                    snapshot.data as List<ItemMaskerCart>);
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            });
                        // return _listProduct(snapshot.data as List<ProductMaskerCart>);
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  _DecoratedView(),
                  UIHelper.verticalSpaceMedium(),
                  // Custom Masker
                  Row(
                    children: <Widget>[
                      Icon(Icons.masks_rounded, size: 20.0),
                      UIHelper.horizontalSpaceSmall(),
                      Text(
                        'Custom Masker Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20.0),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium(),
                  FutureBuilder(
                    future: futureCustomMaskerCart,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data.toString().length == 2) {
                          return const Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 0.0, bottom: 10.0, start: 0.0, end: 0.0),
                              child: Center(
                                child: Text('Custom Masker Cart is Empty'),
                              ));
                        }
                        return _listCustom(snapshot.data as List<CustomMaskerCart>);
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  _DecoratedView(),
                  // Form Catatan
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            onChanged: (String value) {
                              note = value;
                            },
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Catatan Pemesanan',
                            ),
                          ),
                        ),
                        FutureBuilder<OrderCart>(
                          future: futureOrderCart,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error'),
                              );
                            } else if (snapshot.hasData) {
                              if (snapshot.data!.user == 0) {
                                return const Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 10.0, bottom: 10.0, start: 0.0, end: 0.0),
                                    child: Center(
                                      child: Text('Login first',
                                          style: TextStyle(color: Colors.red)),
                                    ));
                              }
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.green),
                                  ),
                                  onPressed: () async {
                                    final response = await http.post(
                                        Uri.parse('http://127.0.0.1:8000/order_json/'),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json; charset=UTF-8'
                                        },
                                        body: jsonEncode(<String, String>{
                                          'note': note,
                                          'user': snapshot.data!.user.toString()
                                        }));
                                    print(response);
                                    print(response.body);
                                    setState(() {
                                      futureOrderCart = fetchOrderCart();
                                    });
                                  },
                                  child: const Text('Simpan'),
                                ),
                              );
                            }
                            // By default, show a loading spinner.
                            return const Center(
                              child: Text('None'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  _DecoratedView(),
                  UIHelper.verticalSpaceMedium(),
                  // Ringkasan Shopping Cart
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Ringkasan',
                          style:
                          Theme.of(context).textTheme.headline6!.copyWith(fontSize: 17.0),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Jumlah Item',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 16.0)),
                            FutureBuilder<Get>(
                              future: futureGet,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Error'),
                                  );
                                } else if (snapshot.hasData) {
                                  return Text(snapshot.data!.getItemsTotal.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 16.0));
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Total Harga',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 16.0)),
                            FutureBuilder<Get>(
                              future: futureGet,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Error'),
                                  );
                                } else if (snapshot.hasData) {
                                  return Text(
                                      "\$" + snapshot.data!.getPriceTotal.toString() + ".00",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 16.0));
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceMedium(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Catatan',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 16.0)),
                            FutureBuilder<OrderCart>(
                              future: futureOrderCart,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('None'),
                                  );
                                } else if (snapshot.hasData) {
                                  if (snapshot.data!.user == 0) {
                                    return const Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            top: 10.0, bottom: 10.0, start: 0.0, end: 0.0),
                                        child: Center(
                                          child: Text('Login first',
                                              style: TextStyle(color: Colors.red)),
                                        ));
                                  }
                                  return Text(snapshot.data!.note.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 16.0));
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceLarge(),
                      ],
                    ),
                  ),
                  // Checkout
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10.0),
                                color: Colors.green,
                                height: 58.0,
                                child: Text(
                                  'CHECKOUT',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        )
    );
  }

  Widget _listProduct(List<ProductMaskerCart> products, List<ItemMaskerCart> items) {
    double field = 130;
    return Container(
      height: field * items.length,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index].fields;
          var product = products[index].fields;
          return ListTile(
            title: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(
                      'http://res.cloudinary.com/dvfyxrw6z/' +
                          product!.image.toString(),
                      height: 60.0,
                      width: 60.0,
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    Column(
                      children: <Widget>[
                        Text(product.nama.toString(),
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () async {
                        final response = await http.post(
                            Uri.parse('http://127.0.0.1:8000/item_json/'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8'
                            },
                            body: jsonEncode(<String, String>{
                              'order': item!.order.toString(),
                              'product': item.product.toString(),
                              'quantity': 0.toString()
                            }));
                        print(response);
                        print(response.body);
                        setState(() {
                          futureItemMaskerCart = fetchItemMaskerCart();
                          futureProductMaskerCart = fetchProductCart();
                          futureGet = fetchGet();
                        });
                      },
                      child: const Icon(Icons.close,
                          size: 20.0, color: Colors.white),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall(),
                Row(
                  children: <Widget>[
                    VegBadgeView(),
                    UIHelper.horizontalSpaceSmall(),
                    Text('\$' + product.harga.toString() + '.00',
                        style: Theme.of(context).textTheme.subtitle2),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: 35.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Icon(Icons.remove, color: Colors.green),
                            onTap: () {
                              if (item!.quantity > 1) {
                                setState(() {
                                  item.quantity -= 1;
                                });
                              }
                            },
                          ),
                          Spacer(),
                          Text(item!.quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 16.0)),
                          Spacer(),
                          InkWell(
                            child: Icon(Icons.add, color: Colors.green),
                            onTap: () {
                              setState(() {
                                item.quantity += 1;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
                        final response = await http.post(
                            Uri.parse('http://127.0.0.1:8000/item_json/'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8'
                            },
                            body: jsonEncode(<String, String>{
                              'order': item.order.toString(),
                              'product': item.product.toString(),
                              'quantity': item.quantity.toString()
                            }));
                        print(response);
                        print(response.body);
                        setState(() {
                          futureItemMaskerCart = fetchItemMaskerCart();
                          futureProductMaskerCart = fetchProductCart();
                          futureGet = fetchGet();
                        });
                      },
                      child: const Text("Simpan"),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium(),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _listCustom(List<CustomMaskerCart> customs) {
    double field = 115;
    return Container(
      height: field * customs.length,
      child: ListView.builder(
        itemCount: customs.length,
        itemBuilder: (context, index) {
          var custom = customs[index].fields;
          return ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(
                      'http://res.cloudinary.com/dvfyxrw6z/' +
                          custom!.style.toString(),
                      height: 60.0,
                      width: 60.0,
                    ),
                    UIHelper.horizontalSpaceSmall(),
                    Column(
                      children: <Widget>[
                        Text(custom.model.toString() + " MASKER",
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    )
                  ],
                ),
                UIHelper.verticalSpaceSmall(),
                Row(
                  children: <Widget>[
                    Text('Sex:', style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceSmall(),
                    Text(custom.sex.toString(),
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceMedium(),
                    Text('Size:', style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceSmall(),
                    Text(custom.size.toString(),
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceMedium(),
                    Text('Color:',
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceSmall(),
                    Text(custom.color.toString(),
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceMedium(),
                    Text('Price:',
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceSmall(),
                    Text('\$' + custom.price.toString() + ".00",
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceMedium(),
                    Text('Quantity:',
                        style: Theme.of(context).textTheme.subtitle2),
                    UIHelper.horizontalSpaceSmall(),
                    Text(custom.quantity.toString(),
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                UIHelper.verticalSpaceMedium(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DecoratedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0,
      color: Colors.grey[200],
    );
  }
}
