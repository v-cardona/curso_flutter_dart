part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapaBloc, MapaState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                mapaBloc.add(OnSeguirUbicacion());
              },
              icon: mapaBloc.state.seguirUbicacion
                  ? const Icon(
                      Icons.directions_run,
                      color: Colors.black87,
                    )
                  : const Icon(
                      Icons.accessibility_new,
                      color: Colors.black87,
                    ),
            );
          },
        ),
      ),
    );
  }
}
