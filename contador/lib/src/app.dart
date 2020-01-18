import 'package:flutter/material.dart';
import 'package:contador/src/pages/contador_page.dart';
import 'package:contador/src/pages/home_page.dart';

//wideget 
class MyApp extends StatelessWidget {
  
  //sobrescribir este metodo, el contexto es el arbol de widgets
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        //child: HomePage(),
        child: ContadorPage(),
      )
      ,
    );
  }
}