import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {


  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  var imagelist = [
    "assets/images/maskers3.png",
    "assets/images/CLOTH.jpeg",
    "assets/images/PITTA.jpeg",
    "assets/images/SPONGE.jpeg"
  ];
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: "Hai",
              child: Image.asset(imagelist[selectedImage]),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(4, (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(10),
        height: 48,
        width: 48,
        child: Image.asset(imagelist[index]),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  selectedImage == index ? Colors.black : Colors.transparent),
        ),
      ),
    );
  }
}
