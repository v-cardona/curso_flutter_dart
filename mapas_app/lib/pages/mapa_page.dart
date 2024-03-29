import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/widgets/widgets.dart';

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
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state) {
              return crearMapa(state);
            },
          ),
          const Positioned(
            top: 15,
            child: SearchBar(),
          ),
          MarcadorManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return const Center(child: Text('Ubicando...'));
    }

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    // cada vez que se recibe una nueva ubicacion se envia el evento
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition = CameraPosition(
      target: state.ubicacion,
      zoom: 15,
    );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (mapController) {
            mapaBloc.initMapa(mapController);
          },
          polylines: mapaBloc.state.polylines.values.toSet(),
          markers: mapaBloc.state.marcadores.values.toSet(),
          onCameraMove: (cameraPosition) {
            LatLng centroMapa = cameraPosition.target;
            mapaBloc.add(OnMovioMapa(centroMapa));
          },
        );
      },
    );
  }
}
