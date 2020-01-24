import 'package:flutter/material.dart';
import 'package:preferencias_usuario/src/pages/home_page.dart';
import 'package:preferencias_usuario/src/pages/settings_page.dart';
import 'package:preferencias_usuario/src/share_preferences/preferencias_usuario.dart';
 
void main() async {
  //esta primera linea es necesaria cuando se hace un metodo asincrono en el main
  WidgetsFlutterBinding.ensureInitialized();
  //cargar las prefererncias, no se puede haceer en otro sitio porque se inicializaria a null, aqui, es lo primero 
  //que lanza y todo ok
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return MaterialApp(
      title: 'Preferencias',
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routeName : (BuildContext context) => HomePage(),
        SettingsPage.routeName : (BuildContext context) => SettingsPage(),
      },
    );
  }
}