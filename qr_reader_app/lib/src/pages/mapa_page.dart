import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  MapController mapController = new MapController();
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapController.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}'
      ,
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoiYXN0YXJvdGg3IiwiYSI6ImNrNXF3eXY1NDA2bDQzZ3BiajVvZWRyOTIifQ.D7a4uLAAE53JOf0_9RoheQ',
        //tipos de id para los mapas : streets,dark,light, outdoors, satellite
        'id' : 'mapbox.$tipoMapa'
      },
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) {
            return Container(
              child: Icon(Icons.location_on, size: 70, color: Theme.of(context).primaryColor,),
            );
          }
        ),
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
      //tipos de id para los mapas : streets,dark,light, outdoors, satellite
      // ciclo entre los tipos de mapa
        if (tipoMapa == 'streets') {
          tipoMapa = 'dark';
        } else  if (tipoMapa == 'dark') {
          tipoMapa = 'light';
        } else if (tipoMapa == 'light') {
          tipoMapa = 'outdoors';
        } else if (tipoMapa == 'outdoors') {
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }
        setState(() {
        });
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}