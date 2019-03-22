import 'package:flutter/material.dart';

void main() {

  // main method will be responsible for calling Home<StatefulWidget>
  runApp(MaterialApp(
    home: Home(),
    // will be responsabile for calling method home.createState()

    /* MaterialApp will manage _HomeState.build calls
           _HomeState _homeState = home.createState()
           _homeState.build()
           ...
           _homeState.build()
           -- it will use Home<StatefulWidget>.createState just to get _HomeState
        */
  ));

}

// Class Home extends from StatefulWidget
class Home extends StatefulWidget {

  // class Home needs to @override createState() method from Stateful Widget
  // This class responsability is to return an instance of _HomeState
  // Class Home.createState wil be called from main function
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  String _infoText = 'Infome seus dados!';

  dynamic _onRefresh() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      _infoText = 'Informe seus dados';
    });
  }

  _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);
      String imcstr = imc.toStringAsPrecision(4);
      if (imc < 18.6) {
         _infoText = 'Abaixo do Peso ($imcstr)';
      } else if (imc >= 18.6 && imc < 24.9) {
         _infoText = 'Peso Ideal ($imcstr)';
      } else if (imc >= 24.9 && imc < 29.9) {
         _infoText = 'Levemente Acima do Peso ($imcstr)';
      } else if (imc >= 29.9 && imc < 34.9) {
         _infoText = 'Obesidade Grau I ($imcstr)';
      } else if (imc >= 34.9 && imc < 39.9) {
         _infoText = 'Obesidade Grau II ($imcstr)';
      }

    });
  }

  // Overrides builds method from State
  @override
  Widget build(BuildContext  context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh,  color: Colors.white), // change color here
            onPressed:  _onRefresh,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch, // makes a stretch for right and left
              children: <Widget>[
                Icon(
                  Icons.people_outline,
                  size: 120.0,
                  color: Colors.blue,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        //fontSize: 65.0,   // enable this parameter
                        fontStyle: FontStyle.normal,
                      )
                  ),
                  textAlign: TextAlign.center, // make a few tests with this
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira seu peso (kg)!';
                    }
                  },

                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(                // TextDecoration?
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: heightController,
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Informe sua altura (cm)!';
                    }
                  },
                ),

                Padding(  // It's good to have a padding for each Widget
                  padding: EdgeInsets.fromLTRB(0,10,0,10),
                  child: Container(
                      // Form a padding. The size of the Widget. Changes affect
                      // (inner widget)
                      //will be smalllserr
                      height: 50.00, // It gives an specific size for a Widget (inner widget)
                      child: RaisedButton(

                        color: Colors.blue,
                        // There's no return for functions when in flutter
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          textAlign: TextAlign.right, // It doesn't work by itself
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Rock Salt",
                          ),
                        ),
                      )
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center, // It doesn't work by itself
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Rock Salt",
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}

