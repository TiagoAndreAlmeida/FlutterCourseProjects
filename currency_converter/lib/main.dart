import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'components/InputField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: Colors.amber,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          )),
      home: MyHomePage(title: '\$ Conversor \$'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dolar;
  double euro;

  TextEditingController _realController = TextEditingController();
  TextEditingController _dolarController = TextEditingController();
  TextEditingController _euroController = TextEditingController();

  Future<Map> _getData() async {
    http.Response response = await http.get("https://api.hgbrasil.com/finance");
    return json.decode(response.body);
  }

  void _handleChange(String label, String value) {
    switch (label) {
      case "Reais":
        double real = double.parse(value);
        _dolarController.text = (real / dolar).toStringAsFixed(2);
        _euroController.text = (real / euro).toStringAsFixed(2);
        break;
      case "Dolar":
        double dolar = double.parse(value);
        _realController.text = (dolar * this.dolar).toStringAsFixed(2);
        _euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
        break;
      case "Euro":
        double euro = double.parse(value);
        _realController.text = (euro * this.euro).toStringAsFixed(2);
        _dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: FutureBuilder<Map>(
            future: _getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      "Carregando dados...",
                      style: TextStyle(color: Colors.amber),
                    ),
                  );

                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Houve um problema ao carregar dados....",
                          style: TextStyle(color: Colors.amber)),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 100,
                          ),
                          InputField(
                              "Reais", "R\$ ", _handleChange, _realController),
                          Divider(),
                          InputField(
                              "Dolar", "\$ ", _handleChange, _dolarController),
                          Divider(),
                          InputField(
                              "Euro", "€ ", _handleChange, _euroController),
                          Divider(),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
