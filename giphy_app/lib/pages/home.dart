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
  ScrollController _scrollController = new ScrollController();
  List<GIF> _gifList = [];
  int _offset = 0;
  bool loading = true;
  bool loadingNext = false;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    _getGIF();
    _scrollController.addListener(_loadMoreGIF);
  }

  void _loadMoreGIF() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _getGIF();
    }
  }

  Future<void> _getGIF() async {
    if (!loadingNext) {
      Map<String, dynamic> response;
      List<GIF> newList = [];

      setState(() {
        loadingNext = true;
      });

      if (searchText.isEmpty) {
        response = await getTreending(_offset, 10, "r");
      } else {
        response = await getSearch(_offset, 10, "r", searchText);
      }

      for (dynamic i in response["data"]) {
        GIF gif = new GIF.fromJson(i);
        newList.add(gif);
      }

      setState(() {
        _gifList = [..._gifList, ...newList];
        loading = false;
        loadingNext = false;
        _offset = _offset + 10;
      });
    }
  }

  // Future<void> _getSearchGIF() async {
  //   Map<String, dynamic> response = await getSearch(10, "pg", value);
  //   List<GIF> newList = [];

  //   for (dynamic i in response["data"]) {
  //     GIF gif = new GIF.fromJson(i);
  //     newList.add(gif);
  //   }

  //   setState(() {
  //     _gifList = newList;
  //     loading = false;
  //   });
  // }

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
                  searchText = value;
                  _offset = 0;
                  _gifList = [];
                });
                _getGIF();
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
                  : gridGIF(context, _gifList, _scrollController))
        ],
      ),
    );
  }
}
