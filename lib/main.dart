import 'package:flutter/material.dart';

TextEditingController weightController = new TextEditingController();
TextEditingController heightController = new TextEditingController();

GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

String _info = "Informe seus dados";

void _reset() {
  weightController.text = "";
  heightController.text = "";
  _info = "Informe seus dados";
}

void _calculateImc() {
  // setState(() {
  double weight = double.parse(weightController.text);
  double height = double.parse(heightController.text) / 100;
  double imc = weight / (height * height);

  if (imc < 18.6) {
    print(imc);
    _info = "abaixo do peso ${imc.toStringAsPrecision(3)}";
  } else if (imc >= 18.6 && imc < 24.9) {
    _info = "Peso ideal ${imc.toStringAsPrecision(3)}";
  } else if (imc >= 24.9 && imc < 29.9) {
    _info = "Levemente acima do Peso ${imc.toStringAsPrecision(3)}";
  } else if (imc >= 29.9 && imc < 34.9) {
    _info = "Obesidade grau I ${imc.toStringAsPrecision(3)}";
  } else if (imc >= 34.9 && imc < 39.9) {
    _info = "Obesidade grau II ${imc.toStringAsPrecision(3)}";
  } else if (imc >= 40) {
    _info = "Obesidade grau III ${imc.toStringAsPrecision(3)}";
  }

  //});
}

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _reset();
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.deepPurple,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "peso(kg)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Erro: insira seu peso";
                      }
                      return "";
                    }),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Erro: insira sua altura";
                      }
                      return "";
                    }),
                Container(
                  height: 55,
                  child: RaisedButton(
                    onPressed: () {
                      //chamar setstate dentro da acao funciona? dentro da classe fiz o teste e não
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          _calculateImc();
                        });
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 27, color: Colors.white),
                    ),
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                )
              ],
            ),
          )),
    );
  }
}
