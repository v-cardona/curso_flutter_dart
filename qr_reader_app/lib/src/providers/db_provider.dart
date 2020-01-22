import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._private();
  
  DBProvider._private();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // solo se ejecuta si no exite la base de datos
    _database = await initDB();
    return _database;
  
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        //aqui ya se tiene creada la base de datos
        //crear las tablas
        await db.execute(
          'CREATE TABLE Scans('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }

  //CREAR registros
  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES (${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}')"
    );
    return res;
  }

  //otra forma de insercion mas facil y con menos probabilidad de error
  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = db.insert('Scans', nuevoScan.toJson());
    return res;
  }

}