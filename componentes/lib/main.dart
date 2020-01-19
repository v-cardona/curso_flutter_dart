import 'package:flutter/material.dart';
import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/routes/routes.dart';

//import 'package:componentes/src/pages/home_temp.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      //si la ruta no esta definida arriba va a este de abajo
      onGenerateRoute: ( settings) {
        return MaterialPageRoute(
          builder: (context) => AlertPage()
        );
      },
    );
  }
}
