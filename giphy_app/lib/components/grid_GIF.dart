import 'package:flutter/material.dart';
import 'package:giphy_app/pages/gif.dart';

Widget gridGIF(BuildContext context, List data, ScrollController _controler) {
  return GridView.builder(
      padding: EdgeInsets.all(10),
      controller: _controler,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final Map<String, dynamic> image = data[index].getDownsize();
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GIFPage(data[index])));
          },
          child: Image.network(
            image["url"],
            height: double.parse(image["height"]),
            fit: BoxFit.cover,
          ),
        );
      });
}
