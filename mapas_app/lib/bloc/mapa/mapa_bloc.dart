import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  late GoogleMapController _mapController;

  MapaBloc() : super(MapaState()) {
    on<OnMapaListo>((event, emit) {
      emit(state.copyWith(mapaListo: true));
    });
  }

  void initMapa(GoogleMapController controller) {
    // añadir el controlador si no esta listo
    // por si se volviera a llamar
    if (!state.mapaListo) {
      _mapController = controller;

      // TODO cambiar el estilo del mapa

      // evento de mapa ya listo
      add(OnMapaListo());
    }
  }
}