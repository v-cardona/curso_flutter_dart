import 'dart:math';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _titulos(),
                  _botonesRedondeados(),
                ],
              ),
            )
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   fixedColor: Colors.pink,
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       title: Container(),
        //       icon: Icon(Icons.calendar_today)
        //     ),
        //     BottomNavigationBarItem(
        //       title: Container(),
        //       icon: Icon(Icons.pie_chart_outlined)
        //     ),BottomNavigationBarItem(
        //       title: Container(),
        //       icon: Icon(Icons.supervised_user_circle)
        //     ),
        //   ],
        // ),
        bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0, 0.6),
          end: FractionalOffset(0, 1),
          colors: [
            Color.fromRGBO(52, 54, 101, 1),
            Color.fromRGBO(35, 37, 57, 1)
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: - pi / 5,
      child: Container(
        height: 360,
        width: 360,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236 , 98, 188, 1),
              Color.fromRGBO(241 , 142, 172, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(80)
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100,
          child: cajaRosa
        )
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Classify transaction', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('Classify this transaction into a particulary category',style: TextStyle(color: Colors.white, fontSize: 18,),),
          ],
        ),
      ),
    );

  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1))
        )
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30,),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30,),
            title: Container()
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.border_all, 'General'),
            _crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus, 'Bus'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.pinkAccent, Icons.shop, 'Buy'),
            _crearBotonRedondeado(Colors.orange, Icons.insert_drive_file, 'File'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blueAccent, Icons.movie_filter, 'Enterteinment'),
            _crearBotonRedondeado(Colors.green, Icons.cloud, 'Grocery'),
          ],
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.red, Icons.collections, 'Fotos'),
            _crearBotonRedondeado(Colors.teal, Icons.help_outline, 'General'),
          ],
        ),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icon, String texto) {
    return Container(
      height: 180,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 5,),
          CircleAvatar(
            backgroundColor: color,
            radius: 35,
            child: Icon(icon, color: Colors.white, size: 30,),
          ),
          Text(texto,style: TextStyle(color: color),),
          SizedBox(height: 5,)
        ],
      ),
    );
  }

}