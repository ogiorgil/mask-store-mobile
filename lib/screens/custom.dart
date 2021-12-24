import 'package:flutter/material.dart';
import 'package:tugas_akhir/screens/images.dart';
import 'package:tugas_akhir/screens/description.dart';
import 'package:tugas_akhir/screens/form.dart';

class Custom extends StatelessWidget {
  const Custom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
          children: [
            ProductImages(),
            SizedBox(
              height: 20,
            ),
            ProductDescription(
              pressOnSeeMore: () {},
            ),
            BelajarForm(),
          ],
        );
  }
}
