import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '96ee527533c7127403f2ebee7c85cd7c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas= new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

}