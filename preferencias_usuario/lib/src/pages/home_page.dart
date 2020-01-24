import 'package:flutter/material.dart';
import 'package:preferencias_usuario/src/share_preferences/preferencias_usuario.dart';
import 'package:preferencias_usuario/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de usuario'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color Secundario: ' + prefs.colorSecundario.toString()),
          Divider(),
          Text('Genero: ' + prefs.genero.toString()),
          Divider(),
          Text('Nombre de usuario: ' + prefs.nombreUsuario),
          Divider(),
        ],
      ),
    );
  }

}