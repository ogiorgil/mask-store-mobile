import 'package:flutter/material.dart';
import '../login_page.dart';
import '../text_hyperlinks/login_hyperlink.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _registFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String firstName = '';
  String lastName = '';
  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (value.isEmpty || value == null) {
      return "E-mail must not empty!";
    }
    if (!regex.hasMatch(value)) {
      return "Enter a valid e-mail address!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Register Page"),
          elevation: 5,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Colors.grey])),
          )),
      body: Form(
        key: _registFormKey,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // First name field
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First name must not empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.account_box_rounded,
                          color: Colors.grey,
                        ),
                        labelText: "First name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your first name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  // Last name field
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last name must not empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.account_box_rounded,
                          color: Colors.grey,
                        ),
                        labelText: "Last name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your last name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  // Email field
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    maxLength: 20,
                    validator: (value) => validateEmail(value!),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_rounded,
                          color: Colors.grey,
                        ),
                        labelText: "E-mail",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your e-mail address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  // Username field
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    onChanged: (value) {
                      username = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username must not empty!";
                      }
                      if (value.length < 5) {
                        return "Username must at least contains 5 characters!";
                      }
                      return null;
                    },
                    maxLength: 15,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.alternate_email_rounded,
                          color: Colors.grey,
                        ),
                        labelText: "Username",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Column(
                  // Password field
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password must not empty!";
                          }
                          return null;
                        },
                        obscureText: true,
                        maxLength: 20,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_rounded,
                              color: Colors.grey,
                            ),
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
                Container(
                  // Confirm password field
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    controller: confirmPassController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirm password must not empty!";
                      }
                      if (passwordController.text !=
                          confirmPassController.text) {
                        return "Password does not match!";
                      }
                      return null;
                    },
                    obscureText: true,
                    maxLength: 20,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_rounded,
                          color: Colors.grey,
                        ),
                        labelText: "Confirm password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your confirm password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  // Register button
                  width: MediaQuery.of(context).size.width / 2,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.blueAccent.shade700,
                      minimumSize: const Size(80, 50),
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.blueAccent.shade700,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () async {
                      if (_registFormKey.currentState!.validate()) {
                        final response = await http.post(
                            Uri.parse(
                                "http://pbp-c07.herokuapp.com/register-flutter"),
                            headers: <String, String>{
                              'Content-Type': 'application/json;charset=UTF-8'
                            },
                            body: jsonEncode(<String, String>{
                              'first_name': firstName,
                              'last_name': lastName,
                              'email': email,
                              'username': username,
                              'password': password,
                              'confirm_password': confirmPassword
                            }));
                        print(response.body);
                        String status = jsonDecode(response.body)['status'];
                        print(status);

                        if (status == 'register berhasil') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                            children: const [
                              Icon(Icons.info_outline_rounded,
                                  size: 30, color: Colors.white),
                              Spacer(
                                flex: 1,
                              ),
                              Text("Register successful",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          )));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                            children: const [
                              Icon(Icons.warning_amber_rounded,
                                  size: 30, color: Colors.white),
                              Spacer(
                                flex: 1,
                              ),
                              Text("Email or username has been used!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          )));
                        }
                      }
                    },
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),
                ),
                LoginHyperlink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
