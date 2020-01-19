

import 'package:flutter/material.dart';

// diccionario
final _icons = <String,IconData> {
  'add_alert'     : Icons.add_alert,
  'accessibility' : Icons.accessible,
  'folder_open'   : Icons.folder_open,
  'donut_large'   : Icons.donut_large,
  'input'         : Icons.input,
  'list'          : Icons.list,
  'tune'          : Icons.tune,
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.blue,);
}
