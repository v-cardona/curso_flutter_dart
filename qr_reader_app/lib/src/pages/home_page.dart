import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:qr_reader_app/src/pages/direcciones_page.dart';
import 'package:qr_reader_app/src/pages/mapas_page.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  final scansBloc = new ScansBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScansTodos
          )
        ],
      ),
      body: _callPage(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {
          _scanQR(context);
        },  
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
        });
        currentIndex = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  void _scanQR (BuildContext context) async {

    // https://fernando-herrera.com
    // geo:40.724233047051705,-74.00731459101564

    String futureString = 'https://fernando-herrera.com'; 

    // try {
    // futureString = await new QRCodeReader().scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      
      final scan2 = ScanModel(valor: 'geo:40.724233047051705,-74.00731459101564');
      scansBloc.agregarScan(scan2);

      // es ios da un problema de que llega antes la solucion que el intetno de abrir
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), utils.abrirScan(context, scan));
      } else {
        utils.abrirScan(context, scan);
      }

    }
  }
}