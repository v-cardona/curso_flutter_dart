import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  // controlador del mapa
  late GoogleMapController _mapController;
  // polylines
  // ubicacion por donde se mueve el usuario
  Polyline _miRuta = const Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 4,
    color: Colors.transparent,
  );
  // ruta desde posicion del usuario hasta el destino
  Polyline _miRutaDestino = const Polyline(
    polylineId: PolylineId('mi_ruta_destino'),
    width: 4,
    color: Colors.black87,
  );

  MapaBloc() : super(MapaState()) {
    on<OnMapaListo>(_onMapaListo);
    on<OnNuevaUbicacion>(_onNuevaUbicacion);
    on<OnMarcarRecorrido>(_onMarcarRecorrido);
    on<OnSeguirUbicacion>(_onSeguirUbicacion);
    on<OnMovioMapa>(_onMovioMapa);
    on<OnCrearRutaInicioDestino>(_onCrearRutaInicioDestino);
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
    // si al recibir ubicacion esta activo el seguir al usuario, mover la camara
    if (state.seguirUbicacion) {
      moverCamara(event.ubicacion);
    }

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

  void _onSeguirUbicacion(OnSeguirUbicacion event, Emitter<MapaState> emit) {
    // si esta en false, significa que quiere seguirla ahora
    if (!state.seguirUbicacion) {
      // forzar el mover camara para no esperar a la siguiente ubicacion
      // que ya se tiene en la ruta
      moverCamara(_miRuta.points[_miRuta.points.length - 1]);
    }

    emit(state.copyWith(
      seguirUbicacion: !state.seguirUbicacion,
    ));
  }

  void _onMovioMapa(OnMovioMapa event, Emitter<MapaState> emit) {
    emit(state.copyWith(
      ubicacionCentral: event.centroMapa,
    ));
  }

  void _onCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event, Emitter<MapaState> emit) async {
    _miRutaDestino = _miRutaDestino.copyWith(pointsParam: event.rutaCoordenas);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = _miRutaDestino;

    // marcadores
    //icono inicio
    //final iconInicio = await getAssetImageMarker();
    final iconInicio = await getMarkerInicioIcon(event.duracion.toInt());
    final markerInicio = Marker(
      markerId: const MarkerId('inicio'),
      position: event.rutaCoordenas[0],
      icon: iconInicio,
      anchor: Offset(0.0, 1.0),
      infoWindow: InfoWindow(
        title: 'Mi ubicacion',
        snippet: 'Duracion recorrido: ${(event.duracion / 60).floor()} minutos',
      ),
    );
    //final iconDestino = await getNetworkImageMarker();
    final iconDestino =
        await getMarkerDestinoIcon(event.nombreDestino, event.distancia);
    final double km = (event.distancia / 1000).floor().toDouble();
    final markerDestino = Marker(
      markerId: const MarkerId('destino'),
      position: event.rutaCoordenas[event.rutaCoordenas.length - 1],
      icon: iconDestino,
      anchor: Offset(0.0, 1.0),
      infoWindow: InfoWindow(
        title: event.nombreDestino,
        snippet: 'Distancia: $km km',
      ),
    );
    // copia de los marcadores actuales
    final newMarkers = {...state.marcadores};
    newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerDestino;

    // abrir el info window, se realiza un delay porque se necesita que el
    //marcador alla sido añadido en el mapa y acceder con su controlador,
    //eso lo hara en la instruccion siguiente al emitir el estado
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _mapController.showMarkerInfoWindow(const MarkerId('destino'));
    });

    emit(state.copyWith(
      polylines: currentPolylines,
      marcadores: newMarkers,
    ));
  }
}
