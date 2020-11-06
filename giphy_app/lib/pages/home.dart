import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giphy_app/components/grid_GIF.dart';
import 'package:giphy_app/models/GIF.dart';
import 'package:giphy_app/services/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GIF> _gifList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentTreending();
  }

  Future<void> _getCurrentTreending() async {
    Map<String, dynamic> response = await getTreending(10, "r");
    List<GIF> newList = [];

    for (dynamic i in response["data"]) {
      GIF gif = new GIF.fromJson(i);
      newList.add(gif);
    }

    setState(() {
      _gifList = newList;
      loading = false;
    });
  }

  Future<void> _getSearchGIF(String value) async {
    Map<String, dynamic> response = await getSearch(10, "pg", value);
    List<GIF> newList = [];

    for (dynamic i in response["data"]) {
      GIF gif = new GIF.fromJson(i);
      newList.add(gif);
    }

    setState(() {
      _gifList = newList;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, decoration: TextDecoration.none),
              decoration: InputDecoration(
                  labelText: "Pesquise aqui...", border: OutlineInputBorder()),
              onSubmitted: (value) {
                setState(() {
                  loading = true;
                });
                _getSearchGIF(value);
              },
            ),
          ),
          Expanded(
              child: loading
                  ? Container(
                      width: 50,
                      height: 20,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    )
                  : gridGIF(context, _gifList))
        ],
      ),
    );
  }
}
