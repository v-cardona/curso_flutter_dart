part of 'mapa_bloc.dart';

@immutable
class MapaState {
  // si el mapa esta listo para usar
  final bool mapaListo;
  final bool dibujarRecorrido;

  //polylines
  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? {};

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    Map<String, Polyline>? polylines,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        polylines: polylines ?? this.polylines,
      );
}
