part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;
  final List<SearchResult> historial;

  const BusquedaState({
    this.seleccionManual = false,
    this.historial = const [],
  });

  BusquedaState copyWith({
    bool? seleccionManual,
    List<SearchResult>? historial,
  }) {
    return BusquedaState(
      seleccionManual: seleccionManual ?? this.seleccionManual,
      historial: historial ?? this.historial,
    );
  }
}
