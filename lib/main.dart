// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugas_akhir/screens/home_screen.dart';
import 'package:tugas_akhir/screens/masker_detail_screen.dart';
import 'package:tugas_akhir/screens/products_screen.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tugas_akhir/screens/shopping_cart.dart';
import 'package:tugas_akhir/screens/wishlist_screen.dart';
import 'package:tugas_akhir/widgets/wishlist_form_create.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tugas_akhir/screens/custom.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  late Widget _scafBody;
  late String _scafTitle;

  final List<Map<String, Object>> _pages = [
    {'page': const HomeScreen(), 'title': "Tugas Akhir PBP-C07"},
    {
      'page': const ProductsScreen(), //product
      'title': "Products"
    },
  ];
  @override
  void initState() {
    _scafBody = _pages[_selectedIndex]['page'] as Widget;
    _scafTitle = _pages[_selectedIndex]['title'].toString();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _scafBody = _pages[index]['page'] as Widget;
      _scafTitle = _pages[index]['title'].toString();
    });
  }

  final Map<String, Widget> _drawerPage = {
    'home': const HomeScreen(),
    'wishlist': const WishList(),
    'cart': const ShoppingCartForm(),
    'customize': const Custom(),
    'products': const ProductsScreen(),
    'login': LoginPage(),
  };

  final Map<String, String> _titles = {
    'home': "Tugas Akhir PBP-C07",
    'wishlist': 'Wishlist',
    'cart': 'Shopping Cart',
    'customize': 'Customize Masker',
    'products': 'Products',
    'login': 'Login',
  };

  void _drawerTap(String page) {
    setState(() {
      _scafBody = _drawerPage[page] as Widget;
      _scafTitle = _titles[page].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: MyApp.snackbarKey,
      title: 'PBP-C07',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/login': (ctx) => const ,
      routes: {
        // '/products: (context) => const ProductPage(),
        MaskerDetailScreen.routeName: (ctx) => const MaskerDetailScreen(),
        '/wishlist': (ctx) => const WishList(),
        '/create-wishlist': (ctx) => const WishlistForm(),
        '/cart': (ctx) => const ShoppingCartForm(),
        '/home': (ctx) => const HomeScreen(),
        '/products': (ctx) => const ProductsScreen(),
        '/login': (ctx) => LoginPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text(_scafTitle),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: _scafBody,
        ), // home page taro sini
        drawer: Builder(
            builder: (context) => Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            "Welcome, user",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Login"),
                        onTap: () {
                          // do stuff
                          _drawerTap("login");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Home"),
                        onTap: () {
                          // do stuff
                          _drawerTap("home");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Products"),
                        onTap: () {
                          // do stuff
                          _drawerTap("products");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Wishlist"),
                        onTap: () {
                          // do stuff
                          _drawerTap("wishlist");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Customize Masker"),
                        onTap: () {
                          // do stuff
                          _drawerTap("customize");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Cart"),
                        onTap: () {
                          // do stuff
                          _drawerTap("cart");
                          Navigator.pop(context);
                          // Navigator.of(context).pushReplacementNamed('/cart');
                        },
                      ),
                      Form(
                          key: _formKey,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: "abcd@example.com",
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains("@")) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green[900] as Color)),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate()) {
                                        subsHandler(emailController.text)
                                            .then((response) {
                                          String msg = json
                                              .decode(response.body)["message"];
                                          if (msg == "Thank You") {
                                            msg = "Subscribed";
                                            emailController.clear();
                                          } else {
                                            msg =
                                                "You have already subscribed to our newletter";
                                          }
                                          MyApp.snackbarKey.currentState
                                              ?.showSnackBar(
                                            SnackBar(
                                              content: Text(msg),
                                            ),
                                          );
                                        }).onError((error, stackTrace) {
                                          MyApp.snackbarKey.currentState
                                              ?.showSnackBar(SnackBar(
                                            content: Text(error.toString()),
                                          ));
                                        });
                                      }
                                    },
                                    child: const Text('Subscribe'),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          const Text("Contact Us",
                              style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.twitter),
                                    onPressed: () => _launchURL(
                                        "https://twitter.com/twitter"),
                                  ),
                                  IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.facebook),
                                    onPressed: () => _launchURL(
                                        "https://web.facebook.com/MetaIndonesia/?brand_redir=108824017345866"),
                                  ),
                                  IconButton(
                                    icon: const FaIcon(
                                        FontAwesomeIcons.instagram),
                                    onPressed: () => _launchURL(
                                        "https://www.instagram.com/instagram/"),
                                  )
                                ],
                              ))
                        ]),
                      )
                    ],
                  ),
                )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Products',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future<http.Response> subsHandler(String email) {
    return http.post(
        Uri.parse('https://pbp-c07.herokuapp.com/api/mobile/subscribe'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}));
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launcg $url';
  }
}
