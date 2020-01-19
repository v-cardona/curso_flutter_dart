import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Alert Page'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('mostrar alerta'),
            //como se tiene que enviar parametros debe ser la funcion asi
            onPressed: () =>_mostrarAlert(context),
            color: Colors.blue,
            shape: StadiumBorder(),
          ),
        ),
        //boton flotatne para regresar a la pantalla anterior ( a mano)
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      //cerrar la alerta dando click afuera
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Titulo'),
          content: Column(
            // se adapta al contendio que hay dentro
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('contenido de la caja de la alerta'),
              FlutterLogo(size: 100),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {},
            ),
          ],
        );
      }
    );
  }
}