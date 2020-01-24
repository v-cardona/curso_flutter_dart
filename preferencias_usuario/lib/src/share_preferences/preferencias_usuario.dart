
import 'package:preferencias_usuario/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  // bool _colorSecundario;
  // int _genero;
  // String _nombre;

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // get y set de genero
  get genero {
    // si no exite se le asigna un 1 , eso es l operador ??
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  // get y set de color secundario
  get colorSecundario {
    // si no exite se le asigna un 1 , eso es l operador ??
    return _prefs.getBool('color') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('color', value);
  }

  // get y set de genero
  get nombreUsuario {
    // si no exite se le asigna un 1 , eso es l operador ??
    return _prefs.getString('nombre') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombre', value);
  }

  // get y set de genero
  get ultimaPagina {
    // si no exite se le asigna un 1 , eso es l operador ??
    return _prefs.getString('ultimaPagina') ?? HomePage.routeName;
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}


