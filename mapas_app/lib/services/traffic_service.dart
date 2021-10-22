import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/helpers/debouncer.dart';
import 'package:mapas_app/models/search_response.dart';
import 'package:mapas_app/models/traffic_response.dart';

class TrafficService {
  // singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer =
      Debouncer<String>(duration: const Duration(milliseconds: 500));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream =>
      _sugerenciasStreamController.stream;

  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoiYXN0YXJvdGg3IiwiYSI6ImNrdXpubDA0bjM2NWYydXM3ZXRyYzk4ZHkifQ.2l4S2fLer5V6z2Xgni9fFw';

  Future<DrivingResponse> getCoordsInicioYFin(
      LatLng inicio, LatLng destino) async {
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '$_baseUrl/mapbox/driving/$coordString';

    final resp = await _dio.get(
      url,
      queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'steps': 'false',
        'access_token': _apiKey,
        'language': 'es',
      },
    );
    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

  Future<SearchResponse> getResultadosPorQuery(
      String busqueda, LatLng proximidad) async {
    final url = '$_baseUrlGeo/mapbox.places/$busqueda.json';

    try {
      final resp = await _dio.get(
        url,
        queryParameters: {
          'access_token': _apiKey,
          'autocomplete': 'true',
          'proximity': '${proximidad.longitude},${proximidad.latitude}',
          'language': 'es',
        },
      );

      final searchResponse = searchResponseFromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await getResultadosPorQuery(value, proximidad);
      _sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(const Duration(milliseconds: 201))
        .then((_) => timer.cancel());
  }
}
