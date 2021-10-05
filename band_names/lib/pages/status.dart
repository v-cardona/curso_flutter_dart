import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Server status: ${socketService.serverStatus}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.emit(
            'emitir-mensaje',
            {
              'nombre': 'flutter',
              'mensaje': 'Hola desde flutter',
            },
          );
        },
        elevation: 1,
        child: const Icon(Icons.message),
      ),
    );
  }
}
