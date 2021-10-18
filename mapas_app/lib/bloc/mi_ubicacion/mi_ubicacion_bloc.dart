import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  late StreamSubscription<Position> _positionSubscription;

  MiUbicacionBloc() : super(MiUbicacionState()) {
    on<OnUbicacionCambio>((event, emit) {
      emit(state.copyWith(ubicacion: event.ubicacion, existeUbicacion: true));
    });
  }

  // suscribirse al stream de la posicion gps
  void iniciarSeguimiento() {
    // almacenar el stream para poder cancelarlo al finalizar
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((position) {
      print(position);
      add(OnUbicacionCambio(LatLng(position.latitude, position.longitude)));
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription.cancel();
  }
}
