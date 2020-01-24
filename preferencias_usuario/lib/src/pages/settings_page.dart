import 'package:flutter/material.dart';
import 'package:preferencias_usuario/src/share_preferences/preferencias_usuario.dart';
import 'package:preferencias_usuario/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;
  String _nombre;

  
  TextEditingController _textController;
  PreferenciasUsuario prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();

    prefs.ultimaPagina = SettingsPage.routeName;

    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _nombre = prefs.nombreUsuario;
    _textController = new TextEditingController(text: prefs.nombreUsuario);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Text('Settings', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            //se recibe un booleano
            onChanged: (value) {
              _colorSecundario = value;
              prefs.colorSecundario = value;
              setState(() {});
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            // recibe un entero
            onChanged: setSelectRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            // recibe un entero
            onChanged: setSelectRadio
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono'
              ),
              //se recibe string
              onChanged: (value) {
                prefs.nombreUsuario = value;
              },
            ),
          )
        ],
      )
    );
  }

  void setSelectRadio(int value) async {
    // //guardarlo en preferencias
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // se guarda como un diccionario
    // await prefs.setInt('genero', value);
    prefs.genero = value;
    _genero = value;
    setState(() {});
  }
}