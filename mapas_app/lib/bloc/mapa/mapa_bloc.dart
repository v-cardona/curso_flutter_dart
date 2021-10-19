import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  // controlador del mapa
  late GoogleMapController _mapController;
  // polylines
  Polyline _miRuta = const Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 4,
    color: Colors.black87,
  );

  MapaBloc() : super(MapaState()) {
    on<OnMapaListo>(_onMapaListo);
    on<OnNuevaUbicacion>(_onNuevaUbicacion);
    on<OnMarcarRecorrido>(_onMarcarRecorrido);
  }

  void initMapa(GoogleMapController controller) {
    // añadir el controlador si no esta listo
    // por si se volviera a llamar
    if (!state.mapaListo) {
      _mapController = controller;
      // cambiar el estilo del mapa
      controller.setMapStyle(jsonEncode(uberMapTheme));

      // evento de mapa ya listo
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    _mapController.animateCamera(cameraUpdate);
  }

  void _onMapaListo(OnMapaListo event, Emitter<MapaState> emit) {
    emit(state.copyWith(mapaListo: true));
  }

  void _onNuevaUbicacion(OnNuevaUbicacion event, Emitter<MapaState> emit) {
    // una copia nueva
    List<LatLng> points = [..._miRuta.points, event.ubicacion];
    // asignarla a la polyline
    _miRuta = _miRuta.copyWith(pointsParam: points);

    // recuperar la polylinea del estado y sobreescribir con el nuevo punto añadido
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _onMarcarRecorrido(OnMarcarRecorrido event, Emitter<MapaState> emit) {
    if (!state.dibujarRecorrido) {
      _miRuta = _miRuta.copyWith(colorParam: Colors.black87);
    } else {
      _miRuta = _miRuta.copyWith(colorParam: Colors.transparent);
    }

    // recuperar la polylinea del estado y sobreescribir con el nuevo punto añadido
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miRuta;

    emit(state.copyWith(
      polylines: currentPolylines,
      dibujarRecorrido: !state.dibujarRecorrido,
    ));
  }
}
