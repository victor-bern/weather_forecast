import 'package:flutter/material.dart';
import 'package:weather/main.dart';



class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int currentTemp;
  int maxTemp;
  int minTemp;
  int humidity;
  String localeCity;
  String description;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLocal(localController.text, ufController.text),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                msgError();
              } else {
                maxTemp = snapshot.data['results']['forecast'][0]['max'];
                minTemp = snapshot.data['results']['forecast'][0]['min'];
                currentTemp = snapshot.data['results']['temp'];
                humidity = snapshot.data['results']['humidity'];
                description =
                    snapshot.data['results']['forecast'][0]['description'];
                localeCity = snapshot.data['results']['city'];

                return Scaffold(
                  appBar: AppBar(
                    title: Text('Previsão de $localeCity :)'),
                    centerTitle: true,
                    backgroundColor: Colors.cyanAccent,
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          'Previsão de Hoje!',
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.cloud_queue,
                                  color: Colors.orangeAccent,
                                  size: 60,
                                ),
                                Text(
                                  '$currentTemp°',
                                  style: TextStyle(
                                      color: Colors.orangeAccent, fontSize: 60),
                                ),
                              ])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$minTemp°',
                            style: TextStyle(
                                fontSize: 25, color: Colors.lightBlueAccent),
                          ),
                          Text('/ $maxTemp°',
                              style: TextStyle(
                                  fontSize: 25, color: Colors.redAccent)),
                          Divider(),
                          Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.brightness_high,
                                  size: 30,
                                ),
                                Text(
                                  '$humidity',
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
          }
        });
  }
}

Widget waitMsg() {
  return Scaffold(
      body: Container(
    margin: EdgeInsets.only(top: 250.0),
    child: Text(
      'Carregando os Dados...',
      style: TextStyle(fontSize: 40, color: Colors.lightGreen),
      textAlign: TextAlign.center,
    ),
  ));
}

Widget msgError() {
  return Scaffold(
      body: Container(
    margin: EdgeInsets.only(top: 60.0),
    child: Text(
      'Houve um erro...',
      style: TextStyle(fontSize: 40, color: Colors.lightGreen),
      textAlign: TextAlign.center,
    ),
  ));
}
