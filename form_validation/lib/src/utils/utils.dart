
import 'package:flutter/material.dart';

bool isNumeric(String valor) {
  if (valor.isEmpty) {
    return false;
  }
  final number = num.tryParse(valor);
  return number != null;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Informacion incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=>Navigator.of(context).pop(),
            child: Text('OK')
          )
        ],
      );
    }  
  );
}