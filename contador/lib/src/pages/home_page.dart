
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  final estiloTexto = new TextStyle(fontSize: 25);
  final conteo = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Numero de clicks:', style: estiloTexto),
            Text('$conteo', style: estiloTexto,),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // con un null se desactiva el boton, no hace el efecto de material
        onPressed: () {
          //conteo = conteo + 1;
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
