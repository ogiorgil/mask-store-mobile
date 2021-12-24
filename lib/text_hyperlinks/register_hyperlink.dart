import 'package:flutter/material.dart';
import '../register_page.dart';

class RegisterHyperlink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? Register "),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
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
