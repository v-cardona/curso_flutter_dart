import 'package:flutter/material.dart';
import 'package:mapas_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  SearchDestination() : searchFieldLabel = 'Buscar...';

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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
  }
}
