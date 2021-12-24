import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas_akhir/api/shopping_cart/api_get.dart';
import 'package:tugas_akhir/api/shopping_cart/api_order.dart';
import 'package:tugas_akhir/models/shopping_cart/Get.dart';
import 'package:tugas_akhir/models/shopping_cart/OrderCart.dart';
import 'package:tugas_akhir/utils/ui_helper.dart';

class MyCheckoutForm extends StatefulWidget {
  const MyCheckoutForm({Key? key}) : super(key: key);

  @override
  MyCheckoutFormState createState() {
    return MyCheckoutFormState();
  }
}

class MyCheckoutFormState extends State<MyCheckoutForm> {
  // const MyScaffold({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  static String? namaLengkap,
      email,
      nomorTelepon,
      alamat,
      durasi,
      kurir,
      metodePembayaran;

  // SUMBER: https://stackoverflow.com/questions/63292839/how-to-validate-email-in-a-textformfield
  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Masukkan email dengan benar';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      color: Color.fromARGB(255, 20, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Color.fromARGB(255, 32, 32, 32),
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // STEP1
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Color.fromARGB(255, 50, 55, 62),
                      ),
                      height: 60,
                      width: 375,
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('SECURE CHECKOUT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            )),
                      ),
                    ),
                    Container(
                        // STEP1Form
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black, width: 1),
                            right: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                          color: Color.fromARGB(255, 50, 55, 62),
                        ),
                        // height: 550,
                        width: 375,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                                key: _formKey,
                                child: Column(children: <Widget>[
                                  TextFormField(
                                    initialValue: namaLengkap,
                                    onSaved: (String? value) {
                                      namaLengkap = value;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: "Nama Lengkap",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: "Contoh: Uvuvwewe Osas",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15),
                                        icon: Icon(
                                            Icons.account_circle_outlined)),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukkan nama lengkap dengan benar';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                      initialValue: email,
                                      onSaved: (String? value) {
                                        email = value;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: "Email",
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: "Contoh: Osas@Hotmail.com",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 15),
                                          icon: Icon(Icons.alternate_email)),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      validator: (value) => validateEmail(value)
                                      //   if (value!.isEmpty || value.length < 8) {
                                      //     return 'Tolong masukkan email dengan benar';
                                      //   }
                                      //   return null;
                                      // },
                                      ),
                                  TextFormField(
                                    initialValue: nomorTelepon,
                                    onSaved: (String? value) {
                                      nomorTelepon = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                        labelText: "Nomor Telepon",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: "Contoh: 08111756969",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15),
                                        icon:
                                            Icon(Icons.contact_phone_outlined)),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 10) {
                                        return 'Masukkan nomor telepon dengan benar';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: alamat,
                                    onSaved: (String? value) {
                                      alamat = value;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: "Alamat",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        hintText:
                                            "Contoh: Jalan Merpati 14, Cibubur, Kab. Bogor",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 15),
                                        icon: Icon(Icons.home_outlined)),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 10) {
                                        return 'Masukkan alamat dengan benar';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownButtonFormField(
                                    value: durasi,
                                    icon: const Icon(Icons.arrow_downward),
                                    dropdownColor: Colors.grey,
                                    decoration: InputDecoration(
                                      labelText: "Durasi",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      icon: Icon(Icons.access_time),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                    ),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        durasi = newValue!;
                                      });
                                    },
                                    onSaved: (String? newValue) {
                                      durasi = newValue;
                                    },
                                    items: <String>[
                                      'Next Day (1 Hari) *\$3',
                                      'Reguler (2-4 Hari) *\$1',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButtonFormField(
                                    value: kurir,
                                    icon: const Icon(Icons.arrow_downward),
                                    dropdownColor: Colors.grey,
                                    decoration: InputDecoration(
                                      labelText: "Kurir",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      icon: Icon(Icons.local_shipping_outlined),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                    ),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        kurir = newValue!;
                                      });
                                    },
                                    onSaved: (String? newValue) {
                                      kurir = newValue;
                                    },
                                    items: <String>[
                                      'AnterAja',
                                      'Tiki',
                                      'JNE',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButtonFormField(
                                    value: metodePembayaran,
                                    icon: const Icon(Icons.arrow_downward),
                                    dropdownColor: Colors.grey,
                                    decoration: InputDecoration(
                                      labelText: "Metode Pembayaran",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      icon: Icon(Icons
                                          .account_balance_wallet_outlined),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.black),
                                      // ),
                                    ),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.white),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        metodePembayaran = newValue!;
                                      });
                                    },
                                    onSaved: (String? newValue) {
                                      metodePembayaran = newValue;
                                    },
                                    items: <String>[
                                      'Mandiri Virtual Account',
                                      'BCA Virtual Account',
                                      'Bank Mandiri',
                                      'Bank BCA',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child: Row (
                                      mainAxisAlignment : MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                            color:
                                            Color.fromARGB(255, 194, 191, 191),
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                'Back' /*style: TextStyle(fontSize: 30),*/)),
                                        UIHelper.horizontalSpaceSmall(),
                                        RaisedButton(
                                            color:
                                            Color.fromARGB(255, 194, 191, 191),
                                            textColor: Colors.white,
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const MyConfirmation()),
                                                );
                                                print(namaLengkap);
                                                print(email);
                                                print(nomorTelepon);
                                                print(alamat);
                                                print(durasi);
                                                print(kurir);
                                                print(metodePembayaran);
                                              }
                                            },
                                            child: Text(
                                                'Lanjut' /*style: TextStyle(fontSize: 30),*/)),
                                      ],
                                    )
                                  ),
                                ])),
                          ],
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class MyConfirmation extends StatefulWidget {
  const MyConfirmation({Key? key}) : super(key: key);

  @override
  MyConfirmationFormState createState() {
    return MyConfirmationFormState();
  }
}

