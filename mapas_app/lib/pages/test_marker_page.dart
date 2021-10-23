import 'package:flutter/material.dart';
import 'package:mapas_app/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: MarkerInicioPainter(250),
            //  painter: MarkerDetinoPainter(
            //    'Mi casa por algún lado del mundo, esta aquí, asdasd asdasd',
            //    250904
            //  ),
          ),
        ),
      ),
    );
  }
}
