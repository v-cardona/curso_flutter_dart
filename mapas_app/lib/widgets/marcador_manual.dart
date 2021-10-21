part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context)
                      .add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: const Icon(Icons.location_on, size: 50),
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: const Text('Confirmar destino',
                  style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                calcularDestino(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    final trafficService = TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral;

    // obtener las direcciones
    final trafficResponse =
        await trafficService.getCoordsInicioYFin(inicio, destino);
    // recuperar solo la primera ruta
    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;
    // decodificar los puntos del geometry para crear la polyline
    final points = Poly.Polyline.Decode(
      encodedString: geometry,
      precision: 6, // precision 6 de codificacion
    ).decodedCoords;
  }
}
