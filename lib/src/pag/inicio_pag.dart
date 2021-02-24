import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyectomapasqssqlite/src/bloc/scans_bloc.dart';
import 'package:proyectomapasqssqlite/src/modelos/scan_model.dart';
import 'package:proyectomapasqssqlite/src/pag/direcciones_pag.dart';
import 'package:proyectomapasqssqlite/src/pag/mapa_pag.dart';
import 'package:proyectomapasqssqlite/src/utils/scan_utils.dart' as utils;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:proyectomapasqssqlite/src/providers/basedatos_provider.dart';

// importacion para leer codigo qr codigo de barras
// import 'package:barcode_scan/barcode_scan.dart';

class InicioPag extends StatefulWidget {
  @override
  _InicioPagState createState() => _InicioPagState();
}

class _InicioPagState extends State<InicioPag> {
  // intanciar la clases scanBloc
  final scansBloc = new ScansBloc();

  int indexActual = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            /*
            onPressed: () {

              print("boton de borrar todo");
              scansBloc.borrarScanTodos();
            },
            */
            onPressed: scansBloc.borrarScanTodos,
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _llamarPag(indexActual),
      bottomNavigationBar: _crearBarraNavegacionBotones(),
      floatingActionButton: _crearBotonesFlotantes(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _crearBarraNavegacionBotones() {
    return BottomNavigationBar(
      currentIndex: indexActual,
      onTap: (index) {
        setState(() {
          indexActual = index;
        });
        print('cual clic $index');
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'mapas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_6), label:'Direcciones'),
      ],
    );
  }

  Widget _llamarPag(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPag();
      case 1:
        return DireccionesPag();

      default:
        return MapasPag();
    }
  }

  Widget _crearBotonesFlotantes() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed:()=> _scanQR(context),
      backgroundColor: Theme.of(context).accentColor,
      focusElevation: 10.0,
    );
  }

  //crear el metodo privado para leer QR
  _scanQR(BuildContext context) async {
    // print('pulsaste boton SCAN QR');
    //  https://fernando-herrera.com
    // geo:40.73255860802501,-73.89333143671877
    // geo:10.6016725,-67.0323396

    dynamic futureString2 = 'geo:10.6016725,-67.0323396';
    dynamic futureString = 'https://fernando-herrera.com';
/*
    try {
      futureString = await BarcodeScanner.scan();
      
    } catch (e) {
      futureString = e.toString();
    }

     print('pulsaste boton SCAN QR para leer-->');
     print(futureString.rawContent);
     print(futureString.type);
     print(futureString.format);
     print(futureString.formatNote);

*/
    if (futureString != null) {
      print('Tenemos Informacion');

      final scan = ScanModel(valor: futureString);
      // BaseDatoProvider.bd.nuevoScan(scan);
      scansBloc.agregarScan(scan);

       final scan2 = ScanModel(valor: futureString2);
       scansBloc.agregarScan(scan2);
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {

        utils.abrirScan(context, scan);

      }
    }
  }

// fin de la clases
}
