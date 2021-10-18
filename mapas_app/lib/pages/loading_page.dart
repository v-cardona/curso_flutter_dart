import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // funciona si el usuario sale hasta los ajustes, pero si lo activa por barra de notificaciones no sirve
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
        future: checkGpsLocation(context),
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    // comprobar si permiso gps
    // seria mejor disparar los future await de manera simultanea
    final permisoGps = await Permission.location.isGranted;
    // gps activo?
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    if (permisoGps && gpsActive) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
    } else if (!permisoGps) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGPSPage()));
      // devuelve data que sera la que se printee en el texto centrado
      return 'Es necesario el permiso de GPS';
    } else if (!gpsActive) {
      return 'Active el gps';
    }
  }
}
