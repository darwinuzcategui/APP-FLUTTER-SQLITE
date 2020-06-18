import 'package:flutter/material.dart';
import 'package:proyectomapasqssqlite/src/pag/desplegar_mapa.dart';
import 'package:proyectomapasqssqlite/src/pag/inicio_pag.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Lectura Qr',
      initialRoute: 'inicio',
      routes: {
        'inicio': (BuildContext context) =>InicioPag(),
        'unmapa': (BuildContext context) =>MapaPage(),
      }, 
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor:Colors.amberAccent 
        ),
    );
  }
}