part of 'mapa_bloc.dart';

@immutable
class MapaState {
  // si el mapa esta listo para usar
  final bool mapaListo;
  // si quiere el usuario ver la polilinea dibujada (aunque se almacena siempre)
  final bool dibujarRecorrido;
  // si quiere el usuario seguir la ubicacion con la camara centrada
  final bool seguirUbicacion;

  final LatLng ubicacionCentral;

  //polylines
  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.seguirUbicacion = false,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
  })  : polylines = polylines ?? {},
        ubicacionCentral = ubicacionCentral ?? const LatLng(0, 0);

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? seguirUbicacion,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
        polylines: polylines ?? this.polylines,
      );
}
