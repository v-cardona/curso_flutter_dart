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

// hacer un toogle de si se sigue la ubiacion de recorrido con la camara centrada
class OnSeguirUbicacion extends MapaEvent {}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;

  OnMovioMapa(this.centroMapa);
}

class OnCrearRutaInicioDestino extends MapaEvent {
  final List<LatLng> rutaCoordenas;
  final double distancia;
  final double duracion;

  OnCrearRutaInicioDestino(this.rutaCoordenas, this.distancia, this.duracion);
}
