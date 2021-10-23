import 'package:bloc/bloc.dart';
import 'package:mapas_app/models/search_result.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState()) {
    on<OnActivarMarcadorManual>((event, emit) {
      emit(state.copyWith(seleccionManual: true));
    });
    on<OnDesactivarMarcadorManual>((event, emit) {
      emit(state.copyWith(seleccionManual: false));
    });
    on<OnAgregarHistorial>((event, emit) {
      // comprobar si ya existe
      final existe = state.historial
          .where(
              (result) => result.nombreDestino == event.resultado.nombreDestino)
          .length;
      // si no existe lo añade
      if (existe == 0) {
        final newHistorial = [...state.historial, event.resultado];
        emit(state.copyWith(historial: newHistorial));
      }
    });
  }
}
