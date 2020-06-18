import 'package:flutter/material.dart';
import 'package:proyectomapasqssqlite/src/modelos/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

/*
http:<URL> , https:<URL>, e.g. http://flutter.dev	Open URL in the default browser
mailto:<email address>?subject=<subject>&body=<body>, e.g. mailto:smith@example.org?subject=News&body=New%20plugin	Create email to
tel:<phone number>, e.g. tel:+1 555 010 999	Make a phone call to
sms:<phone number>, e.g. sms:5550101234
*/
abrirScan(BuildContext context, ScanModel scan) async {
  print(scan.tipo);
  if (scan.tipo == 'http') {
    // String url = scan.valor;
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'No se Pudo Lanzar la Direccion  ${scan.valor}';
    }
  } else {
    print("GEO....");
    Navigator.pushNamed(context, 'unmapa',arguments: scan);
  }
}
