import 'package:flutter/material.dart';
import '../login_page.dart';

class LoginHyperlink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? Login "),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("here",
                  style: TextStyle(
                      color: Colors.blue[900],
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blue[900])),
            ),
          ],
        ));
  }
}
