import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (context, state) {
          return crearMapa(state);
        },
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return const Center(child: Text('Ubicando...'));
    }

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final cameraPosition = CameraPosition(
      target: state.ubicacion,
      zoom: 15,
    );
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (mapController) {
        mapaBloc.initMapa(mapController);
      },
    );
  }
}
