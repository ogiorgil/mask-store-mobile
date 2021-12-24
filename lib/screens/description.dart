import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    this.pressOnSeeMore,
  }) : super(key: key);

  final GestureTapCallback? pressOnSeeMore;

  Future<Map<String, dynamic>> _fecthDataDesc() async {
    var result = await http.get("https://pbp-c07.herokuapp.com/data-deskripsi/");
    Map<String, dynamic> map = json.decode(result.body);
    return map;
  }

  // Future<Album> fetchAlbum() async {
  //   final response =
  //   await http.get('https://jsonplaceholder.typicode.com/albums/1');
  //
  //   // Appropriate action depending upon the
  //   // server response
  //   if (response.statusCode == 200) {
  //     return Album.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Customize Mask",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     padding: EdgeInsets.all(0),
        //     width: 64,
        //     decoration: BoxDecoration(
        //       color:
        //           Color(0xFFFFE6E6),
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         bottomLeft: Radius.circular(20),
        //       ),
        //     ),
        //     child: TextButton(child: Text("Next"),onPressed: (){},)
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
              "Every face is unique, and with our customized mask printing, now every face mask can be, too. We’re here to help you design your own mask!",
            maxLines:3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text("Custom Mask Style"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            TextButton(child: Text("SURGICAL"), onPressed: (){
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                title: const Text("SURGICAL TYPE?"),
                                content: FutureBuilder<Map<String, dynamic>>(
                                  future: _fecthDataDesc(),
                                  builder: (context, snapshot){
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading...");
                                    } else {
                                      if (snapshot.hasData){
                                        return Text(snapshot.data!["SURGICAL"].toString());
                                      } else {
                                        return Text('${snapshot.error}');
                                      }
                                    }
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Close'),
                                    child: const Text('Close'),
                                  )
                                ],
                              ));
                            },),TextButton(child: Text("SPONGE"), onPressed: (){
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                title: const Text("SPONGE TYPE?"),
                                content: FutureBuilder<Map<String, dynamic>>(
                                  future: _fecthDataDesc(),
                                  builder: (context, snapshot){
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading...");
                                    } else {
                                      if (snapshot.hasData){
                                        return Text(snapshot.data!["SPONGE"].toString());
                                      } else {
                                        return Text('${snapshot.error}');
                                      }
                                    }
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Close'),
                                    child: const Text('Close'),
                                  )
                                ],
                              ));
                            },),TextButton(child: Text("PITTA"), onPressed: (){
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                title: const Text("PITTA TYPE?"),
                                content: FutureBuilder<Map<String, dynamic>>(
                                  future: _fecthDataDesc(),
                                  builder: (context, snapshot){
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading...");
                                    } else {
                                      if (snapshot.hasData){
                                        return Text(snapshot.data!["PITTA"].toString());
                                      } else {
                                        return Text('${snapshot.error}');
                                      }
                                    }
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Close'),
                                    child: const Text('Close'),
                                  )
                                ],
                              ));
                            },),TextButton(child: Text("CLOTH"), onPressed: (){
                              Navigator.pop(context);
                              showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                title: const Text("CLOTH TYPE?"),
                                content: FutureBuilder<Map<String, dynamic>>(
                                  future: _fecthDataDesc(),
                                  builder: (context, snapshot){
                                    if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                      return Text("Loading...");
                                    } else {
                                      if (snapshot.hasData){
                                        return Text(snapshot.data!["CLOTH"].toString());
                                      } else {
                                        return Text('${snapshot.error}');
                                      }
                                    }
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Close'),
                                    child: const Text('Close'),
                                  )
                                ],
                              ));
                            },),
                          ],

                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Close'),
                              child: const Text('Close'),
                            ),
                          ]));
            },
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
