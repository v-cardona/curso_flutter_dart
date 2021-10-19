part of 'mapa_bloc.dart';

@immutable
class MapaState {
  // si el mapa esta listo para usar
  final bool mapaListo;
  // si quiere el usuario ver la polilinea dibujada (aunque se almacena siempre)
  final bool dibujarRecorrido;
  // si quiere el usuario seguir la ubicacion con la camara centrada
  final bool seguirUbicacion;

  //polylines
  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    this.seguirUbicacion = false,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? {};

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? seguirUbicacion,
    Map<String, Polyline>? polylines,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        polylines: polylines ?? this.polylines,
      );
}
