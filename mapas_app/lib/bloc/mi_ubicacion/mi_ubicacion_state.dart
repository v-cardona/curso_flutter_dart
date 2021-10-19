part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng ubicacion;

  const MiUbicacionState({
    this.siguiendo = true,
    this.existeUbicacion = false,
    required this.ubicacion,
  });

  MiUbicacionState copyWith({
    bool? siguiendo,
    bool? existeUbicacion,
    LatLng? ubicacion,
  }) {
    return MiUbicacionState(
        existeUbicacion: existeUbicacion ?? this.existeUbicacion,
        siguiendo: siguiendo ?? this.siguiendo,
        ubicacion: ubicacion ?? this.ubicacion);
  }
}
