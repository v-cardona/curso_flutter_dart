import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/models/traffic_response.dart';

class TrafficService {
  // singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
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
}
