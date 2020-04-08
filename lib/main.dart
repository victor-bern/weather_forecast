import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:weather/previsao.dart';

void main() async {
  runApp(MaterialApp(
      title: 'Weather', debugShowCheckedModeBanner: false, home: Home1()));
}

final cepController = TextEditingController();
final localController = TextEditingController();
final ufController = TextEditingController();

Future<Map> getCep(String cepCoiso) async {
  String cep = 'viacep.com.br/ws/$cepCoiso/json/';
  http.Response request = await http.get(cep);
  return json.decode(request.body);
}

Future<Map> getLocal(String local, String uf) async {
  String request =
      'https://api.hgbrasil.com/weather?key=8101973ac&city_name=$local,$uf';

  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather Today'),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  localController.text = '';
                  ufController.text = '';
                })
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        labelStyle:
                            TextStyle(color: Colors.lightBlue, fontSize: 25),
                        border: OutlineInputBorder(),
                      ),
                      controller: localController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite a Cidade';
                        }
                      },
                    ),
                    Divider(),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'UF',
                            labelStyle: TextStyle(
                                color: Colors.lightBlue, fontSize: 25),
                            border: OutlineInputBorder()),
                        controller: ufController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Digite o UF';
                          }
                        }),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home2()));
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
