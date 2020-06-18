

import 'dart:async';

import 'package:proyectomapasqssqlite/src/providers/basedatos_provider.dart';

class ScansBloc {

  // patron singletone
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal(){
  
    // Obtener los Scans de la base datos
    obtenerScans();
  }

  // crear el flujo dedatos
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;


  dispose(){
    _scansController?.close();
  }

  obtenerScans() async {

    _scansController.sink.add(await BaseDatoProvider.bd.getTodosScan());

  }

  agregarScan(ScanModel scan) async {

    await BaseDatoProvider.bd.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await BaseDatoProvider.bd.eliminarScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {

    await BaseDatoProvider.bd.eliminarTodosScan();
    //  puede usar asi o de  la forma de abajo _scansController.sink.add([]);
    obtenerScans();
  }


}
