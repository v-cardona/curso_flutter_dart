import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/models/search_response.dart';
import 'package:mapas_app/models/search_result.dart';
import 'package:mapas_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestination({
    required this.proximidad,
  })  : searchFieldLabel = 'Buscar...',
        _trafficService = TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final searchResult = SearchResult(cancelo: true);

    return IconButton(
      onPressed: () {
        close(context, searchResult);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Colocar ubicacion manualmente'),
            onTap: () {
              close(
                  context,
                  SearchResult(
                    cancelo: false,
                    manual: true,
                  ));
            },
          ),
        ],
      );
    } else {
      return _construirResultadosSugerencias();
    }
  }

  Widget _construirResultadosSugerencias() {
    if (query.trim().isEmpty) return Container();

    _trafficService.getSugerenciasPorQuery(query.trim(), proximidad);

    return StreamBuilder(
      stream: _trafficService.sugerenciasStream,
      builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final lugares = snapshot.data?.features;

        if (lugares?.isEmpty ?? true) {
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: lugares?.length ?? 0,
          itemBuilder: (context, index) {
            final lugar = lugares?[index];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar?.textEs ?? ''),
              subtitle: Text(lugar?.placeNameEs ?? ''),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
