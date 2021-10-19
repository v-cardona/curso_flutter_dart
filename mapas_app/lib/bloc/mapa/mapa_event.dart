part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

// cuando el mapa este listo
class OnMapaListo extends MapaEvent {}

// cada vez que se obtiene una nueva localizacion del usuario
class OnNuevaUbicacion extends MapaEvent {
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);
}

// hacer un toogle de si se dibuja el recorrido que esta realizando el usuario
class OnMarcarRecorrido extends MapaEvent {}
