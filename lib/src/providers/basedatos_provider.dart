import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:proyectomapasqssqlite/src/modelos/scan_model.dart';
export 'package:proyectomapasqssqlite/src/modelos/scan_model.dart';

class BaseDatoProvider {
  // va serimplementado en patron singletone
  // para tener una sola instacia de basedatos global en la app
  static Database _database;

  static final BaseDatoProvider bd = BaseDatoProvider._();

  BaseDatoProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    // si es nula hay que crear la base datos

    _database = await initBD();

    return _database;
  }

  initBD() async {
    // definimos el path
    Directory directorioBaseDatos = await getApplicationDocumentsDirectory();

    final path = join(directorioBaseDatos.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (bd) {},
        onCreate: (Database bd, int version) async {
      // vamos crear las base datos
      await bd.execute('CREATE TABLE Scan ('
          ' id INTEGER PRIMARY KEY , '
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  // CREAR Registros
// tipo uno de incluir registro sqlite
  nuevoScanFila(ScanModel nuevoScan) async {
    final bd = await database;

    final filaInsertada = await bd.rawInsert(
        "INSERT Into Scan (id, tipo, valor) "
        "VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' ) ");

    return filaInsertada;
  }

  // tipo 2

  nuevoScan(ScanModel nuevoScan) async {
    final bd = await database;

    final res = await bd.insert('Scan', nuevoScan.toJson());

    return res;
  }

  // SELECT - obtener informacion
  Future<ScanModel> getScanId(int id) async {
    final db = await database;

    final res = await db.query('Scan', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScan() async {
    final db = await database;

    final res = await db.query('Scan');

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getScanPorTipo(String tipo) async {
    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scan WHERE tipo ='$tipo");

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];

    return list;
  }

  // UPDATE - Actulizar Registro
  Future<int> actulizarScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.update('Scan', nuevoScan.toJson(),
        where: 'id= ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  // DELETE -eliminar registro

  Future<int> eliminarScan(int id) async {
    final db  = await database;

    final res = await db.delete('Scan', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> eliminarTodosScan() async {
    final db  = await database;

    final res = await db.rawDelete('DELETE FROM Scan');

    return res;
  }
}
