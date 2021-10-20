import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancelo;
  final bool manual;
  final LatLng position;
  final String nombreDestino;
  final String descripcion;

  SearchResult({
    required this.cancelo,
    this.manual = false,
    this.position = const LatLng(0, 0),
    this.nombreDestino = '',
    this.descripcion = '',
  });
}
