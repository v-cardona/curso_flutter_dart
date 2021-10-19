part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;

  const MapaState({
    this.mapaListo = false,
  }); // si el mapa esta listo para usar

  MapaState copyWith({
    bool? mapaListo,
  }) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
      );
}
