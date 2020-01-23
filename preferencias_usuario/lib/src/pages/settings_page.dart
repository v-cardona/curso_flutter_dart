import 'package:flutter/material.dart';
import 'package:preferencias_usuario/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario = true;
  int _genero = 1;
  String _nombre = 'Pedro';

  
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    cargarPref();
    _textController = new TextEditingController(text: _nombre);

  }

  cargarPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _genero = prefs.getInt('genero');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
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
              onChanged: (value) {},
            ),
          )
        ],
      )
    );
  }

  void setSelectRadio(int value) async {
    //guardarlo en preferencias
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // se guarda como un diccionario
    await prefs.setInt('genero', value);

    _genero = value;
    setState(() {});
  }
}