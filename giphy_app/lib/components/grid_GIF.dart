import 'package:flutter/material.dart';

Widget gridGIF(BuildContext context, List data) {
  return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final Map<String, dynamic> image = data[index].getFixedHeight();
        return GestureDetector(
          child: Image.network(
            image["url"],
            height: double.parse(image["height"]),
            fit: BoxFit.cover,
          ),
        );
      });
}
