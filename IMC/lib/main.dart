import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculadora IMC'),
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
  GlobalKey<FormState> _formController = GlobalKey<FormState>();

  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  String inforText = "Informe seus dados";

  void _calcIMC() {
    double weight = double.parse(weigthController.text);
    double height = double.parse(heigthController.text) / 100;
    double imc = weight / height;

    setState(() {
      if (imc < 18.6) {
        inforText = "Abaixo do peso (${imc.toStringAsFixed(3)})";
      } else if (imc >= 18.6 && imc <= 24.9) {
        inforText = "Peso ideal (${imc.toStringAsFixed(3)})";
      } else if (imc >= 24.9 && imc <= 29.9) {
        inforText = "Levemente acima do peso (${imc.toStringAsFixed(3)})";
      } else if (imc >= 29.9 && imc <= 34.9) {
        inforText = "Obesidade grau I (${imc.toStringAsFixed(3)})";
      } else if (imc >= 34.9 && imc <= 39.9) {
        inforText = "Obesidade grau II (${imc.toStringAsFixed(3)})";
      } else if (imc > 40) {
        inforText = "Obesidade grau III (${imc.toStringAsFixed(3)})";
      }
    });
  }

  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";
    _formController.currentState.reset();
    setState(() {
      inforText = "Informe seus dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
            key: _formController,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 90.0,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe seu peso";
                        }
                      },
                      controller: weigthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (Kg)",
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.green)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Informe sua altura";
                        }
                      },
                      controller: heigthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.green)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formController.currentState.validate()) {
                            _calcIMC();
                          }
                        },
                        color: Colors.green,
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    inforText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 16.0),
                  )
                ])),
      )),
    );
  }
}
