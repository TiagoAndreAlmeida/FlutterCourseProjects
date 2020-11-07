import 'package:flutter/material.dart';
import 'package:giphy_app/models/GIF.dart';
import 'package:share/share.dart';

class GIFPage extends StatelessWidget {
  final GIF _gifData;

  GIFPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData.title),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(_gifData.getDownsize()["url"]);
              })
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData.getDownsize()["url"]),
      ),
    );
  }
}
