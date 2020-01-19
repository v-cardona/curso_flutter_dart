import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final opciones = ['uno', 'dos', 'tres','cuatro', 'cinco'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp'),
      ),
      body: ListView(
        //children: _crearItems()
        children: _crearItemsCorta()
      ),
    );
  }

  List<Widget> _crearItems() {
    
    // lista dinamica
    List<Widget> lista = new List<Widget>();

    for (String opt in opciones) {
      final tempWidget = ListTile(
        title: Text(opt),
      );
      //igual pero otra forma de sintaxis
      //lista..add(tempWidget)
      //    ..add(Divider());
      lista..add(tempWidget);
      lista.add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta() {
    var widgets = opciones.map((item) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('subtitulo'),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider()
        ],
      );
    }).toList();

    return widgets;
  }
}