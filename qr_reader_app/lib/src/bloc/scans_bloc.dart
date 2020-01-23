

import 'dart:async';

import 'package:qr_reader_app/src/bloc/validator.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

//esta clase tiene las cosas de validatos
class ScansBloc with Validators{
  static final ScansBloc _singleton = new ScansBloc._internal();
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //obtener los scans de la db
    obtenerScans();
  }  

  //para geo, con el transform que valida solo los scan de geo, que se ha definido en validatos
  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  //para http
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);




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

