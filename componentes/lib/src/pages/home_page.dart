
import 'package:componentes/src/pages/alert_page.dart';
import 'package:flutter/material.dart';

import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Componentes'),
        ),
        body: _lista(),
      ),
    );
  }

  Widget _lista() {

    // no recomendable porque puede tardar mucho y se ve congelada la app
    // menuProvider.cargarData().then( (opciones) {
    //   print('_lista');
    //   print(opciones);
    // });


    // return ListView(
    //   children: _listaItems(),
    // );


    return FutureBuilder(
      future: menuProvider.cargarData(),
      //opcional, pero con eso ya no se enviara null al metodo _listaItems
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        print(snapshot.data);
        return ListView(
          children: _listaItems(snapshot.data, context),
        );

      },
    );
  }

  _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    // se puede obviar fijando que la initialData sea [] en el metodo superior
    // if ( data == null) {
    //   return [];
    // }

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
        onTap: () { //para navegar entre pantallas
          //forma tradicional
          // final route = MaterialPageRoute(
          //   builder: (context) => AlertPage()
          // );
          // // el contexto se obtiene del builder de la funcion _lista
          // //podria cogerse del build principal y pasarlo directamente
          // Navigator.push(context, route);

          //otra forma, con nombre. Se indican las rutas en el main
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones.add(widgetTemp);
      opciones.add(Divider());
    });

    return opciones;
  }
}