import 'package:flutter/material.dart';

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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Fill with your details";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      String _infoText = "Fill with your details!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Underweight  (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText = "Ideal weight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc < 29.9) {
        _infoText = "Obese (Class I) (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc < 39.9) {
        _infoText = "Obese (Class II) (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obese (Class III) (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: weightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    // ignore: missing_return
                    return "Fill your Weight!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "Height (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: heightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Fill your Height!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green),
                ),
              ),
              Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0))
            ],
          ),
        ),
      ),
    );
  }
}
