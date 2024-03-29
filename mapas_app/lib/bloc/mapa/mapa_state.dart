part of 'mapa_bloc.dart';

@immutable
class MapaState {
  // si el mapa esta listo para usar
  final bool mapaListo;
  // si quiere el usuario ver la polilinea dibujada (aunque se almacena siempre)
  final bool dibujarRecorrido;
  // si quiere el usuario seguir la ubicacion con la camara centrada
  final bool seguirUbicacion;
  // se usa para recuperar la ubicacion final con el marcador manual
  final LatLng ubicacionCentral;

  //polylines
  final Map<String, Polyline> polylines;
  //marcadores
  final Map<String, Marker> marcadores;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.seguirUbicacion = false,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? marcadores,
  })  : polylines = polylines ?? {},
        marcadores = marcadores ?? {},
        ubicacionCentral = ubicacionCentral ?? const LatLng(0, 0);

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? seguirUbicacion,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? marcadores,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
        polylines: polylines ?? this.polylines,
        marcadores: marcadores ?? this.marcadores,
      );
}
