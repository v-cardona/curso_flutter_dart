

import 'dart:async';

import 'package:qr_reader_app/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //obtener los scans de la db
    obtenerScans();
  }  

  Stream<List<ScanModel>> get scansStream => _scansController.stream;


  dispose() {
    _scansController?.close();
  }


  // obtener info de todos los scans
  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
    // este de abajo es equivalente, porque se ha eliminado todo
    // _scansController.sink.add([]);
  }

}

