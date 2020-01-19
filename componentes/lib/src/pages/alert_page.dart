import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Alert Page'),
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
}