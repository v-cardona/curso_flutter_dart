import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate{

  final peliculas = ['spiderman','aquaman','batman','shazam','ironman','CapitanAmerica'];

  final peliculasRecientes = ['Spiderman', 'CapitanAmerica'];
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }


  //no lo usamos porque te lo muestra en ese espacio, y queremos mostrarlo en la pagina detalle
  @override
  Widget buildResults(BuildContext context) {
    // // crea los resultados que se muestran
    // return Center(
    //   child: Container(
    //     height: 100,
    //     width: 100,
    //     color: Colors.blueAccent,
    //     child: Text(seleccion),
    //   ),
    // );
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando la persna escribe

    // final listaSugerida = (query.isEmpty) ? peliculasRecientes : peliculas.where((pelicula) {
    //   return pelicula.toLowerCase().startsWith(query.toLowerCase());
    // }).toList();


    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listaSugerida[index]),
    //       onTap: () {
    //         seleccion = listaSugerida[index];
    //         //para construir los resultados
    //         showResults(context);
    //       },
    //     );
    //   },
    // );

    if (query.isEmpty) {
      return Container();
    } 

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext ckontext, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '${pelicula.id}-busqueda';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

}