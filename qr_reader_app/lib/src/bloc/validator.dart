//crear clase con propiedades para añadir al scanBloc

import 'dart:async';

import 'package:qr_reader_app/src/models/scan_model.dart';

class Validators {

  
  final validarGeo = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    // no es el mismo sink del scanBloc
    handleData: (scans, sink) {
      //scans es lo que entra y sink lo que sale
      final geoScans = scans.where((s) {
        return s.tipo == 'geo';
      }).toList();

      sink.add(geoScans);
    }
  );

  
  final validarHttp = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    // no es el mismo sink del scanBloc
    handleData: (scans, sink) {
      //scans es lo que entra y sink lo que sale
      final httpScans = scans.where((s) {
        return s.tipo == 'http';
      }).toList();

      sink.add(httpScans);
    }
  );
}