class MyConfirmationFormState extends State<MyConfirmation> {
  late Future<OrderCart> futureOrderCart = fetchOrderCart();
  late Future<Get> futureGet = fetchGet();
  int? cariHargaPengiriman(String? value, int hargaBarang) {
    if (value == 'Next Day (1 Hari) *\$3') {
      return 3 + hargaBarang;
    } else if (value == 'Reguler (2-4 Hari) *\$1') {
      return 1 + hargaBarang;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      color: Color.fromARGB(255, 20, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Color.fromARGB(255, 32, 32, 32),
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // STEP1
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Color.fromARGB(255, 50, 55, 62),
                      ),
                      height: 60,
                      width: 375,
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('SECURE CHECKOUT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            )),
                      ),
                    ),
                    Container(
                        // STEP1Form
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black, width: 1),
                            right: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                          color: Color.fromARGB(255, 50, 55, 62),
                        ),
                        // height: 550,
                        width: 375,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                                child: Column(children: <Widget>[
                              TextFormField(
                                initialValue: MyCheckoutFormState.namaLengkap,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Nama Lengkap",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.account_circle_outlined)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue: MyCheckoutFormState.email,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.alternate_email)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue: MyCheckoutFormState.nomorTelepon,
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Nomor Telepon",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.contact_phone_outlined)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue: MyCheckoutFormState.alamat,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Alamat",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.home_outlined)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue: MyCheckoutFormState.durasi,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Durasi",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.access_time)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue: MyCheckoutFormState.kurir,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Kurir",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(Icons.local_shipping_outlined)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                initialValue:
                                    MyCheckoutFormState.metodePembayaran,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Metode Pembayaran",
                                    labelStyle: TextStyle(color: Colors.white),
                                    icon: Icon(
                                        Icons.account_balance_wallet_outlined)),
                                style: const TextStyle(color: Colors.white),
                              ),
                              FutureBuilder<Get>(
                                future: futureGet,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Error'),
                                    );
                                  } else if (snapshot.hasData) {
                                    return TextFormField(
                                      initialValue: snapshot.data!.getItemsTotal.toString(),
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: "Banyak Produk/Harga Produk",
                                          labelStyle: TextStyle(color: Colors.white),
                                          icon: Icon(Icons.shopping_cart_outlined)),
                                      style: const TextStyle(color: Colors.white),
                                    );
                                  }
                                  // By default, show a loading spinner.
                                  return const CircularProgressIndicator();
                                },
                              ),
                              FutureBuilder<Get>(
                                future: futureGet,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Error'),
                                    );
                                  } else if (snapshot.hasData) {
                                    return TextFormField(
                                      initialValue: cariHargaPengiriman(
                                          MyCheckoutFormState.durasi, snapshot.data!.getPriceTotal)
                                          .toString(),
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelText: "Harga Akhir",
                                          labelStyle: TextStyle(color: Colors.white),
                                          icon: Icon(Icons.attach_money)),
                                      style: const TextStyle(color: Colors.white),
                                    );
                                  }
                                  // By default, show a loading spinner.
                                  return const CircularProgressIndicator();
                                },
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
                                          return TextFormField(
                                            initialValue: 'Login First',
                                            readOnly: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                labelText: "Note",
                                                labelStyle: TextStyle(color: Colors.white),
                                                icon: Icon(Icons.notes)),
                                            style: const TextStyle(color: Colors.red),
                                          );
                                        }
                                        return TextFormField(
                                          initialValue: snapshot.data!.note,
                                          readOnly: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              labelText: "Note",
                                              labelStyle: TextStyle(color: Colors.white),
                                              icon: Icon(Icons.notes)),
                                          style: const TextStyle(color: Colors.white),
                                        );
                                      }
                                      // By default, show a loading spinner.
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                    "Jika ingin mengganti detail checkout, tekan tombol Ubah.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: RaisedButton(
                                    color: Color.fromARGB(255, 194, 191, 191),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const MyCheckoutForm()),
                                      // );
                                      Navigator.pop(context);

                                      // Kosongin cart, back to home page
                                    },
                                    child: Text('Ubah')),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                    "Jika data sudah benar, tekan tombol Checkout.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: RaisedButton(
                                    color: Color.fromARGB(255, 194, 191, 191),
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      MyCheckoutFormState.namaLengkap = null;
                                      MyCheckoutFormState.email = null;
                                      MyCheckoutFormState.nomorTelepon = null;
                                      MyCheckoutFormState.alamat = null;
                                      MyCheckoutFormState.durasi = null;
                                      MyCheckoutFormState.kurir = null;
                                      MyCheckoutFormState.metodePembayaran = null;
                                      // Kosongin cart, back to home page
                                      final response = await http.post(
                                        Uri.parse('http://127.0.0.1:8000/checkout_flutter'),
                                        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'});
                                      print(response);
                                      print(response.body);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Checkout')),
                              ),
                            ])),
                          ],
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: MyCheckoutForm(),
      ),
    ),
  );
}
