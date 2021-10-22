part of 'helpers.dart';

void calcularAlerta(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Espere por favor'),
          content: Text('Calculando ruta'),
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text('Espere por favor'),
          content: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
