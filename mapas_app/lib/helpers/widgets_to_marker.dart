part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerInicioIcon(int segundos) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final minutos = (segundos / 60).floor();

  final markerInicio = MarkerInicioPainter(minutos);
  markerInicio.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(
      byteData?.buffer.asUint8List() ?? Uint8List(0));
}

Future<BitmapDescriptor> getMarkerDestinoIcon(
    String descripcion, double metros) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final markerDestino = MarkerDestinoPainter(descripcion, metros);
  markerDestino.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(
      byteData?.buffer.asUint8List() ?? Uint8List(0));
}
